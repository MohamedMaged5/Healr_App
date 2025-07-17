import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/notification/data/models/medicine_model.dart';
import 'package:healr/features/notification/ui/manager/notificationActionCubit/notification_actions_cubit.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomNotificationContainer extends StatefulWidget {
  const CustomNotificationContainer({
    super.key,
    required this.img,
    required this.notificationTitle,
    required this.notificationDescription,
    required this.time,
    this.isButtonClicked = false,
    this.ispopCLicked = false,
    required this.id,
    this.medicinesList,
  });
  final String img;
  final String notificationTitle;
  final String notificationDescription;
  final String time;
  final bool ispopCLicked;
  final bool isButtonClicked;
  final String? id;
  final List<MedicineModel>? medicinesList;

  @override
  State<CustomNotificationContainer> createState() =>
      _CustomNotificationContainerState();
}

class _CustomNotificationContainerState
    extends State<CustomNotificationContainer> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<NotificationActionsCubit>();
    final isSelectMode = cubit.state is SelectingNotification;
    final isSelected = cubit.selectedIds.contains(widget.id);

    return GestureDetector(
      onTap: () {
        final cubit = context.read<NotificationActionsCubit>();
        final isSelectMode = cubit.state is SelectingNotification;

        if (isSelectMode) {
          setState(() {
            cubit.toggleSelection(widget.id!);
            isClicked = false;
          });
        } else {
          if (widget.medicinesList != null) {
            // التنقل فقط لو فيه قائمة أدوية
            GoRouter.of(context)
                .push(AppRouter.kMedicineView, extra: widget.medicinesList);
          }
        }
      },
      child: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 216, 216, 216),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ], color: Color.fromARGB(255, 228, 236, 255)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 16.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isSelectMode)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h, right: 4.w),
                      child: Icon(
                        isSelected
                            ? HugeIcons.strokeRoundedCheckmarkCircle02
                            : HugeIcons.strokeRoundedCircle,
                        size: 28.r,
                        color:
                            isSelected ? const Color(0xff3A95D2) : Colors.grey,
                      ),
                    ),
                  CircleAvatar(
                    radius: 20.r,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Image.asset(
                          widget.img,
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(width: 16.w),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                widget.notificationTitle,
                                style: Styles.textStyle18.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff1A1A1A),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Padding(
                              padding: EdgeInsets.only(top: 4.h),
                              child: Text(
                                widget.time,
                                style: Styles.textStyle12.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff666666),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.notificationDescription,
                          style: Styles.textStyle14.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff1A1A1A).withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
