import 'package:bloc/bloc.dart';
import 'package:healr/features/notification/data/models/medicine_model.dart';
import 'package:healr/features/notification/data/models/time_line_item.dart';
import 'package:healr/features/notification/data/repo/notification_repo.dart';
import 'package:healr/features/notification/ui/manager/notificationCubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo notificationRepo;

  NotificationCubit(this.notificationRepo) : super(NotificationInitial());

  List<MedicineModel> _medicines = [];

  List<MedicineModel> get medicines => _medicines;

  void startPolling() {
    fetchTimelineItems();
  }

  Future<void> fetchTimelineItems() async {
    emit(NotificationLoading());

    final medicineResult = await notificationRepo.getMedicine();
    final notificationResult = await notificationRepo.getNotifications();

    List<TimelineItem> combinedItems = [];

    bool hasFailure = false;

    medicineResult.fold(
      (failure) {
        emit(NotificationFailure(failure.errMessage));
        hasFailure = true;
      },
      (medicines) {
        _medicines = medicines;
        combinedItems.addAll(medicines.map((m) => TimelineMedicineItem(m)));
      },
    );

    if (hasFailure) return;

    notificationResult.fold(
      (failure) => emit(NotificationFailure(failure.errMessage)),
      (notifications) {
        combinedItems
            .addAll(notifications.map((n) => TimelineNotificationItem(n)));
      },
    );

    if (combinedItems.isEmpty) {
      emit(NotificationEmpty());
    } else {
      combinedItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(NotificationMixedSuccess(combinedItems));
    }
  }

  Future<void> deleteOneMedicine(String medicineId) async {
    final result = await notificationRepo.deleteMedicine(medicineId);

    result.fold(
      (failure) {
        emit(NotificationFailure(failure.errMessage));
      },
      (_) async {
        _medicines.removeWhere((med) => med.id == medicineId);

        // نجيب الإشعارات تاني بعد حذف الدواء
        final notificationResult = await notificationRepo.getNotifications();

        List<TimelineItem> combinedItems = [];

        combinedItems.addAll(_medicines.map((m) => TimelineMedicineItem(m)));

        notificationResult.fold(
          (failure) => emit(NotificationFailure(failure.errMessage)),
          (notifications) {
            combinedItems
                .addAll(notifications.map((n) => TimelineNotificationItem(n)));

            if (combinedItems.isEmpty) {
              emit(NotificationEmpty());
            } else {
              combinedItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
              emit(NotificationMixedSuccess(combinedItems));
            }
          },
        );
      },
    );
  }
}
