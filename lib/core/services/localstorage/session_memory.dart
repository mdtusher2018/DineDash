class SessionMemory {
  static final SessionMemory _instance = SessionMemory._internal();
  factory SessionMemory() => _instance;
  SessionMemory._internal();

  String? _token;
  bool? _isUser;

  void setToken(String token) {
    _token = token;
  }

  String? get token => _token;

  void setRole(bool isUser) {
    _isUser = isUser;
  }

  bool? get roleIsUser => _isUser;

  void clear() {
    _token = null;
    _isUser = null;
  }
}
