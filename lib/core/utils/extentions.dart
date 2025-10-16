

extension NumDurationFormatter on num {
  String formatDuration() {
    final duration = Duration(seconds: toInt());

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return "${hours.toString().padLeft(2, '0')}:"
          "${minutes.toString().padLeft(2, '0')}:"
          "${secs.toString().padLeft(2, '0')}";
    } else {
      return "${minutes.toString().padLeft(2, '0')}:"
          "${secs.toString().padLeft(2, '0')}";
    }
  }
}



extension InputValidator on String {
  bool get isNullOrEmpty => trim().isEmpty;

  /// Validates email format
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(trim());
  }

  bool get isValidPassword {
    final passRegex = RegExp(r'^.{6,16}$');
    return passRegex.hasMatch(trim());
  }

  bool get isValidName {
    final nameRegex = RegExp(r"^[a-zA-Z\s]{2,50}$");
    return nameRegex.hasMatch(trim());
  }
}