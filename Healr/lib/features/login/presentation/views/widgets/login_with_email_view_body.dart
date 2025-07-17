import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/features/login/data/repos/login_repo_imp.dart';
import 'package:healr/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:healr/core/widgets/custom_text_field.dart';
import 'package:healr/core/widgets/custom_text_rich.dart';
import 'package:healr/features/login/presentation/views/widgets/custom_sign_in_with_email_button.dart';

class LoginWithEmailViewBody extends StatefulWidget {
  const LoginWithEmailViewBody({super.key});

  @override
  State<LoginWithEmailViewBody> createState() => _LoginWithEmailViewBodyState();
}

class _LoginWithEmailViewBodyState extends State<LoginWithEmailViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      setState(() {
        errorMessage = null;
      });

      context.read<LoginCubit>().loginUserWithEmail(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt.get<LoginRepoImp>()),
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
              } else if (state is LoginFailure) {
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
                    padding: EdgeInsets.only(top: 88.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'Sign in',
                          style: Styles.textStyle32.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 60.h),
                        CustomTextField(
                          controller: emailController,
                          labelText: 'Email',
                          hintText: 'Enter your Email address',
                          obscureText: false,
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          controller: passwordController,
                          onTap: () {
                            GoRouter.of(context)
                                .push(AppRouter.kForgetPasswordView);
                          },
                          showForgotPass: true,
                          labelText: 'Password',
                          hintText: '•••••••••••••••',
                          obscureText: true,
                          errorText: errorMessage,
                          maxLength: 15,
                        ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          text:
                              state is LoginLoading ? 'Loading...' : 'Sign in',
                          onPressed: state is LoginLoading
                              ? null
                              : () => login(context),
                        ),
                        SizedBox(height: 16.h),
                        SvgPicture.asset(
                          'assets/images/or.svg',
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(height: 16.h),
                        CustomSignInWithEmailButton(
                          text: 'Sign in with National ID',
                          onTap: () {
                            GoRouter.of(context).pop();
                          },
                        ),
                        SizedBox(height: 16.h),
                        Center(
                          child: CustomTextRich(
                            text1: 'New Here?',
                            text2: '  Create an Account',
                            onTapText2: () {
                              GoRouter.of(context).push(AppRouter.kSignUpView);
                            },
                          ),
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
