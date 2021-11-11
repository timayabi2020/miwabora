import 'package:flutter/material.dart';
import 'package:miwabora/constants.dart';

class UtilityText extends StatelessWidget {
  final Function()? press;
  final String text;
  const UtilityText({Key? key, this.press, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
