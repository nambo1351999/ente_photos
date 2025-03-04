import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../config/app_config.dart';

@singleton
class StorageService {
  late Box _userBox;
  late Box _settingsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    
    _userBox = await Hive.openBox(AppConfig.userBox);
    _settingsBox = await Hive.openBox(AppConfig.settingsBox);
  }

  // User Box Methods
  Future<void> saveAuthToken(String? token) async {
    await _userBox.put(AppConfig.authToken, token);
  }

  String? getAuthToken() {
    return _userBox.get(AppConfig.authToken);
  }

  Future<void> saveUserId(String userId) async {
    await _userBox.put(AppConfig.userId, userId);
  }

  String? getUserId() {
    return _userBox.get(AppConfig.userId);
  }

  // Settings Box Methods
  Future<void> saveSetting(String key, dynamic value) async {
    await _settingsBox.put(key, value);
  }

  dynamic getSetting(String key) {
    return _settingsBox.get(key);
  }

  // Clear Storage
  Future<void> clearUserData() async {
    await _userBox.clear();
  }

  Future<void> clearSettings() async {
    await _settingsBox.clear();
  }

  Future<void> clearAll() async {
    await clearUserData();
    await clearSettings();
  }
} 