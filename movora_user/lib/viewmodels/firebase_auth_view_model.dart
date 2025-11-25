import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movora/models/user_model.dart';
import 'package:movora/services/firebase_auth_services.dart';
import 'package:movora/services/firestore_service.dart';

class FirebaseAuthViewModel extends ChangeNotifier {
  final FirebaseAuthServices _firebaseAuth = FirebaseAuthServices();
  final FirestoreService _firestoreService = FirestoreService();
  bool isLoading = false;
  User? _user;
  User? get user => _user;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  String? _message;
  String? get message => _message;

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

  Future<void> initUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      debugPrint("⚠️ No logged-in user");
      return;
    }

    _user = firebaseUser;

    // Fetch Firestore user profile
    await fetchUserDetails(firebaseUser.uid);
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
      notifyListeners();
      await _firebaseAuth.signOut();
      _user = null;
      _error = null;
    } catch (e) {
      _error = "Logout failed: $e";
    }

    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.forgotPassword(email);

      _message = "Password reset email sent"; // optional success message
    } catch (e) {
      _error = e.toString();
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

  Future<void> saveUserDetails(UserModel user) async {
    isLoading = true;
    notifyListeners();

    await _firestoreService.saveUser(user);

    isLoading = false;
    notifyListeners();
  }

  UserModel? currentUserModel;

  Future<void> fetchUserDetails(String uid) async {
    isLoading = true;
    notifyListeners();

    try {
      currentUserModel = await _firestoreService.getUser(uid);
    } catch (e) {
      debugPrint("❌ Error fetch booking: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}
