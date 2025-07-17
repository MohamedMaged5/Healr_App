import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16).r,
        margin: const EdgeInsets.all(8).r,
        decoration: BoxDecoration(
          color: const Color(0xffBFDBFE),
          borderRadius: BorderRadius.all(const Radius.circular(24).r),
        ),
        child: Text(
          message,
          style: Styles.textStyle14.copyWith(
              color: const Color(0xff1A1A1A), fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class CHatBubbleOthers extends StatelessWidget {
  final String message;
  final bool isLoading;
  const CHatBubbleOthers({
    super.key,
    required this.message,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset("assets/images/chat-bot2.svg"),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(16).r,
              margin: const EdgeInsets.all(8).r,
              decoration: BoxDecoration(
                color: const Color(0xffEFF6FF),
                borderRadius: BorderRadius.all(const Radius.circular(24).r),
              ),
              child: isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator(
                        color: kSecondaryColor,
                        strokeWidth: 3,
                      ),
                    )
                  : Text(
                      message,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff1A1A1A),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
