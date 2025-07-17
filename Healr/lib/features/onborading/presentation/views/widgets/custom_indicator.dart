import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required this.pageIndex,
    required this.indicatorPath,
    required this.onIndicatorTap,
  });

  final int pageIndex;
  final String indicatorPath;
  final void Function(int) onIndicatorTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          indicatorPath,
          height: 48.h,
          width: 48.w,
        ),
      ],
    );
  }
}
