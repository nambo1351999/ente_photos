import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  bool _initialized = false;

  AuthService() : _firebaseAuth = FirebaseAuth.instance {
    _firebaseAuth.authStateChanges().listen((user) {
      _initialized = true;
      notifyListeners();
    });
  }

  bool get initialized => _initialized;
  bool get isAuthenticated => _firebaseAuth.currentUser != null;
} 