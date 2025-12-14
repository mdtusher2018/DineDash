class OTPVerificationResponse {
  final String status;
  final int statusCode;
  final String message;
  final String accessToken;

  OTPVerificationResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.accessToken,
  });

  factory OTPVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OTPVerificationResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      accessToken: json['data']?['forgetPasswordToken'] ?? '',
    );
  }
}
