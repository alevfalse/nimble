import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:nimble/components/rounded_button.dart';
import 'package:nimble/constants.dart';
import 'package:nimble/screens/chat_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatefulWidget {
  static final String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  void showInvalidSignupCredentialsAlert() {
    Alert(
      context: context,
      title: 'Registration failed',
      desc:
          'Please enter a valid email address and your password must be at least 6 characters.',
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: kAccentColor,
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
        title: Text('Register'),
        backgroundColor: kAccentColor,
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
                    child: Image.asset('images/lightning_blue.png'),
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
                decoration: kTextFieldAccentDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
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
                decoration: kTextFieldAccentDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Hero(
                tag: 'register_button',
                child: RoundedButton(
                  title: 'Register',
                  color: kAccentColor,
                  onPressed: () async {
                    print('Email: $email\nPassword: $password');

                    setState(() {
                      showSpinner = true;
                    });

                    try {
                      final authResult =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      if (authResult.user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      } else {
                        showInvalidSignupCredentialsAlert();
                      }
                    } catch (e) {
                      print(e);
                      showInvalidSignupCredentialsAlert();
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
