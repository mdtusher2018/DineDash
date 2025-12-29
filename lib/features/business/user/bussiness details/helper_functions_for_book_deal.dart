import 'package:dine_dash/core/models/business_model.dart';
import 'package:flutter/material.dart';

Map<String, List<ActiveTime>> groupOpeningHoursByDay(List<ActiveTime> hours) {
  final Map<String, List<ActiveTime>> grouped = {};

  for (final hour in hours) {
    grouped.putIfAbsent(hour.day, () => []);
    grouped[hour.day]!.add(hour);
  }

  return grouped;
}

int weekdayFromString(String day) {
  switch (day.toLowerCase()) {
    case 'monday':
      return DateTime.monday;
    case 'tuesday':
      return DateTime.tuesday;
    case 'wednesday':
      return DateTime.wednesday;
    case 'thursday':
      return DateTime.thursday;
    case 'friday':
      return DateTime.friday;
    case 'saturday':
      return DateTime.saturday;
    case 'sunday':
      return DateTime.sunday;
    default:
      return DateTime.monday;
  }
}

DateTime nextDateForWeekday(int weekday) {
  final now = DateTime.now();
  int diff = weekday - now.weekday;
  if (diff < 0) diff += 7;
  return now.add(Duration(days: diff));
}

String getDayLabel(DateTime date) {
  final now = DateTime.now();

  if (DateUtils.isSameDay(date, now)) {
    return 'TODAY';
  }

  if (DateUtils.isSameDay(date, now.add(const Duration(days: 1)))) {
    return 'TOMORROW';
  }

  return "${_weekdayName(date.weekday)}, "
      "${date.day.toString().padLeft(2, '0')} "
      "${_monthName(date.month)} ${date.year}";
}

String _weekdayName(int weekday) {
  const names = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  return names[weekday - 1];
}

String _monthName(int month) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return months[month - 1];
}
