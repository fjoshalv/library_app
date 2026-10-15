enum RequestName {
  request,
  requestWithParam;

  String getPath({Map<String, String>? pathParameters}) {
    String path = '';
    switch (this) {
      case request:
        path = 'request';
      case requestWithParam:
        path = 'request/{id}';
    }

    if (pathParameters != null) {
      for (final entry in pathParameters.entries) {
        if (path.contains('{${entry.key}}')) {
          path = path.replaceFirst(
            "{${entry.key}}",
            Uri.encodeComponent(entry.value),
          );
        }
      }
    }

    return path;
  }
}

enum HTTPRequestType { get }
