import 'package:shared_preferences/shared_preferences.dart';

String? appointDay = "";
String? appointTime = "";
bool? isBooked;

// Map to track booking status for each token (backup for performance)
Map<String, bool> userBookingStatus = {};

// Helper functions to manage booking status by token with SharedPreferences
Future<void> setUserBookingStatus(String token, bool isBooked) async {
  final prefs = await SharedPreferences.getInstance();
  userBookingStatus[token] = isBooked; // Update in-memory cache
  await prefs.setBool('booking_$token', isBooked); // Persist to storage
}

Future<bool> getUserBookingStatus(String token) async {
  // First check in-memory cache for performance
  if (userBookingStatus.containsKey(token)) {
    return userBookingStatus[token]!;
  }

  // If not in cache, load from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final isBooked = prefs.getBool('booking_$token') ?? false;
  userBookingStatus[token] = isBooked; // Cache the result
  return isBooked;
}

Future<void> clearUserBookingStatus(String token) async {
  final prefs = await SharedPreferences.getInstance();
  userBookingStatus.remove(token); // Remove from cache
  await prefs.remove('booking_$token'); // Remove from storage
}

// Load all booking statuses from SharedPreferences on app start
Future<void> loadAllBookingStatuses() async {
  final prefs = await SharedPreferences.getInstance();
  final keys = prefs.getKeys();

  for (String key in keys) {
    if (key.startsWith('booking_')) {
      String token = key.substring(8); // Remove 'booking_' prefix
      bool isBooked = prefs.getBool(key) ?? false;
      userBookingStatus[token] = isBooked;
    }
  }
}

// Clear all booking data (useful for logout)
Future<void> clearAllBookingData() async {
  final prefs = await SharedPreferences.getInstance();
  final keys = prefs.getKeys();

  // Remove all booking-related keys
  for (String key in keys) {
    if (key.startsWith('booking_')) {
      await prefs.remove(key);
    }
  }

  // Clear in-memory cache
  userBookingStatus.clear();
}

// Synchronous helper function for immediate UI checks (uses cache)
bool getUserBookingStatusSync(String token) {
  return userBookingStatus[token] ?? false;
}
