import 'package:flutter/material.dart';

/*
It's a rounded button. That's all.
 */
class RoundedButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;

  const RoundedButton(
      {@required this.title, @required this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
