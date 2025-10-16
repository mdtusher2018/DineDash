class MenuResponse {
  final String status;
  final int statusCode;
  final String message;
  final MenuData data;
  final List<dynamic> errors;

  MenuResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory MenuResponse.fromJson(Map<String, dynamic> json) {
    return MenuResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: MenuData.fromJson(json['data'] ?? {}),
      errors: json['errors'] ?? [],
    );
  }
}

class MenuData {
  final String type;
  final List<MenuItem> menu;

  MenuData({required this.type, required this.menu});

  factory MenuData.fromJson(Map<String, dynamic> json) {
    List<MenuItem> parseMenu(dynamic list) =>
        list != null
            ? (list as List)
                .map((e) => MenuItem.fromJson(e))
                .toList()
            : [];

    return MenuData(
      type: json['type'] ?? '',
      menu: parseMenu(json['attributes']?['menu']),
    );
  }
}

class MenuItem {
  final String id;
  final String businessId;
  final String itemName;
  final String description;
  final num price;

  MenuItem({
    required this.id,
    required this.businessId,
    required this.itemName,
    required this.description,
    required this.price,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['_id'] ?? '',
      businessId: json['business'] ?? '',
      itemName: json['itemName'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
    );
  }
}
