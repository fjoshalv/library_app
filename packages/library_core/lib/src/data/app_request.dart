import 'package:library_core/src/data/request_name.dart';

typedef JsonResponseConverter<T> = T Function(dynamic json);

final class const AppRequest<Res>({
  required this.requestName,
  required this.requestType,
  required this.responseFactory,

  this.queryParams,
  this.pathParams,
}) {
  final RequestName requestName;
  final HTTPRequestType requestType;
  final Map<String, String>? queryParams;
  final Map<String, String>? pathParams;
  final JsonResponseConverter<Res> responseFactory;
}
