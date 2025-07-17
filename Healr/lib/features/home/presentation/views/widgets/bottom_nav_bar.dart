import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/presentation/views/widgets/tabs_list.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key, this.data, this.appointDetails});

  final Datum? data;
  final AppointDetailsModel? appointDetails;

  @override
  Widget build(BuildContext context) => PersistentTabView(
        screenTransitionAnimation: const ScreenTransitionAnimation(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 10),
        ),
        gestureNavigationEnabled: true,
        backgroundColor: kPrimaryColor,
        tabs: tabs(data: data, appointDetails: appointDetails),
        navBarBuilder: (navBarConfig) => Style15BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            color: kPrimaryColor,
          ),
        ),
        popAllScreensOnTapAnyTabs: true,
        popAllScreensOnTapOfSelectedTab: false,
        margin: EdgeInsets.only(
          top: 8.h,
        ),
      );
}
