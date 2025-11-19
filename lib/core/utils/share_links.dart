class ShareLinks {
  static const String baseUrl = "http://147.93.29.184:8020";

  static Uri business(String businessId) {
    return Uri.parse("$baseUrl/business/$businessId");
  }

  static Uri deal(String dealId) {
    return Uri.parse("$baseUrl/deal/$dealId");
  }
}
