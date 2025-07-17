import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/presentation/managers/booking/booking_cubit.dart';

void showLogoutSheet(
  BuildContext context,
) {
  showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24.h),
          Text(
            'Log out',
            style: Styles.textStyle24.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Are you sure you want to logout?',
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 36.w,
                    right: 8.w,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: BorderSide(
                          color: kSecondaryColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: kSecondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8.w,
                    right: 36.w,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      SharedPrefCache.removeCache(key: 'token');
                      SharedPrefCache.removeCache(key: 'name');
                      SharedPrefCache.removeCache(key: 'nationalID');
                      SharedPrefCache.removeCache(key: 'image');
                      SharedPrefCache.removeCache(key: 'email');
                      SharedPrefCache.removeCache(key: 'phone');
                      SharedPrefCache.removeCache(key: 'gender');
                      SharedPrefCache.removeCache(key: 'date');
                      SharedPrefCache.removeCache(key: 'blood');
                      SharedPrefCache.removeCache(key: 'notes');

                      // Clear ALL booking data on logout
                      await BlocProvider.of<BookingCubit>(context)
                          .clearUserBookingState();
                      print('Logout successful - All booking data cleared');

                      GoRouter.of(context).pushReplacement(
                        AppRouter.kLoginView,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Yes, logout',
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      );
    },
  );
}
