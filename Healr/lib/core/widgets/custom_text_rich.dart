import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';

class CustomTextRich extends StatelessWidget {
  const CustomTextRich(
      {super.key, required this.text1, required this.text2, this.onTapText2});
  final String text1, text2;
  final Function()? onTapText2;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text1,
        style: Styles.textStyle16.copyWith(
          fontWeight: FontWeight.w500,
          color: const Color(0xff4D4D4D),
        ),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTapText2,
            text: text2,
            style: Styles.textStyle16.copyWith(
              color: kSecondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
