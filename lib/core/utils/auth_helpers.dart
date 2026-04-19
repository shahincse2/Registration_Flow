class AuthHelper {
  static Future<bool> sendOtp() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return true; // success
    } catch (e) {
      return false; // failed
    }
  }
}