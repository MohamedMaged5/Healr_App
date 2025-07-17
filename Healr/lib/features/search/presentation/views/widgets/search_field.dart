import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/search/presentation/managers/search_cubit/search_cubit.dart';

class SearchField extends StatefulWidget {
  final TextEditingController? controller;

  const SearchField({
    super.key,
    this.controller,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    // Only dispose if we created the controller internally
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: "Search for a doctor",
        hintStyle: Styles.textStyle16.copyWith(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: const Color(0xff999999),
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: kSecondaryColor,
            width: 1.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: const Color(0xff999999),
            width: 1.w,
          ),
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          BlocProvider.of<SearchCubit>(context).nameSearch(value);
        } else if (value.contains("")) {
          BlocProvider.of<SearchCubit>(context).reset();
        } else {
          BlocProvider.of<SearchCubit>(context).reset();
        }
      },
    );
  }
}
