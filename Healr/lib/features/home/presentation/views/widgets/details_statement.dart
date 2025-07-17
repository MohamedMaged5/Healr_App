import 'package:flutter/material.dart';
import 'package:healr/core/utils/styles.dart';

class DetailsStatement extends StatelessWidget {
  final String label;
  final String detail;
  const DetailsStatement({
    super.key,
    required this.label,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
              color: const Color(0xff666666),
            )),
        const Spacer(),
        Text(detail,
            overflow: TextOverflow.ellipsis,
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}
