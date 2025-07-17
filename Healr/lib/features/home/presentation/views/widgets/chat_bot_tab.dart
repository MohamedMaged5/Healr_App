import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/chatbot/presentation/views/chatbot_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

PersistentTabConfig chatBotTab() {
  return PersistentTabConfig(
    screen: const ChatbotView(),
    item: ItemConfig(
        activeForegroundColor: Colors.transparent,
        inactiveForegroundColor: const Color.fromARGB(255, 9, 175, 87),
        icon: SvgPicture.asset(
          "assets/images/chat-bot.svg",
          width: 42.w,
          height: 42.h,
        ),
        inactiveIcon: SvgPicture.asset(
          "assets/images/chat-bot2.svg",
          width: 45.w,
          height: 45.h,
        ),
        textStyle: Styles.textStyle12.copyWith(
          fontWeight: FontWeight.w500,
        )),
  );
}
