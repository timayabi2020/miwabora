import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  final Function()? press;
  const ResetPassword({
    Key? key,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          // onTap: press,
          child: Text(
            "Forgot password?",
            style: TextStyle(
              shadows: [Shadow(color: Colors.green, offset: Offset(0, -5))],
              color: Colors.transparent,
              fontWeight: FontWeight.bold,
              //decoration: TextDecoration.underline,
              //decorationColor: Colors.green,
              //decorationThickness: 2,
            ),
          ),
        )
      ],
    );
  }
}
