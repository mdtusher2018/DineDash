class ResetPasswordResponse {
  final String status;
  final int statusCode;
  final String message;
  final String accessToken;

  ResetPasswordResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.accessToken,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      accessToken: json['data']?['accessToken'] ?? '',
    );
  }
}
