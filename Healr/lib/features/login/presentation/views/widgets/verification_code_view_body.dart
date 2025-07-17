import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/global.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_back_button.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/core/widgets/custom_text_rich.dart';
import 'package:healr/features/login/data/repos/forget_pass_repo_imp.dart';
import 'package:healr/features/login/data/repos/verification_repo_imp.dart';
import 'package:healr/features/login/presentation/manager/forgetpass_cubit/forgetpass_cubit.dart';
import 'package:healr/features/login/presentation/manager/verification_cubit/verification_cubit.dart';
import 'package:healr/features/login/presentation/views/widgets/custom_pinput.dart';

class VerificationCodeViewBody extends StatefulWidget {
  const VerificationCodeViewBody({
    super.key,
  });

  @override
  State<VerificationCodeViewBody> createState() =>
      _VerificationCodeViewBodyState();
}

class _VerificationCodeViewBodyState extends State<VerificationCodeViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void verify(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      final code = _pinController.text;

      setState(() {
        errorMessage = null;
      });

      BlocProvider.of<VerificationCubit>(context).verifyUser(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              VerificationCubit(getIt.get<VerificationRepoImp>()),
        ),
        BlocProvider(
          create: (context) => ForgetPassCubit(getIt.get<ForgetPassRepoImp>()),
        ),
      ],
      child: SafeArea(
          child: Scaffold(
        body: BlocConsumer<VerificationCubit, VerificationState>(
          listener: (context, state) {
            if (state is VerificationSuccess) {
              GoRouter.of(context).pushReplacement(AppRouter.kNewPasswordView);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Verification code correct ✅'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Color.fromARGB(255, 13, 79, 127),
                ),
              );
            } else if (state is VerificationFailure) {
              setState(() {
                errorMessage = state.errMessage;
              });
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const CustomBackButton(),
                      SizedBox(height: 32.h),
                      Text(
                        'Enter verification code',
                        textAlign: TextAlign.center,
                        style: Styles.textStyle30.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "An OTP has been sent to your registered email address. Please enter the code below to proceed.",
                        textAlign: TextAlign.center,
                        style: Styles.textStyle14,
                      ),
                      SizedBox(height: 32.h),
                      Text(
                        "The OTP is valid for 10 minutes.",
                        textAlign: TextAlign.center,
                        style: Styles.textStyle14,
                      ),
                      SizedBox(height: 20.h),
                      CustomPinPut(
                        pinController: _pinController,
                        errorText: errorMessage,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return errorMessage =
                                'Verification code is required';
                          }
                          if (value.length < 4) {
                            return errorMessage;
                          }
                          if (value.length == 4) {
                            return errorMessage;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),
                      CustomButton(
                        text: state is VerificationLoading
                            ? 'Loading...'
                            : 'Next',
                        onPressed: state is VerificationLoading
                            ? null
                            : () => verify(context),
                      ),
                      SizedBox(height: 16.h),
                      Center(
                        child: CustomTextRich(
                          text1: "Didn’t receive a code?  ",
                          text2: "Resend code",
                          onTapText2: () {
                            BlocProvider.of<ForgetPassCubit>(context)
                                .forgetUser(email!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Code resent successfully ✅'),
                                duration: Duration(seconds: 2),
                                backgroundColor:
                                    Color.fromARGB(255, 13, 79, 127),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}
