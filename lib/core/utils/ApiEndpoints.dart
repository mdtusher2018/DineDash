class ApiEndpoints {
  static const String baseUrl =
      'http://147.93.29.184:8020/api/v1/'; // Replace with actual base URL
  static const String baseImageUrl =
      'http://147.93.29.184:8020'; // Replace with actual base image URL
  // static const String baseUrl =
  //     'http://10.10.10.33:8020/api/v1/'; // Replace with actual base URL
  // static const String baseImageUrl =
  //     'http://10.10.10.33:8020'; // Replace with actual base image URL

  //authentication
  static String signin = "auth/signin";

  static String userSignUp = "auth/sign-up";

  static String emailVerification = "auth/verify-email";
  static String resendOTP = "auth/resend-otp";

  static String forgetPassword = "auth/forget-password";
  static String verifyOTP = "auth/verify-otp";

  static String userHomePage({String? city, String? searchTerm}) {
  final params = <String, String>{};

  if (city != null && city.isNotEmpty) params['cityName'] = city;
  if (searchTerm != null && searchTerm.isNotEmpty) params['name'] = searchTerm;

  if (params.isEmpty) return "home";

  final queryString = params.entries.map((e) => "${e.key}=${e.value}").join("&");
  return "home?$queryString";
}


  static String favoriteList({String? city, String? searchTerm}) {
  final params = <String, String>{};

  if (city != null && city.isNotEmpty) params['cityName'] = city;
  if (searchTerm != null && searchTerm.isNotEmpty) params['name'] = searchTerm;

  if (params.isEmpty) return "favourite/myfavourites";

  final queryString = params.entries.map((e) => "${e.key}=${e.value}").join("&");
  return "favourite/myfavourites?$queryString";
}



  static String menu(String businessId) => "menu/all-byBusinessId/$businessId";

  static String businessDetails(String businessId) =>
      "business/businessById/$businessId";

  static String addFavorite = "favourite/add";
  static String businessNearestList = "business/nearest-list";

  static String cities="city/all";
  
  static String removeFavorite(String businessId) =>
      "favourite/unfavourite/$businessId";

  static String nearbyBusinesses({required double lat, required double lng}) {
    return "business/nearest-map?lat=$lat&lng=$lng";
  }
}
