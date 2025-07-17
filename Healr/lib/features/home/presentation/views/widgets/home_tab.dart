import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/presentation/managers/booking/booking_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/custom_row.dart';
import 'package:healr/features/home/presentation/views/widgets/health_insurance_section.dart';
import 'package:healr/features/home/presentation/views/widgets/home_header_section.dart';
import 'package:healr/features/home/presentation/views/widgets/services_section.dart';
import 'package:healr/features/home/presentation/views/widgets/waiting_people_section.dart';
import 'package:healr/features/home/presentation/views/widgets/waitingpeople_skeletonizer.dart';
import 'package:healr/features/profile/presentation/manager/health_insurance_cubit/cubit/health_insurance_cubit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

PersistentTabConfig homeTab(
    {Datum? data, AppointDetailsModel? appointDetails}) {
  return PersistentTabConfig(
    screen: HomeTabContent(data: data, appointDetails: appointDetails),
    item: ItemConfig(
      activeForegroundColor: const Color(0xff3A95D2),
      inactiveForegroundColor: kHintColor,
      icon: SvgPicture.asset(
        "assets/images/home-1.svg",
        width: 32.w,
        height: 32.h,
      ),
      inactiveIcon: SvgPicture.asset(
        "assets/images/home.svg",
        width: 32.w,
        height: 32.h,
      ),
      title: "Home",
      textStyle: Styles.textStyle12.copyWith(
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

class HomeTabContent extends StatefulWidget {
  const HomeTabContent({super.key, this.data, this.appointDetails});

  final Datum? data;
  final AppointDetailsModel? appointDetails;

  @override
  State<HomeTabContent> createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<HomeTabContent> {
  @override
  void initState() {
    super.initState();
    // Only call book() if not already in BookingSuccess state
    if (BlocProvider.of<BookingCubit>(context).state is BookingSuccess) {
      return;
    }
    BlocProvider.of<BookingCubit>(context).book();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LiquidPullToRefresh(
        onRefresh: () async {
          BlocProvider.of<HealthInsuranceCubit>(context).getHealthInsurance();
          if (BlocProvider.of<BookingCubit>(context).state is BookingSuccess) {
            return;
          }
          BlocProvider.of<BookingCubit>(context).book();
        },
        height: 100.h,
        color: kSecondaryColor,
        backgroundColor: Colors.white,
        animSpeedFactor: 5,
        showChildOpacityTransition: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomScrollView(
            slivers: [
              // ...existing code...
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 24.h,
                ),
              ),
              const SliverToBoxAdapter(
                child: HomeHeaderSection(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 24.h,
                ),
              ),
              BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return const SliverToBoxAdapter(
                      child: WaitingpeopleSkeletonizer(),
                    );
                  } else if (state is BookingFailure) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(),
                    );
                  } else if (state is BookingSuccess) {
                    return SliverToBoxAdapter(
                      child: WaitingPeopleSection(
                        appointDetails: widget.appointDetails,
                        data: widget.data,
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(
                    child: SizedBox(),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 16.h,
                ),
              ),
              const SliverToBoxAdapter(
                child: HealthInsuranceSection(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 16.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  "What would you like to do?",
                  style: Styles.textStyle18.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(
                      0xff1A1A1A,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 16.h,
                ),
              ),
              const SliverToBoxAdapter(
                child: ServicesSection(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 16.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  "Explore more services",
                  style: Styles.textStyle18.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff1A1A1A),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 8.h,
                ),
              ),
              const SliverToBoxAdapter(
                child: CustomRow(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 8.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Builder(
                  builder: (context) => viewMore(context),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 16.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget viewMore(BuildContext context) {
  return GestureDetector(
    onTap: () {
      GoRouter.of(context).push(AppRouter.kSearchview);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "View More",
          style: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xff3A95D2),
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 20.w,
          color: const Color(0xff3A95D2),
        ),
      ],
    ),
  );
}
