import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  // const ChatScreen({Key key}) : super(key: key);
  final String chatId = "gtfjta1UXYDDCjCPDKF9";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("/chats/$chatId/messages")
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final documents = streamSnapshot.data.documents;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) => Container(
                color: Colors.deepOrangeAccent,
                padding: EdgeInsets.all(8),
                child: Text(documents[index]['text']),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection("/chats/$chatId/messages")
              .add({'text': "teste"});
        },
      ),
    );
  }
}
