import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:healr/features/profile/data/model/profile_model.dart';
import 'package:healr/features/profile/data/repo/profile_repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  final ProfileRepo profileRepo;
  ProfileModel? cachedProfile;

  Future<void> getProfile() async {
    if (cachedProfile != null) {
      emit(ProfileLoaded(profile: cachedProfile!));
      return;
    }

    emit(ProfileLoading());

    final userProfile = await profileRepo.getProfile();

    userProfile.fold(
      (failure) {
        emit(ProfileError(failure.errMessage));
      },
      (user) {
        cachedProfile = user;
        emit(ProfileLoaded(profile: user));
      },
    );
  }

  Future<void> updateProfile({
    String? phone,
    String? gender,
    String? birthDate,
    String? notes,
    String? bloodType,
  }) async {
    final result = await profileRepo.updateProfile(
      gender,
      birthDate,
      notes,
      bloodType,
      phone,
    );

    result.fold(
      (failure) {
        emit(ProfileUpdateError(failure.errMessage));
      },
      (updatedUser) {
        cachedProfile = updatedUser;
        emit(ProfileUpdated(updatedProfile: updatedUser));
      },
    );
  }

  Future<void> updateProfileImage(String imagePath) async {
    emit(ProfileImageUpdating());

    final result = await profileRepo.updateProfileImage(imagePath);
    result.fold(
      (failure) {
        emit(ProfileUpdateError(failure.errMessage));
      },
      (uploadedImage) {
        cachedProfile = uploadedImage;
        emit(ProfileImageUpdated(imagePath: uploadedImage.image!));
        SharedPrefCache.saveCache(key: 'image', value: uploadedImage.image!);
      },
    );
  }
  Future<void> fetchProfileImage() async {
  final result = await profileRepo.fetchProfileImage();

  result.fold(
    (failure) {
      emit(ProfileUpdateError(failure.errMessage));
    },
    (image) {
      if (cachedProfile != null) {
        cachedProfile = cachedProfile!.copyWith(image: image);
        emit(ProfileLoaded(profile: cachedProfile!));
      }
    },
  );
}

  
}

