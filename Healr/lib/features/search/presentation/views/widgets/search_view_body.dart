import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/search_to_home_datum.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/doctor_card.dart';
import 'package:healr/features/search/presentation/managers/search_cubit/search_cubit.dart';
import 'package:healr/features/search/presentation/views/widgets/search_by_specialties.dart';
import 'package:healr/features/search/presentation/views/widgets/search_field.dart';
import 'package:healr/features/search/presentation/views/widgets/search_skeletonizer.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPendingSearch();
    });
  }

  void _checkPendingSearch() {
    if (pendingSearchQuery != null && pendingSearchQuery!.isNotEmpty) {
      searchController.clear();
      if (mounted) {
        BlocProvider.of<SearchCubit>(context)
            .specialtiesSearch(pendingSearchQuery!);

        pendingSearchQuery = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check for pending search every time the widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});

      _checkPendingSearch();
    });
    return SafeArea(
      child: Scaffold(
          body: LiquidPullToRefresh(
        onRefresh: () async {
          searchController.clear();

          BlocProvider.of<SearchCubit>(context).reset();
        },
        height: 100.h,
        color: kSecondaryColor,
        backgroundColor: Colors.white,
        animSpeedFactor: 5,
        showChildOpacityTransition: false,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 32.h),
          child: ListView(
            children: [
              Text("Search for a doctor",
                  style:
                      Styles.textStyle24.copyWith(fontWeight: FontWeight.w600)),
              SizedBox(height: 16.h),
              SearchField(controller: searchController),
              SizedBox(height: 16.h),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const SearchBySpecialties();
                  } else if (state is SearchLoading) {
                    return const SearchSkeletonizer();
                  } else if (state is SearchFailure) {
                    return Column(
                      children: [
                        SizedBox(height: 270.h),
                        Text(state.errMessage,
                            textAlign: TextAlign.center,
                            style: Styles.textStyle16.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                      ],
                    );
                  } else if (state is SearchSuccessName) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.name.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: DoctorCard(
                            doctorName: state.name.data![index].name!,
                            label: "View Doctor",
                            doctorImg: state.name.data![index].image ?? "",
                            doctorSpecialty:
                                state.name.data![index].specialization ?? "",
                            rating: state.name.data![index].rate ?? 0.0,
                            onPressed: () {
                              final homeDatum = convertSearchDatumToHomeDatum(
                                state.name.data![index],
                              );
                              GoRouter.of(context).push(
                                AppRouter.kDoctorProfileView,
                                extra: homeDatum,
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is SearchSuccessSpecial) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.specialization.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: DoctorCard(
                            doctorName: state.specialization.data![index].name!,
                            label: "View Doctor",
                            doctorImg:
                                state.specialization.data![index].image ?? "",
                            doctorSpecialty: state.specialization.data![index]
                                    .specialization ??
                                "",
                            rating:
                                state.specialization.data![index].rate ?? 0.0,
                            onPressed: () {
                              final homeDatum =
                                  convertSpecializationDatumToHomeDatum(
                                state.specialization.data![index],
                              );
                              GoRouter.of(context).push(
                                AppRouter.kDoctorProfileView,
                                extra: homeDatum,
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              // Add some bottom padding to ensure scrollability
              SizedBox(height: 8.h),
            ],
          ),
        ),
      )),
    );
  }
}
