import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    if (savedEmail == email && savedPassword == password) {
      return true;
    }
    return false;
  }

  Future<bool> signup(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    return true;
  }

  Future<void> resetPassword(String email, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('password', newPassword);
  }
}
