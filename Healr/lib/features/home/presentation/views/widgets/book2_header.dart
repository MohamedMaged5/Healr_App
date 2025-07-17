import 'package:flutter/material.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_back_button.dart';

class Book2Header extends StatelessWidget {
  final String title;
  const Book2Header({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: CustomBackButton(
            marginLeft: 0,
          ),
        ),
        Center(
          child: Text(
            title,
            style: Styles.textStyle20.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
