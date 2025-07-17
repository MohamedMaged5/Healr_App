import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/features/home/data/repos/get_doctors_repo_imp.dart';
import 'package:healr/features/home/presentation/managers/get_doctors/get_doctors_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/book_appoint_view_body.dart';

class BookAppointView extends StatelessWidget {
  const BookAppointView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDoctorsCubit(getIt.get<GetDoctorsRepoImp>()),
      child: const BookAppointViewBody(),
    );
  }
}
