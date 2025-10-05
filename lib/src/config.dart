import 'dart:io'; // For platform detection

class Config {
  Config._(); // Private constructor to prevent instantiation
  
  // Allows overriding at build/run time:
  // flutter run --dart-define=BACKEND_URL=http://192.168.x.y:5000
  static String get backendUrl {
    const fromEnv = String.fromEnvironment('BACKEND_URL');
    if (fromEnv.isNotEmpty) return fromEnv;

    // Platform-specific defaults:
    if (Platform.isAndroid) {
      // Android emulator -> host machine is 10.0.2.2
      return 'http://10.0.2.2:5000';
    }
    // iOS simulator / mac -> localhost works
    return 'http://localhost:5000';
  }
}
