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

  static String userHomePage = "home/";

  static String businessDetails(String businessId) =>
      "business/businessById/$businessId";
}
