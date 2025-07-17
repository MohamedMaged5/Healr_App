import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class DateTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final ValueChanged<DateTime?>? onDateSelected;

  const DateTextField({
    super.key,
    this.hintText = 'DD/MM/YYYY',
    this.labelText = 'Date of Birth',
    this.controller,
    this.onDateSelected,
  });

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
  }

  void _showDatePicker() {
    BottomPicker.date(
      pickerTitle: Text(
        'Set your Birthday',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: kSecondaryColor,
        ),
      ),
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime.now(),
      maxDateTime: DateTime.now(),
      minDateTime: DateTime(1920),
      pickerTextStyle: TextStyle(
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      bottomPickerTheme: BottomPickerTheme.blue,
      onSubmit: (selectedDate) {
        final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);

        setState(() {
          _internalController.text = formattedDate;
        });
        widget.onDateSelected?.call(selectedDate);
      },
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            widget.labelText,
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _internalController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: Styles.textStyle14.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: IconButton(
              onPressed: _showDatePicker,
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedCalendar01,
                color: Colors.black,
                size: 24,
              ),
            ),
            border: _outlineInputBorder(const Color(0xffCCCCCC)),
            focusedBorder: _outlineInputBorder(kSecondaryColor),
            errorBorder: _outlineInputBorder(kErrorColor),
            focusedErrorBorder: _outlineInputBorder(kErrorColor),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }
}
