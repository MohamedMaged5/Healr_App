import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:healr/features/profile/presentation/views/widgets/profile_image_picker.dart';

class ProfileHeaderSection extends StatefulWidget {
  const ProfileHeaderSection({super.key});

  @override
  State<ProfileHeaderSection> createState() => _ProfileHeaderSectionState();
}

class _ProfileHeaderSectionState extends State<ProfileHeaderSection> {
  String name = '';
  String nationalId = '';
  String? imagePath;
  bool loadedFromCache = false;

  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<ProfileCubit>(context);
    final cachedName = SharedPrefCache.getCache(key: 'name');
    final cachedNationalId = SharedPrefCache.getCache(key: 'nationalID');
    final cachedImage = SharedPrefCache.getCache(key: 'image');

    if (cachedName != '' && cachedNationalId != '') {
      setState(() {
        name = cachedName;
        nationalId = cachedNationalId;
        imagePath = cachedImage;
        loadedFromCache = true;
      });
      setState(() {
        cubit.fetchProfileImage();
      });
    } else {
      cubit.getProfile();
      cubit.fetchProfileImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          setState(() {
            name = state.profile.name!;
            nationalId = state.profile.nationalID!;
            imagePath = state.profile.image;
          });
        } else if (state is ProfileUpdated) {
          setState(() {
            name = state.updatedProfile.name!;
            nationalId = state.updatedProfile.nationalID!;
            imagePath = state.updatedProfile.image;
          });
        }
        if (state is ProfileLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: Styles.textStyle32.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                ProfileImagePicker(
                  radius: 40.0,
                  height: 24.h,
                  width: 24.w,
                  imagePath: imagePath,
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name
                          .trim()
                          .split(' ')
                          .take(2)
                          .map((value) => value.isNotEmpty
                              ? value[0].toUpperCase() +
                                  value.substring(1).toLowerCase()
                              : '')
                          .join(' '),
                      style: Styles.textStyle20.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    if (nationalId.isNotEmpty)
                      Text(
                        'File ID: $nationalId',
                        style: Styles.textStyle14.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff4D4D4D),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
