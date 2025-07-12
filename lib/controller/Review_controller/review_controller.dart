import 'package:get/get.dart';

class BusinessController extends GetxController {
  final List<String> businessList = [
    'All Business names',
    'Others Business names',
  ];
  final List<String> rattingList = [
   " All Stars",
   " 5 Stars",
    "4 Stars",
   " 3 Stars",
   " 2 Stars",
    "1 Stars"
  ];
  final RxList<String> shortList = [
    "Newest first",
    "Oldest first",
    "Highest rating",
  ].obs;

  RxString selectedBusiness = ''.obs;
  RxString selectedRatting = ''.obs;
  RxString selectedShortBy = ''.obs;

  void setSelectedBusiness(String value) {
    selectedBusiness.value = value;
  }
  void setSelectedRatting(String value) {
    selectedRatting.value = value;
  }
  void setSelectedShortBy(String value) {
    selectedShortBy.value = value;
  }
}
