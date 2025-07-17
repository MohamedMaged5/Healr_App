import 'package:flutter/material.dart';

class CustomTextSpan extends StatelessWidget {
  const CustomTextSpan({
    super.key,
    required this.text1,
    required this.text2,
    required this.text1Style,
    required this.text2Style,
  });

  final String text1, text2;
  final TextStyle text1Style , text2Style;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: text1, style: text1Style),
          TextSpan(text: text2, style: text2Style),
        ],
      ),
    );
  }
}
