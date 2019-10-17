import 'package:flutter/material.dart';
import 'package:nimble/constants.dart';
import 'package:nimble/screens/chat_screen.dart';
import 'package:nimble/screens/login_screen.dart';
import 'package:nimble/screens/registration_screen.dart';
import 'package:nimble/screens/welcome_screen.dart';

void main() => runApp(Nimble());

class Nimble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('images/lightning_pink.png'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
        accentColor: Colors.lightBlueAccent,
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          body1: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
          body2: TextStyle(
            fontFamily: 'Nunito',
          ),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen()
      },
    );
  }
}
