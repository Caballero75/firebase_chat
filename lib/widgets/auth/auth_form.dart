import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    bool isLogin,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Center(
        child: Card(
          margin: EdgeInsets.all(8),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    CircleAvatar(
                      radius: 40,
                    ),
                  TextFormField(
                    key: ValueKey("email"),
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
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("userName"),
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
                    key: ValueKey("userPassword"),
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
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? "Entrar" : "Criar Conta"),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child:
                          Text(_isLogin ? "Criar Conta" : "Já tenho uma conta"),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
