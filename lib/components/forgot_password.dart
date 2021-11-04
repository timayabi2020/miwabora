import 'package:flutter/material.dart';
import 'package:miwabora/constants.dart';

class ResetPassword extends StatelessWidget {
  final Function()? press;
  final String text;
  const ResetPassword({Key? key, this.press, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          // onTap: press,
          child: Text(
            text.toString(),
            style: TextStyle(
              shadows: [Shadow(color: kPrimaryColor, offset: Offset(0, -5))],
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
