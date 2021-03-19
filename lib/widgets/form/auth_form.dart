import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formKey.currentState.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(8),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty || !value.contains("@")) {
                      return "Informe um endereço de email válido.";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email"),
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return "Informe um usuário com no mínimo 4 caracteres.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: "Usuário"),
                  onSaved: (value) {
                    _userName = value;
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return "Informe uma senha com no mínimo 7 caracteres.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: "Senha"),
                  obscureText: true,
                  onSaved: (value) {
                    _userPassword = value;
                  },
                ),
                SizedBox(height: 12),
                RaisedButton(
                  child: Text("Login"),
                  onPressed: () {
                    _trySubmit();
                  },
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {},
                  child: Text("Criar Conta"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
