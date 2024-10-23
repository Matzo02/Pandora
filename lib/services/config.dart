import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static Future<void> load() async {
    await dotenv.load(fileName: ".env");
  }

  static String get apiKey => dotenv.env['OPENAI_API_KEY'] ?? '';
}
