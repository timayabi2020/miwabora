import 'package:flutter/material.dart';
import 'package:miwabora/constants.dart';

class GeneralTextComponent extends StatelessWidget {
  final Function()? press;
  final String text;
  const GeneralTextComponent({Key? key, this.press, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
            child: GestureDetector(
          onTap: press,
          // onTap: press,

          child: Text(
            text.toString(),
            maxLines: 20,
            style: TextStyle(
              shadows: [Shadow(color: kPrimaryColor, offset: Offset(0, -5))],
              color: Colors.transparent,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: kPrimaryColor,
              decorationThickness: 2,
            ),
          ),
        ))
      ],
    );
  }
}
