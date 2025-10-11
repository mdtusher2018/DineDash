class UserSignUpResponse {
  final String status;
  final int statusCode;
  final String message;
  final String? signUpToken;

  UserSignUpResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.signUpToken,
  });

  factory UserSignUpResponse.fromJson(Map<String, dynamic> json) {
    return UserSignUpResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      signUpToken: json['data']?['signUpToken'],
    );
  }
}
