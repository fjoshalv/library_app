import 'package:library_core/library_core.dart';

Environment configureEnvironment() {
  const apiKey = String.fromEnvironment(Environment.apiKeyEnvKey);
  const baseUrl = String.fromEnvironment(Environment.baseUrlEnvKey);

  if (apiKey.isEmpty || baseUrl.isEmpty) {
    throw StateError("ENV data not complete.");
  }

  return Environment(apiKey: apiKey, baseUrl: baseUrl);
}
