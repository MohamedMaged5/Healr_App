import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/appoint_cache.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/presentation/managers/selected_time/selected_time_cubit.dart';

class AppointTimeItem extends StatelessWidget {
  final String? text;
  final int? index;

  const AppointTimeItem({
    super.key,
    this.index,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedTimeCubit, SelectedTimeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<SelectedTimeCubit>(context).selectTime(index);
            appointTime = text;
          },
          child: Container(
            width: 100.w,
            height: 44.h,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color:
                  context.watch<SelectedTimeCubit>().selectedIndexTime == index
                      ? kSecondaryColor
                      : Colors.white,
              border:
                  context.watch<SelectedTimeCubit>().selectedIndexTime == index
                      ? Border.all(width: 0.w)
                      : Border.all(
                          width: 1.w,
                          color: const Color(0xffCCCCCC),
                        ),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(text ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context
                                  .watch<SelectedTimeCubit>()
                                  .selectedIndexTime ==
                              index
                          ? const Color(0xffF8F8F8)
                          : Colors.black,
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
