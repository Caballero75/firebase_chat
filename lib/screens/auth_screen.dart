import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String userName,
    String password,
    bool isLogin,
  ) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await Firestore.instance
            .collection("users")
            .document(authResult.user.uid)
            .setData({
          'username': userName,
          'email': email,
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _isLoading = false;
      });

      var message = "Ocorreu um erro";
      if (e.message != null) {
        message = e.message;
      }
      print(message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 20,
          duration: Duration(seconds: 5),
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 20,
          duration: Duration(seconds: 5),
          content: Text(e.toString()),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
