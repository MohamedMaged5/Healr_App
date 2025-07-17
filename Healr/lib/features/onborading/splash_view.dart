import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigateAfterSplash();
  }

  Future<void> navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 5));

    await SharedPrefCache.initSharedPref();
    kToken = SharedPrefCache.getCache(key: 'token');
    kOnboardingStatus = SharedPrefCache.getCache(key: 'onboardingStatus');
    if (kOnboardingStatus != 'completed') {
      GoRouter.of(context).go(AppRouter.kOnboardingView);
    } else if (kToken != null && kToken!.isNotEmpty && kToken != 'null') {
      
      GoRouter.of(context).go(AppRouter.kHomeView);
    } else {
      GoRouter.of(context).go(AppRouter.kLoginView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.gif',
          height: 300,
          width: 650,
        ),
      ),
    );
  }
}
