import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/features/profile/presentation/views/widgets/contact_us_section.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_app_bar.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_expandable_tile.dart';

class HelpCenterViewBody extends StatefulWidget {
  const HelpCenterViewBody({super.key});

  @override
  State<HelpCenterViewBody> createState() => _HelpCenterViewBodyState();
}

class _HelpCenterViewBodyState extends State<HelpCenterViewBody> {
  int selectedIndex = 0;

  final List<String> tabs = ['FAQs', 'Contact Us'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            child: Column(
              children: [
                const CustomAppBar(
                  text: "Help Center",
                ),
                Padding(
                  padding: EdgeInsets.only(top: 32.h),
                  child: Column(
                    children: [
                      Row(
                        children: List.generate(tabs.length, (index) {
                          final isSelected = index == selectedIndex;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => selectedIndex = index);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    tabs[index],
                                    style: TextStyle(
                                      color: isSelected
                                          ? const Color(0xff3A95D2)
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Stack(
                                    children: [
                                      Divider(
                                        color: isSelected
                                            ? const Color(0xff3A95D2)
                                            : kHintColor.withOpacity(0.4),
                                        thickness: 2,
                                      ),
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 10),
                                        height: 4.h,
                                        width: 200.w,
                                        margin: EdgeInsets.only(top: 4.h),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? const Color(0xff3A95D2)
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 32.h),
                      if (selectedIndex == 0)
                        const ExpandleContainer()
                      else
                        const ContactUsSection()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
