import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/presentation/managers/test_results/test_results_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/test_result_skeleton.dart';
import 'package:healr/features/home/presentation/views/widgets/test_results_app_bar.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class TestResultsViewBody extends StatefulWidget {
  const TestResultsViewBody({super.key});

  @override
  State<TestResultsViewBody> createState() => _TestResultsViewBodyState();
}

class _TestResultsViewBodyState extends State<TestResultsViewBody> {
  @override
  void initState() {
    if (mounted) {
      BlocProvider.of<TestResultsCubit>(context).loadTestResults();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LiquidPullToRefresh(
          onRefresh: () async {
            if (mounted) {
              await BlocProvider.of<TestResultsCubit>(context)
                  .loadTestResults();
            }
          },
          height: 100.h,
          color: kSecondaryColor,
          backgroundColor: Colors.white,
          animSpeedFactor: 5,
          showChildOpacityTransition: false,
          child: ListView(
            children: [
              SizedBox(
                height: 24.h,
              ),
              const TestResultsAppBar(),
              BlocBuilder<TestResultsCubit, TestResultsState>(
                builder: (context, state) {
                  if (state is TestResultsLoading) {
                    return const TestResultSkeleton();
                  } else if (state is TestResultsInitial) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/Blood-test-bro.svg",
                        ),
                        Text("No test results available",
                            style: Styles.textStyle20.copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
