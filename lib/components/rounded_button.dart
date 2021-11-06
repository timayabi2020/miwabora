import 'package:flutter/material.dart';
import 'package:miwabora/constants.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final double? sizeval;
  final Function()? press;
  final Color? color;
  final Color textColor = Colors.white;

  const RoundedButton(
      {Key? key, this.text, required this.sizeval, this.color, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * sizeval!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(
            text.toString(),
            style: TextStyle(color: textWhiteColor),
          ),
        ),
      ),
    );
  }
}
