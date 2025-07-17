import 'package:healr/features/notification/data/models/medicine_model.dart';
import 'package:intl/intl.dart';

String getDateGroupLabel(String createdAt) {
  final DateTime date = DateTime.parse(createdAt);
  final DateTime now = DateTime.now();
  final DateTime today = DateTime(now.year, now.month, now.day);
  final DateTime yesterday = today.subtract(const Duration(days: 1));
  final DateTime inputDate = DateTime(date.year, date.month, date.day);

  if (isSameDay(inputDate, today)) return "Today";
  if (isSameDay(inputDate, yesterday)) return "Yesterday";

  return DateFormat('dd/MM/yyyy').format(inputDate);
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

Map<String, List<MedicineModel>> groupMedicinesByDate(
    List<MedicineModel> medicines) {
  final Map<String, List<MedicineModel>> grouped = {};

  for (var med in medicines) {
    final key = getDateGroupLabel(med.timeOfCreation);
    if (!grouped.containsKey(key)) {
      grouped[key] = [];
    }
    grouped[key]!.add(med);
  }

  final sortedKeys = grouped.keys.toList()
    ..sort((a, b) {
      DateTime parseDate(String key) {
        if (key == 'Today') return DateTime.now();
        if (key == 'Yesterday') {
          return DateTime.now().subtract(const Duration(days: 1));
        }
        return DateFormat('dd/MM/yyyy').parse(key);
      }

      return parseDate(b).compareTo(parseDate(a));
    });

  final Map<String, List<MedicineModel>> sortedGrouped = {
    for (final key in sortedKeys)
      key: grouped[key]!
        ..sort((a, b) =>
            b.timeOfCreation.compareTo(a.timeOfCreation)) 
  };

  return sortedGrouped;
}
