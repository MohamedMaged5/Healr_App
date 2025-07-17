import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/core/widgets/custom_text_field.dart';
import 'package:healr/core/widgets/custom_text_rich.dart';
import 'package:healr/features/sign_up/data/repos/sign_up_repo_imp.dart';
import 'package:healr/features/sign_up/presentation/manager/cubit/sign_up_cubit.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nationalController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? errorMessage;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    nationalController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void signUp(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      final name = nameController.text;
      final nationalId = nationalController.text;
      final phone = phoneController.text;
      final email = emailController.text;
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;

      setState(() {
        errorMessage = null;
      });

      BlocProvider.of<SignUpCubit>(context).signUpUser({
        'name': name,
        'nationalID': nationalId,
        'mobilePhone': phone,
        'email': email,
        'password': password,
        'confirmedPassword': confirmPassword,
      });
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    if (value.length > 15) return 'Password must be at most 15 characters';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(getIt.get<SignUpRepoImp>()),
      child: SafeArea(
          child: Scaffold(
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
            
            } else if (state is SignUpFailure) {
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
                  padding: EdgeInsets.only(top: 70.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'Create an account',
                        style: Styles.textStyle32.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      CustomTextField(
                        controller: nameController,
                        hintText: "Enter Your Full Name.",
                        labelText: "Full Name",
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: nationalController,
                        hintText: "Enter your 14-digit national number.",
                        labelText: "National Number",
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'National number is required';
                          }
                          if (value.length != 14) {
                            return 'National number must be 14 digits';
                          }
                          return null;
                        },
                        maxLength: 14,
                      ),
                      CustomTextField(
                        controller: phoneController,
                        hintText: "eg. 0122222222",
                        labelText: "Phone Number",
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          if (value.length != 11) {
                            return 'Phone number must be 11 digits';
                          }
                          return null;
                        },
                        maxLength: 11,
                      ),
                      CustomTextField(
                        controller: emailController,
                        hintText: "Enter Your Email",
                        labelText: "Email Address",
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!value.contains('@')) {
                            return 'Invalid email';
                          }
                          if (!value.contains('.')) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                        maxLength: 50,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        hintText: "•••••••••••••••",
                        labelText: "Password",
                        obscureText: true,
                        validator: validatePassword,
                        maxLength: 15,
                      ),
                      CustomTextField(
                        controller: confirmPasswordController,
                        hintText: "•••••••••••••••",
                        labelText: "Confirm Password",
                        obscureText: true,
                        errorText: errorMessage,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm password is required';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        maxLength: 15,
                      ),
                      SizedBox(height: 16.h),
                      CustomButton(
                        text: state is SignUpLoading ? "Loading..." : "Sign up",
                        onPressed: state is SignUpLoading
                            ? null
                            : () => signUp(context),
                      ),
                      SizedBox(height: 16.h),
                      Center(
                        child: CustomTextRich(
                          text1: "Already have an account? ",
                          text2: " Sign in",
                          onTapText2: () {
                            GoRouter.of(context).push(AppRouter.kLoginView);
                          },
                        ),
                      ),
                      SizedBox(height: 32.h),
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
