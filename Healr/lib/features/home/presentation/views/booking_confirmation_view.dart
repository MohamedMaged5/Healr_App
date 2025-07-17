import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/data/repos/appoint_repo_imp.dart';
import 'package:healr/features/home/presentation/managers/Appointment/appointment_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/booking_confirmation_view_body.dart';

class BookingConfirmationView extends StatelessWidget {
  const BookingConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra;

    Datum? data;
    AppointDetailsModel? appointDetails;

    if (extra is Map<String, dynamic>) {
      data = extra['data'] as Datum?;
      appointDetails = extra['appointDetails'] as AppointDetailsModel?;
    } else if (extra is Datum) {
      // For backward compatibility
      data = extra;
    }

    return BlocProvider(
      create: (context) => AppointmentCubit(getIt.get<AppointRepoImp>()),
      child: BookingConfirmationViewBody(
        data: data,
        appointDetails: appointDetails,
      ),
    );
  }
}
