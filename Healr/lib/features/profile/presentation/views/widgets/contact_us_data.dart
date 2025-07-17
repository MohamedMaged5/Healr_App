import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ContactItem {
  final String title;
  final IconData icon;
  final String url;

  ContactItem({
    required this.title,
    required this.icon,
    required this.url,
  });
}

final List<ContactItem> contactItems = [
  ContactItem(
    title: "Customer Service",
    icon: HugeIcons.strokeRoundedCustomerService,
    url: "tel:+201234567890",
  ),
  ContactItem(
    title: "Email us",
    icon: HugeIcons.strokeRoundedMailAtSign01,
    url: "mailto:support@healr.com",
  ),
  ContactItem(
    title: "Facebook",
    icon: HugeIcons.strokeRoundedFacebook01,
    url: "https://facebook.com/HealrApp",
  ),
  ContactItem(
    title: "X",
    icon: HugeIcons.strokeRoundedNewTwitter,
    url: "https://twitter.com/HealrApp",
  ),
  ContactItem(
    title: "Instagram",
    icon: HugeIcons.strokeRoundedInstagram,
    url: "https://www.instagram.com/HealrApp",
  ),
];
