import 'package:auth/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  buildEmailFormField(),
                  SizedBox(height: 25.0),
                  buildPasswordFormField(),
                  SizedBox(height: 20.0),
                  submitButton(),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don’t have an account? "),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () => widget.toggleView(),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => _email = value,
      validator: (value) {
        if (value.isNotEmpty) {
          if (!EmailValidator.validate(value)) {
            return 'Please enter a valid email';
          }
        } else {
          return 'Please enter an email';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) => _password = value,
      validator: (value) {
        if (value.isNotEmpty) {
          if (value.length < 6) {
            return 'Please enter a longer password (>5)';
          }
        } else {
          return 'Please enter a password';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _auth.signInWithEmailAndPassword(_email, _password);
        }
      },
      child: Text('Login'),
    );
  }
}
