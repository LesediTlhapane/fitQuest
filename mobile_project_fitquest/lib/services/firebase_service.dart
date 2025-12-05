class FirebaseService {
  dynamic currentUser() {
    // return null if not logged in, or a dummy user object
    return null;
  }

  Future<void> signIn(String email, String password) async {
    // Simulate login
    await Future.delayed(const Duration(seconds: 1));
    if (email != "test@test.com" || password != "123456") {
      throw Exception("Invalid credentials");
    }
  }

  Future<void> register(String email, String password) async {
    // Simulate registration
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<Object?>? fetchRuns() async {}
}
