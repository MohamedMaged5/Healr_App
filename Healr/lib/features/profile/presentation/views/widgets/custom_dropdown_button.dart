import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hintText,
    required this.labelText,
  });

  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final String labelText;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    final uniqueItems = widget.items.toSet().toList();

    final validSelectedValue = widget.selectedValue != null &&
            uniqueItems.contains(widget.selectedValue)
        ? widget.selectedValue
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 8.h,
            left: 4.w,
          ),
          child: Text(
            widget.labelText,
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: kHintColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      widget.hintText,
                      style: Styles.textStyle14.copyWith(
                        fontWeight: FontWeight.w400,
                        color: kSignIconColor,
                      ),
                    ),
                    items: uniqueItems
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: validSelectedValue,
                    onChanged: widget.onChanged,
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8.0),
                      height: 40,
                      width: double.infinity,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
