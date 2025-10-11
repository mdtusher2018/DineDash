
class EmailVerificationResponse {
  final String status;
  final int statusCode;
  final String message;
  final String accessToken;

  EmailVerificationResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.accessToken,
  });

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) {
    return EmailVerificationResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      accessToken: json['data']?['accessToken'] ?? '',
    );
  }
}
