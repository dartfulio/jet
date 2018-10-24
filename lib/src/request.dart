import 'dart:io';

import 'package:built_collection/built_collection.dart';

class Request {
  final String method;
  final Uri uri;
  final Map<String, List<String>> headers;
  final dynamic body;
  final Map<String, Object> properties;

  const Request(
    this.method, this.uri, this.headers, this.body, this.properties
  );

  factory Request.of(HttpRequest request) {
    final builder = MapBuilder<String, List<String>>();

    request.headers.forEach((name, value) => builder[name] = value);

    final method = request.method;
    final uri = request.uri;
    final headers = builder.build().toMap();
    final properties = BuiltMap<String, Object>().toMap();

    return Request(method, uri, headers, request, properties);
  }
}
