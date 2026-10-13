import 'package:library_core/src/data/app_request.dart';

abstract interface class NetworkManager {
  Future<T> makeRequest<T>({required AppRequest<T> request});
}
