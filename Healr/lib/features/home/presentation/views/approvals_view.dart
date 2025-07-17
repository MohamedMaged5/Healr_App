import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healr/features/home/presentation/managers/approvals/approvals_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/approvals_view_body.dart';

class ApprovalsView extends StatelessWidget {
  const ApprovalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApprovalsCubit(),
      child: const ApprovalsViewBody(),
    );
  }
}
