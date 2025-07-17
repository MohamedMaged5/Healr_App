import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/core/widgets/custom_dialog.dart';
import 'package:healr/core/widgets/custom_text_field.dart';
import 'package:healr/features/profile/data/model/profile_model.dart';
import 'package:healr/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_dropdown_button.dart';
import 'package:healr/features/profile/presentation/views/widgets/date_text_field.dart';
import 'package:healr/features/profile/presentation/views/widgets/profile_image_picker.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class YourProfileViewBody extends StatefulWidget {
  const YourProfileViewBody({super.key});

  @override
  State<YourProfileViewBody> createState() => _YourProfileViewBodyState();
}

class _YourProfileViewBodyState extends State<YourProfileViewBody> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nationalIDController = TextEditingController();

  bool isPhoneEditable = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  final FocusNode focusNode = FocusNode();

  final List<String> gender = ['Male', 'Female'];
  final List<String> bloodType = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  String? selectedBloodType;
  String? selectedGender;
  DateTime? selectedDate;
  String? imagePath;
  bool hasPhoneBeenEdited = false;
  ProfileModel? currentProfile;

  @override
  void initState() {
    super.initState();
    fillFormWithCachedData();
    final cubit = BlocProvider.of<ProfileCubit>(context);
    if (SharedPrefCache.getCache(key: 'image ').isEmpty) {
      cubit.getProfile();
    } else {
      fillFormWithCachedData();
      cubit.fetchProfileImage();
    }
  }

  void fillFormWithCachedData() {
    setState(() {
      nameController.text = SharedPrefCache.getCache(key: 'name');
      emailController.text = SharedPrefCache.getCache(key: 'email');
      nationalIDController.text = SharedPrefCache.getCache(key: 'nationalID');
      phoneController.text = SharedPrefCache.getCache(key: 'phone');
      notesController.text = SharedPrefCache.getCache(key: 'notes');
      final cachedDate = SharedPrefCache.getCache(key: 'date');
      if (cachedDate.isNotEmpty) {
        try {
          selectedDate = DateFormat('dd/MM/yyyy').parseStrict(cachedDate);
          dateController.text = cachedDate;
        } catch (e) {
          selectedDate = null;
          dateController.text = '';
        }
      }

      selectedGender = SharedPrefCache.getCache(key: 'gender').isNotEmpty
          ? SharedPrefCache.getCache(key: 'gender')
          : null;
      selectedBloodType = SharedPrefCache.getCache(key: 'blood').isNotEmpty
          ? SharedPrefCache.getCache(key: 'blood')
          : null;

      imagePath = SharedPrefCache.getCache(key: 'image');
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    notesController.dispose();
    dateController.dispose();
    nameController.dispose();
    emailController.dispose();
    nationalIDController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> saveData() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final newPhone = phoneController.text;
    final newNotes = notesController.text;
    final newGender = selectedGender;
    final newBloodType = selectedBloodType;
    final newDate = dateController.text;

    final currentPhone =
        currentProfile?.phoneNumber ?? SharedPrefCache.getCache(key: 'phone');
    final currentNotes =
        currentProfile?.notes ?? SharedPrefCache.getCache(key: 'notes');
    final currentGender =
        currentProfile?.gender ?? SharedPrefCache.getCache(key: 'gender');
    final currentBloodType =
        currentProfile?.bloodType ?? SharedPrefCache.getCache(key: 'blood');
    final currentDate =
        currentProfile?.date ?? SharedPrefCache.getCache(key: 'date');

    final Map<String, dynamic> updatedData = {};

    if (newPhone != currentPhone) {
      updatedData['phone'] = newPhone;
    }
    if (newNotes != currentNotes) {
      updatedData['notes'] = newNotes;
    }
    if (newGender != currentGender) {
      updatedData['gender'] = newGender;
    }
    if (newBloodType != currentBloodType) {
      updatedData['blood'] = newBloodType;
    }
    if (newDate != currentDate) {
      updatedData['birthDate'] = newDate;
    }

    final saveTasks = <Future>[];
    if (updatedData.containsKey('phone')) {
      saveTasks.add(SharedPrefCache.saveCache(key: 'phone', value: newPhone));
    }
    if (updatedData.containsKey('notes')) {
      saveTasks.add(SharedPrefCache.saveCache(key: 'notes', value: newNotes));
    }
    if (updatedData.containsKey('gender')) {
      saveTasks.add(
          SharedPrefCache.saveCache(key: 'gender', value: newGender ?? ''));
    }
    if (updatedData.containsKey('blood')) {
      saveTasks.add(
          SharedPrefCache.saveCache(key: 'blood', value: newBloodType ?? ''));
    }
    if (updatedData.containsKey('birthDate')) {
      saveTasks.add(SharedPrefCache.saveCache(key: 'date', value: newDate));
    }

    await Future.wait(saveTasks);
    context.read<ProfileCubit>().updateProfile(
          phone: updatedData['phone'],
          notes: updatedData['notes'],
          gender: updatedData['gender'],
          birthDate: updatedData['birthDate'],
          bloodType: updatedData['blood'],
        );

    if (mounted) {
      setState(() {
        isPhoneEditable = false;
        hasPhoneBeenEdited = true;
      });
      showCustomDialog(
        context: context,
        message: 'Your profile has been updated successfully!',
        duration: const Duration(seconds: 2),
        iconPath: 'assets/images/dialog.svg',
      );
    }
  }

  void fillFormWithProfile(ProfileModel profile) {
    if (mounted) {
      setState(() {
        currentProfile = profile;

        notesController.text = profile.notes ?? '';

        if (profile.date != null && profile.date!.isNotEmpty) {
          try {
            selectedDate = DateFormat('dd/MM/yyyy').parseStrict(profile.date!);
            dateController.text = profile.date!;
          } catch (e) {
            selectedDate = null;
            dateController.text = '';
          }
        } else {
          selectedDate = null;
          dateController.text = '';
        }

        selectedGender = profile.gender;
        selectedBloodType = profile.bloodType;

        imagePath = profile.image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          } else if (state is ProfileUpdated) {
            fillFormWithProfile(state.updatedProfile);
          } else if (state is ProfileLoaded) {
            fillFormWithProfile(state.profile);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Skeletonizer(
              effect: ShimmerEffect(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
              ),
              child: buildYourProfile(),
            );
          }
          if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return buildYourProfile();
        },
      ),
    );
  }

  Widget buildYourProfile() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const CustomAppBar(text: 'Your Profile'),
                SizedBox(height: 32.h),
                ProfileImagePicker(
                  radius: 70.0,
                  height: 36.h,
                  width: 36.w,
                  imagePath: imagePath,
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                  controller: nameController,
                  hintStyle: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w400,
                    color: kSignIconColor,
                  ),
                  textStyle: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  padding: 0,
                  hintText: 'Enter Your Name',
                  labelText: 'Full Name',
                  obscureText: false,
                  readOnly: true,
                  maxLength: 32,
                ),
                CustomTextField(
                  controller: nationalIDController,
                  hintStyle: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w400,
                    color: kSignIconColor,
                  ),
                  textStyle: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  padding: 0,
                  hintText: 'Enter Your National Number',
                  labelText: 'National Number',
                  obscureText: false,
                  readOnly: true,
                  maxLength: 14,
                ),
                CustomTextField(
                  controller: emailController,
                  hintStyle: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w400,
                    color: kSignIconColor,
                  ),
                  textStyle: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  padding: 0,
                  hintText: 'Enter Your Email Address',
                  labelText: 'Email Address',
                  obscureText: false,
                  maxLength: 36,
                  readOnly: true,
                ),
                CustomTextField(
                  focusNode: focusNode,
                  validator: (phone) {
                    if (phone == null || phone.isEmpty) {
                      return 'Please Enter your phone number';
                    }
                    if (phone.length != 11) {
                      return 'Your phone number must be 11 digits';
                    }
                    return null;
                  },
                  hintStyle: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w400,
                    color: kSignIconColor,
                  ),
                  textStyle: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  padding: 0,
                  hintText: 'Enter Your Phone Number',
                  labelText: 'Phone Number',
                  controller: phoneController,
                  obscureText: false,
                  maxLength: 11,
                  readOnly: !isPhoneEditable,
                  suffixIcon: isPhoneEditable
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              isPhoneEditable = false;
                              hasPhoneBeenEdited = true;
                            });
                            focusNode.unfocus();
                          },
                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              isPhoneEditable = true;
                              hasPhoneBeenEdited = false;
                            });
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              focusNode.requestFocus();
                            });
                          },
                          child: Text(
                            'Change',
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                ),
                DateTextField(
                  controller: dateController,
                  onDateSelected: (date) {
                    setState(() {
                      selectedDate = date;
                      dateController.text = date != null
                          ? DateFormat('dd/MM/yyyy').format(date)
                          : '';
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomDropdownButton(
                  selectedValue: selectedGender,
                  items: gender,
                  onChanged: (String? value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  hintText: 'Select Your Gender',
                  labelText: 'Gender',
                ),
                SizedBox(height: 24.h),
                CustomDropdownButton(
                  selectedValue: selectedBloodType,
                  items: bloodType,
                  onChanged: (String? value) {
                    setState(() {
                      selectedBloodType = value;
                    });
                  },
                  hintText: 'Select Your Blood Type',
                  labelText: 'Blood Type',
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  maxLength: 200,
                  maxLines: 6,
                  hintStyle: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w400,
                    color: kSignIconColor,
                  ),
                  textStyle: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  padding: 0,
                  hintText: 'Enter any additional notes',
                  labelText: 'Additional Notes',
                  controller: notesController,
                  obscureText: false,
                ),
                SizedBox(height: 16.h),
                CustomButton(
                  padding: 0,
                  text: 'Update',
                  onPressed: saveData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
