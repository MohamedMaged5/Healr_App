import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/features/chatbot/data/chatbot_repo_imp.dart';
import 'package:healr/features/home/data/repos/appoint_repo_imp.dart';
import 'package:healr/features/home/data/repos/get_doctors_repo_imp.dart';
import 'package:healr/features/home/data/repos/reviews_repo_imp.dart';
import 'package:healr/features/login/data/repos/forget_pass_repo_imp.dart';
import 'package:healr/features/login/data/repos/login_repo_imp.dart';
import 'package:healr/features/login/data/repos/newpass_repo_imp.dart';
import 'package:healr/features/login/data/repos/verification_repo_imp.dart';
import 'package:healr/features/notification/data/repo/notification_repo_imp.dart';
import 'package:healr/features/profile/data/repo/health_insurance_repo/health_insurance_repo_imp.dart';
import 'package:healr/features/profile/data/repo/profile_repo/profile_repo_imp.dart';
import 'package:healr/features/search/data/repos/search_repo_imp.dart';
import 'package:healr/features/sign_up/data/repos/sign_up_repo_imp.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<LoginRepoImp>(
    LoginRepoImp(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<SignUpRepoImp>(
    SignUpRepoImp(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<ProfileRepoImp>(
    ProfileRepoImp(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<ForgetPassRepoImp>(
    ForgetPassRepoImp(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<VerificationRepoImp>(
    VerificationRepoImp(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<NewpassRepoImp>(
    NewpassRepoImp(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<SearchRepoImp>(
    SearchRepoImp(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<GetDoctorsRepoImp>(
    GetDoctorsRepoImp(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<NotificationRepoImp>(
    NotificationRepoImp(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<HealthInsuranceRepoImp>(
    HealthInsuranceRepoImp(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<AppointRepoImp>(
    AppointRepoImp(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<ChatbotRepoImp>(
    ChatbotRepoImp(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<ReviewsRepoImp>(
    ReviewsRepoImp(
      getIt.get<ApiService>(),
    ),
  );
}
