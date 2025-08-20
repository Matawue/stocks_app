

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theFinnhubKey = dotenv.env['THE_FINNHUB_KEY'] ?? 'No hay API key';
}