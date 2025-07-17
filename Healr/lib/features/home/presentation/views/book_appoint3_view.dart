import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/presentation/managers/selected_day/selected_day_cubit.dart';
import 'package:healr/features/home/presentation/managers/selected_time/selected_time_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/book_appoint3_view_body.dart';

class BookAppoint3View extends StatelessWidget {
  const BookAppoint3View({super.key});

  @override
  Widget build(BuildContext context) {
    final data = GoRouterState.of(context).extra as Datum;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectedDayCubit(),
        ),
        BlocProvider(
          create: (context) => SelectedTimeCubit(),
        ),
      ],
      child: BookAppoint3ViewBody(
        data: data,
      ),
    );
  }
}
