import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:hugeicons/hugeicons.dart';

class ProfileCustomRow extends StatefulWidget {
  const ProfileCustomRow({
    super.key,
    this.color = const Color(0xff133953),
    required this.icon,
    this.textColor = const Color(0xff1A1A1A),
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color textColor;
  final String text;
  final Function()? onTap;

  @override
  State<ProfileCustomRow> createState() => _ProfileCustomRowState();
}

class _ProfileCustomRowState extends State<ProfileCustomRow> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: widget.onTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HugeIcon(
              icon: widget.icon,
              color: widget.color,
              size: 24,
            ),
            SizedBox(width: 16.w),
            Text(
              widget.text,
              style: Styles.textStyle18.copyWith(
                fontWeight: FontWeight.w500,
                color: widget.textColor,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xff1C567D),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
