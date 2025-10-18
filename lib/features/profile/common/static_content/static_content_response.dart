class StaticContentResponse {
  final String status;
  final int statusCode;
  final String message;
  final StaticContentData? data;
  final List<dynamic>? errors;

  StaticContentResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
    this.errors,
  });

  factory StaticContentResponse.fromJson(Map<String, dynamic> json) {
    return StaticContentResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? StaticContentData.fromJson(json['data'])
          : null,
      errors: json['errors'],
    );
  }
}

class StaticContentData {
  final String? type;
  final StaticAttributes? attributes;

  StaticContentData({this.type, this.attributes});

  factory StaticContentData.fromJson(Map<String, dynamic> json) {
    return StaticContentData(
      type: json['type'],
      attributes: json['attributes'] != null
          ? StaticAttributes.fromJson(json['attributes']??{})
          : null,
    );
  }
}

class StaticAttributes {
  final String id;
  final StaticContent content;

  StaticAttributes({
    required this.id,
    required this.content,
  });

  factory StaticAttributes.fromJson(Map<String, dynamic> json) {
    return StaticAttributes(
      id: json['_id'] ?? '',
      content: StaticContent.fromJson(json['content']??{}),
    );
  }
}

class StaticContent {
  final String id;
  final String en;
  final String de;

  StaticContent({
    required this.id,
    required this.en,
    required this.de,
  });

  factory StaticContent.fromJson(Map<String, dynamic> json) {
    return StaticContent(
      id: json['_id'] ?? '',
      en: json['en'] ?? '',
      de: json['de'] ?? '',
    );
  }
}
