import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

String getFullImagePath(String imagePath) {
  if (imagePath.isEmpty) {
    return "";
  }
  if (imagePath.contains("public")) {
    imagePath = imagePath.replaceFirst("public", "");
  }

  if (imagePath.startsWith('http')) {
    return imagePath;
  }
  if (imagePath.startsWith('/')) {
    return '${ApiEndpoints.baseImageUrl}$imagePath';
  }
  return '${ApiEndpoints.baseImageUrl}/$imagePath';
}

String timeAgo(String timestamp) {
  DateTime? dateTime = DateTime.tryParse(timestamp);
  if (dateTime == null) {
    return 'Invalid date';
  }
  Duration difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    int minutes = difference.inMinutes;
    return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
  } else if (difference.inHours < 24) {
    int hours = difference.inHours;
    return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inDays < 30) {
    int days = difference.inDays;
    return '$days ${days == 1 ? 'day' : 'days'} ago';
  } else if (difference.inDays < 365) {
    int months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else {
    int years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  }
}

String formatDuration(Duration d) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String h = twoDigits(d.inHours);
  String m = twoDigits(d.inMinutes.remainder(60));
  String s = twoDigits(d.inSeconds.remainder(60));
  return "$h:$m:$s";
}

Map<String, dynamic> decodeJwtPayload(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return {};

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final payloadBytes = base64Url.decode(normalized);
    final payloadString = utf8.decode(payloadBytes);

    return json.decode(payloadString) as Map<String, dynamic>;
  } catch (e) {
    return {};
  }
}

Future<String?> getCityName(Position position) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );

  if (placemarks.isNotEmpty) {
    return placemarks.first.locality; // City
  }
  return null;
}

Future<Position> getCurrentPosition({
  required BaseController? controller,
}) async {
  Position fallbackPosition = Position(
    latitude: 11.5730556,
    longitude: 49.9436111,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );

  return (await controller?.safeCall<Position>(
        task: () async {
          try {
            LocationPermission permission = await Geolocator.checkPermission();

            if (permission == LocationPermission.deniedForever ||
                permission == LocationPermission.denied) {
              permission = await Geolocator.requestPermission();
            }

            if (permission == LocationPermission.denied ||
                permission == LocationPermission.deniedForever) {
              return fallbackPosition;
            }

            final position = await Geolocator.getCurrentPosition();

            return position;
          } catch (_) {
            return fallbackPosition;
          }
        },
        showErrorSnack: true,
        showLoading: false,
      )) ??
      fallbackPosition;
}

Future<File?> fetchImageFile(String photoRef) async {
  try {
    final url =
        "https://maps.googleapis.com/maps/api/place/photo"
        "?maxwidth=800"
        "&photoreference=$photoRef"
        "&key=${ApiEndpoints.mapKey}";
    log(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final tempDir = await getTemporaryDirectory();
      final file = File(
        "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg",
      );

      await file.writeAsBytes(response.bodyBytes);

      return file;
    }
  } catch (_) {}
  return null;
}

String formatBookingTime(String bookingStart, String bookingEnd) {
  // Function to parse the time string into DateTime
  DateTime? parseTime(String time) {
    DateTime? parsedTime = DateTime.tryParse(time);
    return parsedTime;
  }

  // Parse the start and end times
  DateTime? startTime = parseTime(bookingStart);
  DateTime? endTime = parseTime(bookingEnd);

  // Handle invalid time format
  if (startTime == null || endTime == null) {
    print("Error formatting booking times: Invalid time format");
    return "-- - --";
  }

  // Format the DateTime objects into the desired "hh:mm a" format
  String startFormatted = DateFormat('hh:mm a').format(startTime);
  String endFormatted = DateFormat('hh:mm a').format(endTime);

  // Return the formatted time range
  return '$startFormatted - $endFormatted';
}

// Function to generate days dynamically from today
List<String> generateDayOptions() {
  List<String> days = [];
  DateTime today = DateTime.now();
  List<String> dayNames = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  // Add "Today" and "Tomorrow" first
  days.add("Today");
  days.add("Tomorrow");

  // Now add the next 5 days starting from the day after tomorrow
  for (int i = 2; i < 7; i++) {
    // Calculate the next days
    DateTime nextDay = today.add(Duration(days: i));
    String dayName = dayNames[nextDay.weekday % 7];
    days.add(dayName);
  }

  return days;
}

String getDayOfWeek(DateTime date) {
  List<String> weekDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  return weekDays[date.weekday %
      7]; // `weekday` gives 1 for Monday, 7 for Sunday
}

String to24Hour(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0'); // already 0–23
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

bool isValidSameDayRange(TimeOfDay start, TimeOfDay end) {
  final startMinutes = start.hour * 60 + start.minute;
  final endMinutes = end.hour * 60 + end.minute;

  return endMinutes > startMinutes;
}
