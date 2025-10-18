import 'package:dine_dash/model/user_model.dart';

class SwitchAccountResponse {
  final String status;
  final int statusCode;
  final String message;
  final SwitchedAccountData? data;
  final List<dynamic>? errors;

  SwitchAccountResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
    this.errors,
  });

  factory SwitchAccountResponse.fromJson(Map<String, dynamic> json) {
    return SwitchAccountResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? SwitchedAccountData.fromJson(json['data'])
          : null,
      errors: json['errors'] ?? [],
    );
  }
}

class SwitchedAccountData {
  final SwitchedAccountAttributes? attributes;
  final String? type;

  SwitchedAccountData({this.attributes, this.type});

  factory SwitchedAccountData.fromJson(Map<String, dynamic> json) {
    return SwitchedAccountData(
      type: json['type'],
      attributes: json['attributes'] != null
          ? SwitchedAccountAttributes.fromJson(json['attributes'])
          : null,
    );
  }
}

class SwitchedAccountAttributes {
  final UserModel? user;
  final String? accessToken;

  SwitchedAccountAttributes({this.user, this.accessToken});

  factory SwitchedAccountAttributes.fromJson(Map<String, dynamic> json) {
    return SwitchedAccountAttributes(
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      accessToken: json['accessToken'],
    );
  }
}
