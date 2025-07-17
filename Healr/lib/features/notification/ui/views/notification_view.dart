import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/features/notification/data/repo/notification_repo_imp.dart';
import 'package:healr/features/notification/ui/manager/notificationCubit/notification_cubit.dart';
import 'package:healr/features/notification/ui/manager/notificationActionCubit/notification_actions_cubit.dart';
import 'package:healr/features/notification/ui/views/widgets/notification_view_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              NotificationCubit(getIt.get<NotificationRepoImp>()),
        ),
        BlocProvider(
          create: (context) => NotificationActionsCubit(),
        ),
      ],
      child: const NotificationViewBody(),
    );
  }
}
