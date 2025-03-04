import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../../../core/router/app_router.dart';
import '../../../core/router/auth_service.dart';
import '../../../core/storage/storage_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final StorageService _storageService;
  final AuthService _authService;

  AuthBloc(
    this._storageService,
  ) : _firebaseAuth = FirebaseAuth.instance,
      _googleSignIn = GoogleSignIn(),
      _authService = authService,
      super(AuthInitial()) {
    // Initialize state based on current auth status
    if (_authService.isAuthenticated) {
      final user = _firebaseAuth.currentUser!;
      emit(AuthAuthenticated(
        token: null, // Token will be fetched when needed
        userId: user.uid,
      ));
    }

    on<LoginWithEmailEvent>(_onLoginWithEmail);
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
    on<LoginWithAppleEvent>(_onLoginWithApple);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLoginWithEmail(
    LoginWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());

      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      final user = userCredential.user;
      if (user != null) {
        final token = await user.getIdToken();
        await _storageService.saveAuthToken(token);
        await _storageService.saveUserId(user.uid);

        emit(AuthAuthenticated(token: token, userId: user.uid));
      } else {
        emit(const AuthError('Failed to sign in'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Authentication failed'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(const AuthError('Google sign in cancelled'));
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final token = await user.getIdToken();
        await _storageService.saveAuthToken(token);
        await _storageService.saveUserId(user.uid);

        emit(AuthAuthenticated(token: token, userId: user.uid));
      } else {
        emit(const AuthError('Failed to sign in with Google'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLoginWithApple(
    LoginWithAppleEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());

      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(oauthCredential);
      final user = userCredential.user;

      if (user != null) {
        final token = await user.getIdToken();
        await _storageService.saveAuthToken(token);
        await _storageService.saveUserId(user.uid);

        emit(AuthAuthenticated(token: token, userId: user.uid));
      } else {
        emit(const AuthError('Failed to sign in with Apple'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _storageService.clearUserData(),
      ]);
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
} 