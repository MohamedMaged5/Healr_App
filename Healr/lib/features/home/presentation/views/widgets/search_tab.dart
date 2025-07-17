import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/search/presentation/views/search_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

PersistentTabConfig searchTab() {
  return PersistentTabConfig(
    screen: const SearchView(),
    item: ItemConfig(
      activeForegroundColor: const Color(0xff3A95D2),
      inactiveForegroundColor: kHintColor,
      icon: SvgPicture.asset(
        "assets/images/search-1.svg",
        width: 32.w,
        height: 32.h,
      ),
      inactiveIcon: SvgPicture.asset(
        "assets/images/search.svg",
        width: 32.w,
        height: 32.h,
      ),
      title: "Search",
      textStyle: Styles.textStyle12.copyWith(
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
