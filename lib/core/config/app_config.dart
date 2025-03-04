class AppConfig {
  static const String appName = 'Ente Photos';
  static const String apiBaseUrl = 'https://api.example.com';
  
  // API Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  
  // Hive Box Names
  static const String userBox = 'userBox';
  static const String settingsBox = 'settingsBox';
  
  // Shared Preferences Keys
  static const String authToken = 'authToken';
  static const String userId = 'userId';
  
  // App Settings
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // Cache Settings
  static const int maxCacheSize = 100;
  static const Duration cacheValidDuration = Duration(days: 7);
} 