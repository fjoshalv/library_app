import 'package:library_core/src/data/request_name.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('getPath - ', () {
    test("No path parameters keeps path unchanged", () {
      final request = RequestName.request;

      final pathResult = request.getPath();

      expect(pathResult, 'request');
    });

    test("Request with no path parameters is kept unchanged", () {
      final request = RequestName.request;

      final pathResult = request.getPath(
        pathParameters: {
          "parameter": "value",
        },
      );

      expect(pathResult, 'request');
    });

    test("Request gets path with expected parameter", () {
      final request = RequestName.requestWithParam;
      final expectedParamValue = "123";

      final pathResult = request.getPath(
        pathParameters: {
          "id": "123",
        },
      );

      expect(pathResult, 'request/$expectedParamValue');
    });

    test("Request gets path with parameters placeholders "
        "when incorrect key is provided", () {
      final request = RequestName.requestWithParam;

      final pathResult = request.getPath(
        pathParameters: {
          "other": "123",
        },
      );

      expect(pathResult, 'request/{id}');
    });

    test("Request gets path with encoded parameters", () {
      final request = RequestName.requestWithParam;
      final expectedParamValue = "a%20b%2Fc";

      final pathResult = request.getPath(
        pathParameters: {
          "id": "a b/c",
        },
      );

      expect(pathResult, 'request/$expectedParamValue');
    });
  });
}
