import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.controller,
    this.obscureText = false,
    this.onChanged,
    this.showForgotPass = false,
    this.onTap,
    this.validator,
    this.errorText,
    this.padding = 16.0,
    this.suffixIcon,
    this.textStyle,
    this.hintStyle,
    this.maxLines = 1,
    this.maxLength = 32,
    this.readOnly = false,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String hintText, labelText;
  final Function(String)? onChanged;
  final bool obscureText;
  final bool showForgotPass;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final String? errorText;
  final double padding;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final int maxLines;
  final int? maxLength;
  final bool readOnly;
  final FocusNode? focusNode;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;

  @override
  void initState() {
    super.initState();
    showPassword = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.labelText,
                style: widget.textStyle ??
                    Styles.textStyle18.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              if (widget.showForgotPass)
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Forgot Password?",
                    style: Styles.textStyle14.copyWith(
                      color: kSignIconColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            focusNode: widget.focusNode,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            controller: widget.controller,
            obscureText: showPassword,
            keyboardType: widget.labelText == 'National Number' ||
                    widget.labelText == 'Phone Number'
                ? TextInputType.number
                : TextInputType.text,
            onChanged: widget.onChanged,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  Styles.textStyle12.copyWith(
                    color: Colors.grey[600],
                  ),
              border: _outlineInputBorder(const Color(0xffCCCCCC)),
              enabledBorder: _outlineInputBorder(const Color(0xffCCCCCC)),
              focusedBorder: widget.readOnly
                  ? _outlineInputBorder(const Color(0xffCCCCCC))
                  : _outlineInputBorder(kSecondaryColor),
              errorBorder: _outlineInputBorder(kErrorColor),
              focusedErrorBorder: _outlineInputBorder(kErrorColor),
              suffixIcon: widget.obscureText
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: SvgPicture.asset(
                        showPassword
                            ? 'assets/images/hide.svg'
                            : 'assets/images/view.svg',
                        height: 24.h,
                        width: 24.w,
                      ),
                    )
                  : widget.suffixIcon,
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
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }
}
