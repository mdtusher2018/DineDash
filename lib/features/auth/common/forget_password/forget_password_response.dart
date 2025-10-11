class ForgetPasswordResponse {
  final String status;
  final int statusCode;
  final String message;
  final String? forgetPasswordToken;

  ForgetPasswordResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.forgetPasswordToken,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      forgetPasswordToken: json['data']?['attributes'],
    );
  }
}
