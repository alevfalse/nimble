import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:nimble/components/rounded_button.dart';
import 'package:nimble/constants.dart';
import 'package:nimble/screens/chat_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static final String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  void showInvalidLoginCredentialsAlert() {
    Alert(
      context: context,
      title: 'Invalid email or password',
      desc:
          'The email or password you have entered do not match or may not exist.',
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: kPrimaryLightColor,
          child: Text(
            'OK',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: Colors.blueGrey,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 160.0,
                    child: Image.asset('images/lightning_pink.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Hero(
                tag: 'login_button',
                child: RoundedButton(
                  title: 'Log In',
                  color: kPrimaryLightColor,
                  onPressed: () async {
                    print('Email: $email\nPassword: $password');

                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final authResult = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);

                      if (authResult.user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      } else {
                        showInvalidLoginCredentialsAlert();
                      }
                    } catch (e) {
                      print(e);

                      showInvalidLoginCredentialsAlert();
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
