class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

final List<FAQItem> faqItems = [
  FAQItem(
    question: "What is healr Chatbot, and how does it work?",
    answer:
        "The chatbot analyzes the symptoms that the user writes and suggests potential diseases based on those symptoms. It also directs the user to the appropriate medical specialty.",
  ),
  FAQItem(
    question: "Can I reschedule or cancel an appointment?",
    answer:
        "Yes, you can easily reschedule or cancel appointments through the platform. Just go to your bookings, select the appointment, and make the necessary changes.",
  ),
  FAQItem(
    question: "Is healr Chatbot a replacement for a doctor?",
    answer:
        "No, it is not a replacement. It just helps you decide which doctor to go to.",
  ),
  FAQItem(
    question: "How do I contact customer support?",
    answer:
        "You can contact customer support through the app or website. Look for the 'Contact Us' section for more details.",
  ),
  FAQItem(
    question: "Is my personal information secure?",
    answer:
        "Yes, we take your privacy seriously. Your personal information is stored securely and is not shared with third parties without your consent.",
  ),
  FAQItem(
    question: "What should I do if I forget my password?",
    answer:
        "If you forget your password, you can reset it by clicking on the 'Forgot Password' link on the login page.",
  ),
  FAQItem(
    question: "How can I provide feedback about the app?",
    answer:
        "We welcome your feedback! You can provide it through the 'Feedback' section in the app or by contacting customer support.",
  ),
  FAQItem(
    question: "How do I update my profile information?",
    answer:
        "You can update your profile information by going to the 'Profile' section in the app and editing your details.",
  ),
  FAQItem(
    question: "What payment methods are accepted?",
    answer:
        "We accept various payment methods, including credit/debit cards, online banking, and mobile wallets.",
  ),
  FAQItem(
    question: "Can I use healr Chatbot for emergency situations?",
    answer:
        "No, healr Chatbot is not designed for emergency situations. Please contact emergency services or visit the nearest hospital for urgent medical needs.",
  ),
  FAQItem(
    question: "Is the app available in multiple languages?",
    answer:
        "Currently, the app is available in English, but we are working on adding support for more languages in the future.",
  ),


];
