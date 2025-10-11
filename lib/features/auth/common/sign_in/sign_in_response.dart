class SignInResponse {
  final String status;
  final int statusCode;
  final String message;
  final String accessToken;

  SignInResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.accessToken,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      accessToken: json['data']?['accessToken'] ?? '',
    );
  }
}
