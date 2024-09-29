
import 'package:flutter/material.dart';
import 'package:clocker/Components/color.dart';
class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: primaryColor
        ),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(text,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
