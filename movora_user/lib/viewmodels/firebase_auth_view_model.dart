import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movora/services/firebase_auth_services.dart';

class FirebaseAuthViewModel extends ChangeNotifier {
  final FirebaseAuthServices _firebaseAuth = FirebaseAuthServices();

  User? _user;
  User? get user => _user;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> signUp(String email, String password) async {
    try {
      _loading = true;
      notifyListeners();

      _user = await _firebaseAuth.signup(email, password);
      if (_user == null) {
        _error = "Login failed. check email and password";
      } else {
        _error = null;
      }
    } catch (e) {
      _error = "Something went wrong: $e";
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      _loading = true;
      notifyListeners();
      _user = await _firebaseAuth.login(email, password);
      if (_user == null) {
        _error = "Login failed. check email and password";
      } else {
        _error = null;
      }
    } catch (e) {
      _error = "Something went wrong: $e";
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      _user = null;
      _error = null;
    } catch (e) {
      _error = "Logout failed: $e";
    }
    notifyListeners();
  }

  bool _obscurePassword = true;

  bool get obscurePassword => _obscurePassword;

  void toggleObscure() {
    _obscurePassword = !_obscurePassword;
    notifyListeners(); // updates UI
  }

  bool _isTypingPassword = false;
  bool get isTypingPassword => _isTypingPassword;

  void setTypingPassword(bool value) {
    _isTypingPassword = value;
    notifyListeners();
  }
}
