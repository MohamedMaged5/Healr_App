import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/notification/data/models/time_line_item.dart';
import 'package:healr/features/notification/ui/manager/notificationCubit/notification_cubit.dart';
import 'package:healr/features/notification/ui/manager/notificationCubit/notification_state.dart';
import 'package:healr/features/notification/ui/manager/notificationActionCubit/notification_actions_cubit.dart';
import 'package:healr/features/notification/ui/views/no_notification_view.dart';
import 'package:healr/features/notification/ui/views/widgets/custom_notification_app_bar.dart';
import 'package:healr/features/notification/ui/views/widgets/custom_notification_container.dart';
import 'package:healr/features/notification/ui/views/widgets/notification_container_skeletonizer.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class NotificationViewBody extends StatefulWidget {
  const NotificationViewBody({super.key});

  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<NotificationCubit>();
    if (cubit.state is! NotificationMixedSuccess &&
        cubit.state is! NotificationEmpty) {
      cubit.startPolling();
    }
  }

  Future<void> _handleRefresh() async {
    setState(() => isRefreshing = true);
    await context.read<NotificationCubit>().fetchTimelineItems();
    setState(() => isRefreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotificationActionsCubit, NotificationActionsState>(
        builder: (context, notificationState) {
          final isSelectMode = notificationState is SelectingNotification;

          return BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              return LiquidPullToRefresh(
                onRefresh: _handleRefresh,
                height: 100.h,
                color: kSecondaryColor,
                backgroundColor: Colors.white,
                animSpeedFactor: 5,
                showChildOpacityTransition: false,
                child: Builder(
                  builder: (context) {
                    if (state is NotificationEmpty) {
                      return const NoNotificationView();
                    }

                    if (state is NotificationMixedSuccess) {
                      final grouped = groupTimelineItemsByDate(state.items);

                      return SafeArea(
                        child: CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            const SliverToBoxAdapter(
                              child: CustomNotificationAppBar(
                                  isNotificationfound: true),
                            ),
                            for (final entry in grouped.entries) ...[
                              SliverPadding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 16.h),
                                sliver: SliverToBoxAdapter(
                                  child: Text(
                                    entry.key,
                                    style: Styles.textStyle16.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff666666),
                                    ),
                                  ),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final item = entry.value[index];

                                    if (item is TimelineMedicineItem) {
                                      final med = item.medicine;
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: CustomNotificationContainer(
                                          medicinesList: entry.value
                                              .whereType<TimelineMedicineItem>()
                                              .map((e) => e.medicine)
                                              .toList(),
                                          img: 'assets/images/medicine.png',
                                          notificationTitle:
                                              'New Medicine Added',
                                          notificationDescription:
                                              'Dr ${med.doctorName} added a new medicine prescription. Tap to view details.',
                                          time: med.formattedCreationTime,
                                          isButtonClicked: isSelectMode,
                                          ispopCLicked: isSelectMode,
                                          id: med.id,
                                        ),
                                      );
                                    } else if (item
                                        is TimelineNotificationItem) {
                                      final n = item.notification;
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: CustomNotificationContainer(
                                          img: getNotificationImage(n.title),
                                          notificationTitle: n.title,
                                          notificationDescription: n.message,
                                          time: n.formattedCreationTime,
                                          id: n.id,
                                          isButtonClicked: false,
                                          ispopCLicked: false,
                                        ),
                                      );
                                    }
                                    return const SizedBox
                                        .shrink(); // مهم عشان متبقاش null
                                  },
                                  childCount: entry.value.length,
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }

                    if (state is NotificationLoading) {
                      return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return const NotificationContainerSkeletonizer();
                        },
                      );
                    }

                    if (state is NotificationFailure) {
                      return Center(
                        child: Text(
                          state.message,
                          style: Styles.textStyle16.copyWith(color: Colors.red),
                        ),
                      );
                    }

                    return const Center(child: Text("No data yet"));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

String getNotificationImage(String title) {
  if (title.contains("Medicine reminder")) {
    return "assets/images/medicine.png";
  } else if (title.contains("Medicine Reminder")) {
    return "assets/images/alarm.png";
  } else if (title.contains("Appointment alert")) {
    return "assets/images/reminder.png";
  } else if (title.contains("Appointment confirmation")) {
    return "assets/images/mark.png";
  }
  return "assets/images/reminder.png";
}

/// Group timeline items by formatted date (e.g., "July 11, 2025")
Map<String, List<TimelineItem>> groupTimelineItemsByDate(
    List<TimelineItem> items) {
  final Map<String, List<TimelineItem>> grouped = {};
  for (final item in items) {
    final date = DateFormat('MMMM dd, yyyy').format(item.createdAt);
    grouped.putIfAbsent(date, () => []).add(item);
  }
  return grouped;
}
