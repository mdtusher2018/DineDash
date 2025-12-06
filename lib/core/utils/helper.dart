import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

String getFullImagePath(String imagePath) {
  if (imagePath.isEmpty) {
    return "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg";
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

Future<String> calculateDistance({
  required double targetLatitude,
  required double targetLongitude,
}) async {
  try {
    final SessionMemory session = Get.find();
    var (lat, lon) = session.userLocation;

    if (lat == null || lon == null) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      lat = currentPosition.latitude;
      lon = currentPosition.longitude;

      session.setUserLocation(lat, lon);
    }

    final distanceInMeters = Geolocator.distanceBetween(
      lat,
      lon,
      targetLatitude,
      targetLongitude,
    );

    if (distanceInMeters >= 1000) {
      final distanceInKm = distanceInMeters / 1000;
      return "${distanceInKm.toStringAsFixed(1)} km";
    } else {
      return "${distanceInMeters.toStringAsFixed(0)} m";
    }
  } catch (e) {
    return "N/A";
  }
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

Future<Position> getCurrentPosition({
  required BaseController? controller,
}) async {
  Position fallbackPosition = Position(
    latitude: 23.8103,
    longitude: 90.4125,
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
