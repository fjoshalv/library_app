import 'package:dio/dio.dart';
import 'package:library_core/src/data/app_request.dart';
import 'package:library_core/src/data/dio_network_manager.dart';
import 'package:library_core/src/data/network_exception.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks.dart' show MockAdapter;

void main() {
  late MockAdapter adapter;
  late DioNetworkManager manager;

  final tAppRequest = AppRequest(
    requestName: .request,
    requestType: .get,
    responseFactory: (json) =>
        (json as Map<String, dynamic>)["title"] as String,
  );

  setUp(() {
    adapter = MockAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://api.example.com/'))
      ..httpClientAdapter = adapter;
    manager = DioNetworkManager(dio: dio, enableLogging: false);
  });

  setUpAll(() {
    registerFallbackValue(RequestOptions());
  });

  void stubAdapterResponse(String body, int statusCode) {
    when(() => adapter.fetch(any(), any(), any())).thenAnswer(
      (_) async => ResponseBody.fromString(
        body,
        statusCode,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      ),
    );
  }

  group("makeRequest - ", () {
    test(
      "Returns a valid response (status code 200) and its parsed correctly",
      () async {
        stubAdapterResponse('{"title": "book"}', 200);

        final response = await manager.makeRequest(request: tAppRequest);

        expect(response, "book");
      },
    );

    test('throws [HttpError] with status code 404', () async {
      stubAdapterResponse('{"error": "not found"}', 404);

      await expectLater(
        manager.makeRequest(request: tAppRequest),
        throwsA(
          isA<HttpError>().having((e) => e.statusCode, 'statusCode', 404),
        ),
      );
    });

    test(
      "Returns an invalid body (status code 200) that fails to parse",
      () async {
        stubAdapterResponse('{"title": "book', 200);

        await expectLater(
          manager.makeRequest(request: tAppRequest),
          throwsA(
            isA<DecodingError>().having(
              (e) => e.cause,
              'cause',
              isA<DioException>().having(
                (d) => d.error,
                'error',
                isA<FormatException>(),
              ),
            ),
          ),
        );
      },
    );

    test(
      "Returns an invalid field type (status code 200) and it fails to parse",
      () async {
        stubAdapterResponse('{"title": 200}', 200);

        await expectLater(
          manager.makeRequest(request: tAppRequest),
          throwsA(
            isA<DecodingError>().having(
              (e) => e.cause,
              'cause',
              isA<TypeError>(),
            ),
          ),
        );
      },
    );

    test(
      "Throws [NoConnection] error when offline",
      () async {
        when(() => adapter.fetch(any(), any(), any())).thenThrow(
          DioException.connectionError(
            requestOptions: RequestOptions(),
            reason: 'offline',
          ),
        );

        await expectLater(
          manager.makeRequest(request: tAppRequest),
          throwsA(isA<NoConnection>()),
        );
      },
    );
  });
}
