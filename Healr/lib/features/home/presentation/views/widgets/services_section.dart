import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/location_service.dart';
import 'package:healr/features/home/presentation/managers/booking/booking_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/custom_card.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomCard(
                imgUrl: 'assets/images/component1.svg',
                title: 'Book appointment',
                subtitle: 'Just a few taps to book your next appointment.',
                onTap: () {
                  bool hasActiveBooking = BlocProvider.of<BookingCubit>(context)
                      .isAppointmentBookedForCurrentUserSync();
                  if (hasActiveBooking) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                        content: Text('You already have an active booking.'),
                      ),
                    );
                    return;
                  }
                  GoRouter.of(context).push(AppRouter.kBookAppointView);
                },
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomCard(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kTestResultsView);
                },
                imgUrl: 'assets/images/component2.svg',
                title: 'Test/scans results',
                subtitle: 'View your test results and scans instantly.',
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomCard(
                imgUrl: 'assets/images/map.svg',
                title: 'Find a clinic',
                subtitle: 'Find clinics near you and book an appointment.',
                onTap: () {
                  if (LocationService.isPermissionGranted()) {
                    GoRouter.of(context).push(AppRouter.kMapView);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Location permission required'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomCard(
                imgUrl: 'assets/images/component4.svg',
                title: 'Our doctors',
                subtitle:
                    'Find doctors in various fields and book with just a few taps.',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kOurDoctorsView);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
