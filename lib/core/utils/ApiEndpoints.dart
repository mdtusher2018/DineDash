class ApiEndpoints {
  static String mapKey = "AIzaSyBuSZJklSc1j0D4kqhkJcmyArcZbWujbXQ";

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
    if (searchTerm != null && searchTerm.isNotEmpty) {
      params['name'] = searchTerm;
    }

    if (params.isEmpty) return "home";

    final queryString = params.entries
        .map((e) => "${e.key}=${e.value}")
        .join("&");
    return "home?$queryString";
  }

  static String favoriteList({String? city, String? searchTerm}) {
    final params = <String, String>{};

    if (city != null && city.isNotEmpty) params['cityName'] = city;
    if (searchTerm != null && searchTerm.isNotEmpty) {
      params['name'] = searchTerm;
    }

    if (params.isEmpty) return "favourite/myfavourites";

    final queryString = params.entries
        .map((e) => "${e.key}=${e.value}")
        .join("&");
    return "favourite/myfavourites?$queryString";
  }

  static String menu(String businessId) => "menu/all-byBusinessId/$businessId";

  static String businessDetails(String businessId) =>
      "business/businessById/$businessId";

  static String addFavorite = "favourite/add";

  static String businessNearestList({
    String? city,
    String? searchTerm,
    String? sortBy,
    required int page,
  }) {
    final params = <String, String>{};

    if (city != null && city.isNotEmpty) {
      params['cityName'] = city.toLowerCase();
    }
    if (searchTerm != null && searchTerm.isNotEmpty) {
      params['name'] = searchTerm.toLowerCase();
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      params['priceSort'] = sortBy.toLowerCase();
    }
    params['page'] = page.toString();
    if (params.isEmpty) return "business/nearest-list";

    final queryString = params.entries
        .map((e) => "${e.key}=${e.value}")
        .join("&");
    return "business/nearest-list?$queryString";
  }

  static String cities = "city/all";

  static String userProfile = "users/user-details";

  static String updateProfile = "users/";

  static String changePassword = "auth/change-password";

  static String removeFavorite(String businessId) =>
      "favourite/unfavourite/$businessId";

  static String nearbyBusinesses({required double lat, required double lng}) {
    return "business/nearest-map?lat=$lat&lng=$lng";
  }

  static String userNotifications({required int page}) {
    return "notifications/notification-userend?page=$page&limit=10";
  }

  static String markNotificationAsRead(String notificationId) {
    return "notifications/read/$notificationId";
  }

  static String staticContent(String type) {
    return "static-contents?type=$type";
  }

  static String switchAccount = "auth/switch-account";

  static String createBusiness = "business/add-business";
  static String editBusiness(String businessId) => "business/edit-business/$businessId";

  static String addMenu = "menu/add";

  static String deleteBusiness(String businessId) =>
      "business/delete/$businessId";

  static String dealerBusinessDetail(String businessId) =>
      "business/my-businessDetails/$businessId";

  static String dealerHomepageAllBusiness(int page) =>
      "business/home?page=$page";

  static String dealerAllBusiness(int page) =>
      "business/my-business?page=$page";

  static String review({
    required int page,
    String? businessId,
    int? ratting,
    String? sortBy,
  }) {
    String url = "feedback/myall-feedback?page=$page";
    if (businessId != null) {
      url += "&businessId=$businessId";
    }
    if (ratting != null) {
      url += "&ratting=$ratting";
    }
    if (sortBy != null) {
      url += "&sortBy=$sortBy";
    }

    return url;
  }

  static String dealerMyBusinessNameList = "business/my-business-names";

  static String createDeal = "deal/add";

  static String getAllDeals="deal/my-all-deal";
  static String editDeal(String dealId) => "deal/edit-deal/$dealId";

  static String deleteDeal(String dealId) => "deal/delete-deal-req/$dealId";

  static String dealDetailsById(String dealId) {
    return "deal/deal-details/$dealId";
  }
}
