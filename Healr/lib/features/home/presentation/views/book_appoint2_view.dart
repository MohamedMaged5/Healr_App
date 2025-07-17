import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/repos/get_doctors_repo_imp.dart';
import 'package:healr/features/home/data/repos/reviews_repo_imp.dart';
import 'package:healr/features/home/presentation/managers/get_doctors/get_doctors_cubit.dart';
import 'package:healr/features/home/presentation/managers/reviews_cubit/reviews_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/book_appoint2_view_body.dart';

class BookAppoint2View extends StatelessWidget {
  const BookAppoint2View({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final data = GoRouterState.of(context).extra as Datum?;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReviewsCubit(getIt.get<ReviewsRepoImp>()),
        ),
        BlocProvider(
          create: (context) => GetDoctorsCubit(getIt.get<GetDoctorsRepoImp>()),
        ),
      ],
      child: BookAppoint2ViewBody(
        data: data,
      ),
    );
  }
}
