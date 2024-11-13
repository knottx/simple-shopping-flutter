import 'dart:io';

class AppConfig {
  AppConfig._();

  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080';
    } else {
      return 'http://127.0.0.1:8080';
    }
  }
}
