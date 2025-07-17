part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  const ProfileLoaded({
    required this.profile,
  });

  @override
  List<Object> get props => [
        profile
      ];
}

final class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}
final class ProfileUpdated extends ProfileState {
  final ProfileModel updatedProfile;

  const ProfileUpdated({
    required this.updatedProfile,
  });

  @override
  List<Object> get props => [
        updatedProfile
      ];
}
final class ProfileUpdateError extends ProfileState {
  final String message;

  const ProfileUpdateError(this.message);

  @override
  List<Object> get props => [message];
}
final class ProfileImageUpdated extends ProfileState {
  final String imagePath;

  const ProfileImageUpdated({
    required this.imagePath,
  });

  @override
  List<Object> get props => [
        imagePath
      ];
}

final class ProfileImageUpdating extends ProfileState {}

