import 'package:dine_dash/translations/english.dart';
import 'package:dine_dash/translations/spanish.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    'de_DE': de_DE,
  };
}
