import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:healr/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({
    super.key,
    this.radius = 50.0,
    this.height = 28.0,
    this.width = 28.0,
    this.imagePath,
  });

  final double radius;
  final double height, width;
  final String? imagePath;

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String? imagePath;
        if (state is ProfileImageUpdating) {
          return Center(
            child: CircularProgressIndicator(
              color: kSecondaryColor,
            ),
          );
        }
        if (state is ProfileImageUpdated) {
          imagePath = state.imagePath;
        } else if (state is ProfileUpdated) {
          imagePath = state.updatedProfile.image;
        } else {
          imagePath = SharedPrefCache.getCache(key: 'image');
        }

        return GestureDetector(
          onTap: () => _showImagePickerOptions(context),
          child: CustomProfileImage(
            radius: widget.radius,
            imageUrl: imagePath,
            width: widget.width,
            height: widget.height,
            onEditTap: () => _showImagePickerOptions(context),
          ),
        );
      },
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _selectImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _selectImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Permission permanently denied. Please enable it from settings.'),
        ),
      );
      await openAppSettings();
      return false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permission denied. Cannot access camera/gallery.'),
        ),
      );
      return false;
    }
  }

  Future<void> _selectImage(ImageSource source) async {
    final isCamera = source == ImageSource.camera;
    final permission = isCamera ? Permission.camera : Permission.photos;

    bool granted = await _requestPermission(permission);
    if (!granted) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return;

    final cropped = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        IOSUiSettings(title: 'Crop Image', aspectRatioLockEnabled: false),
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: kSecondaryColor,
          toolbarWidgetColor: kPrimaryColor,
          lockAspectRatio: false,
        ),
      ],
    );

    if (cropped != null && mounted) {
      await context.read<ProfileCubit>().updateProfileImage(cropped.path);
    }
  }
}

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({
    super.key,
    required this.radius,
    this.imageUrl,
    required this.width,
    required this.height,
    this.onEditTap,
  });

  final double radius;
  final String? imageUrl;
  final double width, height;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      if (imageUrl!.startsWith('http')) {
        imageWidget = ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl!,
            fit: BoxFit.cover,
            width: radius * 2,
            height: radius * 2,
            placeholder: (context, url) => Container(
              width: radius * 2,
              height: radius * 2,
              alignment: Alignment.center,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
                ),
              ),
            ),
            errorWidget: (context, url, error) => SvgPicture.asset(
              'assets/images/default.svg',
              fit: BoxFit.cover,
              width: radius * 2,
              height: radius * 2,
            ),
          ),
        );
      } else {
        imageWidget = ClipOval(
          child: Image.file(
            File(imageUrl!),
            fit: BoxFit.cover,
            width: radius * 2,
            height: radius * 2,
          ),
        );
      }
    } else {
      imageWidget = ClipOval(
        child: SvgPicture.asset(
          'assets/images/default.svg',
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
        ),
      );
    }

    return Stack(
      children: [
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: imageWidget,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onEditTap,
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/images/edit.svg',
                width: width.w,
                height: height.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
