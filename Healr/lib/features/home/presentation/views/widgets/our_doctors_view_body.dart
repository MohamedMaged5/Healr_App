import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_back_button.dart';
import 'package:healr/core/widgets/doctor_card.dart';
import 'package:healr/features/home/presentation/managers/get_doctors/get_doctors_cubit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:healr/features/search/presentation/views/widgets/search_skeletonizer.dart';

class OurDoctorsViewBody extends StatefulWidget {
  const OurDoctorsViewBody({super.key});

  @override
  State<OurDoctorsViewBody> createState() => _OurDoctorsViewBodyState();
}

class _OurDoctorsViewBodyState extends State<OurDoctorsViewBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetDoctorsCubit>(context).allDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LiquidPullToRefresh(
          onRefresh: () async {
            await BlocProvider.of<GetDoctorsCubit>(context).allDoctors();
          },
          height: 100.h,
          color: kSecondaryColor,
          backgroundColor: Colors.white,
          animSpeedFactor: 5,
          showChildOpacityTransition: false,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 30.h),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      const CustomBackButton(
                        marginLeft: 0,
                      ),
                      SizedBox(width: 12.w),
                      Text("Our Doctors",
                          style: Styles.textStyle24.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                BlocBuilder<GetDoctorsCubit, GetDoctorsState>(
                  builder: (context, state) {
                    if (state is GetDoctorsLoading) {
                      return const SliverToBoxAdapter(
                          child: SearchSkeletonizer());
                    } else if (state is GetDoctorsFailure) {
                      return SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3),
                            Text(state.errMessage),
                          ],
                        ),
                      );
                    } else if (state is GetDoctorsSuccess) {
                      return SliverList.builder(
                          itemCount: state.user.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: DoctorCard(
                                doctorName: state.user.data![index].name,
                                doctorSpecialty:
                                    state.user.data![index].specialization,
                                doctorImg: state.user.data![index].image,
                                rating: state.user.data![index].rate,
                                onPressed: () {
                                  GoRouter.of(context).push(
                                    AppRouter.kDoctorProfileView,
                                    extra: state.user.data![index],
                                  );
                                },
                                label: "View Doctor",
                              ),
                            );
                          });
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
