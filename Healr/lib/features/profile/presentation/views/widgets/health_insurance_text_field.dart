import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';

class HealthInsuranceTextField extends StatefulWidget {
  const HealthInsuranceTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.controller,
    this.onTap,
    this.validator,
    this.errorText,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String hintText, labelText;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final String? errorText;

  final FocusNode? focusNode;
  @override
  State<HealthInsuranceTextField> createState() =>
      _HealthInsuranceTextFieldState();
}

class _HealthInsuranceTextFieldState extends State<HealthInsuranceTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.labelText,
                style: Styles.textStyle18.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff1A1A1A),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            focusNode: widget.focusNode,
            controller: widget.controller,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: Styles.textStyle14.copyWith(
                color: const Color(0xff666666).withOpacity(0.6),
                fontWeight: FontWeight.w400,
              ),
              border: _outlineInputBorder(const Color(0xffCCCCCC)),
              enabledBorder: _outlineInputBorder(const Color(0xffCCCCCC)),
              focusedBorder: _outlineInputBorder(kSecondaryColor),
              errorBorder: _outlineInputBorder(kErrorColor),
              focusedErrorBorder: _outlineInputBorder(kErrorColor),
            ),
          ),
          if (widget.errorText != null && widget.errorText!.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 18.w,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    widget.errorText!,
                    style: Styles.textStyle12.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }
}
