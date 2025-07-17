import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'contact_us_data.dart';

class ContactUsSection extends StatefulWidget {
  const ContactUsSection({super.key});

  @override
  State<ContactUsSection> createState() => _ContactUsSectionState();
}

class _ContactUsSectionState extends State<ContactUsSection> {
  int? expandedIndex;

  void _shareURL(String url) {
    Share.share(url);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: contactItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isExpanded = expandedIndex == index;

        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              onExpansionChanged: (expanded) {
                setState(() {
                  expandedIndex = expanded ? index : null;
                });
              },
              trailing: AnimatedRotation(
                turns: isExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowDown01,
                  size: 32.sp,
                  color: const Color(0xff1A1A1A),
                ),
              ),
              leading: Icon(
                item.icon,
                size: 24.sp,
                color: const Color(0xff3A95D2),
              ),
              title: Text(
                item.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await launchUrlString(item.url,
                              mode: LaunchMode.externalApplication);
                        },
                        child: Text(
                          item.url,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedShare08,
                          color: kSignIconColor,
                          size: 24.sp,
                        ),
                        onPressed: () => _shareURL(item.url),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
