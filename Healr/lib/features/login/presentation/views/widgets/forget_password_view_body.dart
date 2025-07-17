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
import 'package:healr/core/widgets/custom_text_field.dart';
import 'package:healr/features/login/presentation/manager/forgetpass_cubit/forgetpass_cubit.dart';
import 'package:healr/features/login/data/repos/forget_pass_repo_imp.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final TextEditingController emailcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? errorMessage;

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  void forgetpass(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      email = emailcontroller.text;

      setState(() {
        errorMessage = null;
      });

      BlocProvider.of<ForgetPassCubit>(context).forgetUser(email!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPassCubit(getIt.get<ForgetPassRepoImp>()),
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<ForgetPassCubit, ForgetpassState>(
            listener: (context, state) {
              if (state is ForgetPassSuccess) {
                GoRouter.of(context).pushReplacement(
                  AppRouter.kVerificationCodeView,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Verification code sent to the user email ✅'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Color.fromARGB(255, 13, 79, 127),
                  ),
                );
              } else if (state is ForgetPassFailure) {
                setState(() {
                  errorMessage = state.errMessage;
                });
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.only(top: 32.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const CustomBackButton(),
                        SizedBox(height: 32.h),
                        Text(
                          'Forgot your password?',
                          textAlign: TextAlign.center,
                          style: Styles.textStyle30.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Enter your Email account to reset your password",
                          textAlign: TextAlign.center,
                          style: Styles.textStyle14,
                        ),
                        SizedBox(height: 32.h),
                        CustomTextField(
                          controller: emailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          hintText: "enter your Email",
                          labelText: "Email address",
                          obscureText: false,
                          errorText: errorMessage,
                        ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          text: state is ForgetPassLoading
                              ? 'Loading...'
                              : 'Next',
                          onPressed: state is ForgetPassLoading
                              ? null
                              : () => forgetpass(context),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
