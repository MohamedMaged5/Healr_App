import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/appoint_cache.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/features/home/presentation/managers/booking/booking_cubit.dart';
import 'package:healr/features/notification/ui/views/widgets/local_notification.dart';
import 'package:healr/features/profile/data/repo/health_insurance_repo/health_insurance_repo_imp.dart';
import 'package:healr/features/profile/data/repo/profile_repo/profile_repo_imp.dart';
import 'package:healr/features/profile/presentation/manager/health_insurance_cubit/cubit/health_insurance_cubit.dart';
import 'package:healr/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();
  setupServiceLocator();

  await loadAllBookingStatuses();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(getIt.get<ProfileRepoImp>()),
        ),
        BlocProvider(
          create: (context) => BookingCubit(),
        ),
        BlocProvider(
          create: (context) =>
              HealthInsuranceCubit(getIt.get<HealthInsuranceRepoImp>()),
        ),
      ],
      child: const Healr(),
    ),
  );
}

class Healr extends StatelessWidget {
  const Healr({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: kPrimaryColor,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: kSecondaryColor,
              selectionHandleColor: kSecondaryColor,
              selectionColor: kSecondaryColor.withAlpha(100),
            ),
            textTheme: ThemeData.light().textTheme.apply(
                  fontFamily: 'Aspekta',
                ),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
