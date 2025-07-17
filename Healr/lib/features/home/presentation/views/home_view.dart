import 'package:flutter/material.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/presentation/views/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.data, this.appointDetails});
  
  final Datum? data;
  final AppointDetailsModel? appointDetails;

  @override
  Widget build(BuildContext context) {
    return HomeViewBody(
      data: data,
      appointDetails: appointDetails,
    );
  }
}
