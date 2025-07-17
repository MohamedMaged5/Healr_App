import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/repos/appoint_repo_imp.dart';
import 'package:healr/features/home/presentation/managers/Appointment/appointment_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/booking_summary_view_body.dart';

class BookingSummaryView extends StatelessWidget {
  const BookingSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = GoRouterState.of(context).extra as Datum?;
    return BlocProvider(
      create: (context) => AppointmentCubit(getIt.get<AppointRepoImp>()),
      child: BookingSummaryViewBody(
        data: data,
      ),
    );
  }
}
