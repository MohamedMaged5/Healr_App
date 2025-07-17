import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/appoint_cache.dart';
import 'package:healr/features/notification/ui/views/widgets/local_notification.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  Future<void> book() async {
    emit(BookingLoading());

    await Future.delayed(const Duration(seconds: 1));

    // Get current user's token
    String currentToken = kToken ?? "default_user";

    // Check booking status for current user (now async)
    bool currentUserBooked = await getUserBookingStatus(currentToken);

    if (currentUserBooked == true) {
      emit(BookingSuccess());
    } else {
      emit(BookingFailure());
    }
  }

  // Method to book appointment for current user
  Future<void> bookAppointment() async {
    String currentToken = kToken ?? "default_user";
    await setUserBookingStatus(currentToken, true);
    await book(); // Refresh the UI
  }

  // Method to cancel appointment for current user
  Future<void> cancelAppointment() async {
    LocalNotification.showInstantNotification(
      id: 3,
      title: 'Appointment Cancelled',
      body: 'Your appointment has been successfully cancelled.',
    );
    String currentToken = kToken ?? "default_user";
    await setUserBookingStatus(currentToken, false);
    await book(); // Refresh the UI
  }

  // Method to check if current user has an active booking
  Future<bool> isAppointmentBookedForCurrentUser() async {
    String currentToken = kToken ?? "default_user";
    return await getUserBookingStatus(currentToken);
  }

  // Synchronous method for immediate UI checks (uses cached data)
  bool isAppointmentBookedForCurrentUserSync() {
    String currentToken = kToken ?? "default_user";
    return getUserBookingStatusSync(currentToken);
  }

  Future<void> clearUserBookingState() async {
    String currentToken = kToken ?? "default_user";
    await clearUserBookingStatus(currentToken);
    emit(BookingInitial()); // Reset to initial state
    await book();
  }
}
