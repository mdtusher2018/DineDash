class ContactUsResponse {
  final String status;
  final int statusCode;
  final String message;
  final String email;
  final String phoneNumber;

  ContactUsResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.email,
    required this.phoneNumber,
  });

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data']?['attributes'] ?? {};

    return ContactUsResponse(
      status: json['status']?.toString() ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message']?.toString() ?? '',
      email: data?['email']?.toString() ?? 'example@gmail.com',
      phoneNumber: data?['phoneNumber']?.toString() ?? '(609) 327-7992',
    );
  }
}
