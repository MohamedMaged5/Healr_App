import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/appoint_cache.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/presentation/managers/selected_day/selected_day_cubit.dart';

class AppointDayItem extends StatelessWidget {
  final String? text1;
  final String? text2;

  final int? index;

  const AppointDayItem({
    super.key,
    this.text1,
    this.text2,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedDayCubit, SelectedDayState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<SelectedDayCubit>(context).selectDay(index);
            appointDay = text2;
          },
          child: Container(
            width: 92.w,
            height: 60.h,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: context.watch<SelectedDayCubit>().selectedIndexDay == index
                  ? kSecondaryColor
                  : Colors.white,
              border:
                  context.watch<SelectedDayCubit>().selectedIndexDay == index
                      ? Border.all(width: 0.w)
                      : Border.all(
                          width: 1.w,
                          color: const Color(0xffCCCCCC),
                        ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      text1 ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Styles.textStyle14.copyWith(
                        fontWeight: FontWeight.w400,
                        color: context
                                    .watch<SelectedDayCubit>()
                                    .selectedIndexDay ==
                                index
                            ? const Color(0xffF2F2F2)
                            : const Color(0xffB3B3B3),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      text2 ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context
                                    .watch<SelectedDayCubit>()
                                    .selectedIndexDay ==
                                index
                            ? const Color(0xffF8F8F8)
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
