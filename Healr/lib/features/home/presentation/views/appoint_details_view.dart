import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/presentation/views/widgets/appoint_details_view_body.dart';

class AppointDetailsView extends StatelessWidget {
  const AppointDetailsView({super.key});

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
    return AppointDetailsViewBody(
      data: data,
      appointDetails: appointDetails,
    );
  }
}
