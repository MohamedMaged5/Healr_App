import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healr/core/utils/location_service.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/presentation/views/widgets/bottom_nav_bar.dart';
import 'package:healr/features/profile/data/repo/health_insurance_repo/health_insurance_repo_imp.dart';
import 'package:healr/features/profile/presentation/manager/health_insurance_cubit/cubit/health_insurance_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, this.data, this.appointDetails});

  final Datum? data;
  final AppointDetailsModel? appointDetails;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    // Request location permission once when home screen loads
    LocationService.requestPermissionOnce();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HealthInsuranceCubit(
        getIt.get<HealthInsuranceRepoImp>(),
      )..getHealthInsurance(),
      child: SafeArea(
        child: CustomNavBar(
          data: widget.data,
          appointDetails: widget.appointDetails,
        ),
      ),
    );
  }
}
