class SessionMemory {
  static final SessionMemory _instance = SessionMemory._internal();
  factory SessionMemory() => _instance;
  SessionMemory._internal();

  String? _token;
  void setToken(String token) => _token = token;
  String? get token => _token;

  static bool isUser = true;

  void clear() {
    _token = null;
  }

  String? _email;
  void setEmail(String email) => _email = email;
  String? get email => _email;
}
