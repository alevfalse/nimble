import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:nimble/components/rounded_button.dart';
import 'package:nimble/constants.dart';
import 'package:nimble/screens/login_screen.dart';
import 'package:nimble/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static final id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    animation =
        ColorTween(begin: kAccentColor, end: Colors.white).animate(controller);

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset(
                      'images/lightning_pink.png',
                      height: 80.0,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TypewriterAnimatedTextKit(
                      text: ['Nimble'],
                      textStyle: TextStyle(
                        fontSize: 50.0,
                        color: kAccentColor,
                        height: 0.75,
                      ),
                    ),
                    Text(
                      'Fast AF Chat',
                      style: TextStyle(
                        letterSpacing: 9.0,
                        color: kPrimaryColor,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Hero(
              tag: 'login_button',
              child: RoundedButton(
                title: 'Login',
                color: kPrimaryLightColor,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
            Hero(
              tag: 'register_button',
              child: RoundedButton(
                title: 'Register',
                color: kAccentColor,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Team Enhanced © 2019',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black38,
              ),
            )
          ],
        ),
      ),
    );
  }
}
