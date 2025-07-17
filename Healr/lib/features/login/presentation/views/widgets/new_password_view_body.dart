import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_back_button.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/core/widgets/custom_text_field.dart';
import 'package:healr/features/login/data/repos/newpass_repo_imp.dart';
import 'package:healr/features/login/presentation/manager/newpass_cubit/newpass_cubit.dart';
import 'package:healr/features/login/presentation/views/widgets/custom_password_validation_sentence.dart';

class NewPasswordViewBody extends StatefulWidget {
  const NewPasswordViewBody({super.key});

  @override
  State<NewPasswordViewBody> createState() => _NewPasswordViewBodyState();
}

class _NewPasswordViewBodyState extends State<NewPasswordViewBody> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? errorMessage;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void newpass(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;

      setState(() {
        errorMessage = null;
      });

      BlocProvider.of<NewpassCubit>(context).newpassUser(
        password,
        confirmPassword,
      );
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "";
    if (value.length < 8) return '';
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return '';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return '';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return '';
    }
    if (value.length > 15) return 'Password must be at most 15 characters';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewpassCubit(
        getIt.get<NewpassRepoImp>(),
      ),
      child: SafeArea(
          child: Scaffold(
              body: BlocConsumer<NewpassCubit, NewpassState>(
        listener: (context, state) {
          if (state is NewpassSuccess) {
            GoRouter.of(context).pushReplacement(
              AppRouter.kPasswordChangedView,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password changed successfully ✅'),
                duration: Duration(seconds: 2),
                backgroundColor: Color.fromARGB(255, 13, 79, 127),
              ),
            );
          } else if (state is NewpassFailure) {
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
                      "Create new password",
                      textAlign: TextAlign.center,
                      style: Styles.textStyle32.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextField(
                        controller: passwordController,
                        validator: validatePassword,
                        hintText: "•••••••••••••••",
                        labelText: "Password",
                        onChanged: (p0) {
                          setState(() {});
                        },
                        obscureText: true),
                    SizedBox(height: 12.h),
                    CustomPasswordValidtionSentence(
                      iconColor: passwordController.text.length < 8
                          ? Colors.red
                          : Colors.green,
                      icon: passwordController.text.length < 8
                          ? Icons.close
                          : Icons.check,
                      text: "Password should be at least 8 characters long ",
                    ),
                    SizedBox(height: 12.h),
                    CustomPasswordValidtionSentence(
                      iconColor:
                          !passwordController.text.contains(RegExp(r'[A-Z]'))
                              ? Colors.red
                              : Colors.green,
                      icon: !passwordController.text.contains(RegExp(r'[A-Z]'))
                          ? Icons.close
                          : Icons.check,
                      text: "Include one uppercase letter",
                    ),
                    SizedBox(height: 12.h),
                    CustomPasswordValidtionSentence(
                      iconColor: !passwordController.text
                                  .contains(RegExp(r'[0-9]')) ||
                              !passwordController.text
                                  .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
                          ? Colors.red
                          : Colors.green,
                      icon: !passwordController.text
                                  .contains(RegExp(r'[0-9]')) ||
                              !passwordController.text
                                  .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
                          ? Icons.close
                          : Icons.check,
                      text: "Add a number and a special character ‘’**",
                    ),
                    SizedBox(height: 24.h),
                    CustomTextField(
                        controller: confirmPasswordController,
                        hintText: "•••••••••••••••",
                        labelText: "Confirm password",
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Confirm password is required';
                          }
                          if (p0 != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        obscureText: true),
                    SizedBox(height: 24.h),
                    CustomButton(
                      text: state is NewpassLoading
                          ? 'Loading...'
                          : 'Reset Password',
                      onPressed: state is NewpassLoading
                          ? null
                          : () => newpass(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ))),
    );
  }
}
