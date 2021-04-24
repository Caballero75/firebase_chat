import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  final Key key;

  const MessageBubble({
    this.message,
    this.userName,
    this.userImage,
    this.isMe,
    this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 3,
                    blurRadius: 10,
                    color: Colors.black26,
                    offset: Offset(-3, -3),
                  ),
                ],
                color: isMe
                    ? Theme.of(context).primaryColor.withOpacity(0.4)
                    : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 8,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 108,
                    child: Text(
                      userName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.headline6.color,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: isMe ? 135 : 125,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
