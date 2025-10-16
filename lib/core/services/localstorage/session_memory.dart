class SessionMemory {
  static final SessionMemory _instance = SessionMemory._internal();
  factory SessionMemory() => _instance;
  SessionMemory._internal();

  String? _token;
  void setToken(String token) => _token = token;
  String? get token => _token;

  bool? _isUser;
  void setRole(bool isUser) => _isUser = isUser;
  bool? get roleIsUser => _isUser;

  double? _latitude, _longitude;
  void setUserLocation(double latitude, double longitude) {
    _latitude = latitude;
    _longitude = longitude;
  }

  (double?, double?) get userLocation => (_latitude, _longitude);
  

  void clear() {
    _token = null;
    _isUser = null;
    _latitude = null;
    _longitude = null;
  }
}
