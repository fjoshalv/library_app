---
paths:
  - "packages/library_core/**"
---

# Pure Dart

`library_core` is pure Dart. Never import `package:flutter` (or anything that depends on it). Tests use `dart test`, not `flutter test`.

# Network layer (`lib/src/data/`)

- `NetworkManager` is the interface. `DioNetworkManager` is its Dio implementation.
- An `AppRequest<Res>` describes a call: a `RequestName`, an `HTTPRequestType`, optional query/path params, and a `responseFactory` that turns the decoded JSON into `Res`.
- `RequestName` is an enum of endpoints. `getPath` fills `{param}` placeholders from `pathParams`, URI-encoding them.
- All failures come out as the sealed `NetworkException` (`NoConnection`, `HttpError`, `DecodingError`, `CancelledRequest`, `UnknownNetworkError`). That includes `responseFactory` throwing, which becomes `DecodingError`. Stack traces are kept with `Error.throwWithStackTrace`.

# Tests

Tests mirror `lib/src/` (e.g. `test/src/data/dio_network_manager_test.dart`) and use `mocktail`. Shared mocks live in `test/mocks.dart`. Network tests swap Dio's `httpClientAdapter` for a `MockAdapter` rather than mocking `Dio` itself.
