import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:hugeicons/hugeicons.dart';

class FAQItem {
  final String question;
  final String answer;
  bool isExpanded;

  FAQItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}

class ExpandleContainer extends StatefulWidget {
  const ExpandleContainer({super.key});

  @override
  State<ExpandleContainer> createState() => _ExpandleContainerState();
}

class _ExpandleContainerState extends State<ExpandleContainer> {
  final List<FAQItem> faqs = [
    FAQItem(
      question: "What is healr Chatbot, and how does it work?",
      answer:
          "The chatbot analyzes the symptoms that the user writes and suggests potential diseases based on those symptoms.",
    ),
    FAQItem(
      question: "Can I reschedule or cancel an appointment?",
      answer:
          "Yes, you can easily reschedule or cancel appointments through the platform...",
    ),
    FAQItem(
      question: "Is healr Chatbot a replacement for a doctor?",
      answer:
          "No, the chatbot is not a replacement for a doctor. It provides suggestions only.",
    ),
    FAQItem(
      question: "How do I contact customer support?",
      answer:
          "You can contact customer support through the app or website by clicking on the 'Contact Us' section.",
    ),
    FAQItem(
      question: "What should I do if I forget my password?",
      answer:
          "If you forget your password, you can reset it by clicking on the 'Forgot Password' link on the login page.",
    ),
    FAQItem(
      question: "How do I update my profile information?",
      answer:
          "You can update your profile information by going to the 'Profile' section in the app.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: faqs.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = faqs[index];
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 6.h,
            horizontal: 4.w,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    item.question,
                    style: Styles.textStyle12.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff1A1A1A),
                    ),
                  ),
                  trailing: AnimatedRotation(
                    turns: item.isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 100),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowDown01,
                      size: 32,
                      color: const Color(0xff1A1A1A),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      item.isExpanded = !item.isExpanded;
                    });
                  },
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: Column(
                        children: [
                          Divider(
                            color: const Color(0xff1A1A1A).withOpacity(0.1),
                            thickness: 1.5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Text(
                              item.answer,
                              style: Styles.textStyle12.copyWith(
                                  fontWeight: FontWeight.w400,
                                  height: 1.8,
                                  color: kHintColor),
                            ),
                          ),
                        ],
                      )),
                  crossFadeState: item.isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 100),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
