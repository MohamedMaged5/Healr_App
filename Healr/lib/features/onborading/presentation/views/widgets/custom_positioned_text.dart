import 'package:flutter/material.dart';
import 'package:healr/core/utils/styles.dart';

class CustomPositionedText extends StatelessWidget {
  const CustomPositionedText({
    super.key,
    required this.bottom,
    required this.left,
    required this.right,
    required this.text,
  });

  final double bottom, left, right;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      right: right,
      child: Text(
        text,
        style: Styles.textStyle22.copyWith(
          color: const Color(0xFF000000),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
