import 'dart:io';

import 'package:built_collection/built_collection.dart';

class Response {
  final int status;
  final Map<String, String> headers;
  final dynamic body;
  final Map<String, Object> properties;

  const Response(this.status, this.headers, this.body, this.properties);

  factory Response.empty(int status, dynamic body) => Response(
    status,
    BuiltMap<String, String>().toMap(),
    body,
    BuiltMap<String, Object>().toMap()
  );

  factory Response.text(String body, {int status = HttpStatus.ok}) => Response
    .empty(status, body);

  factory Response.json(Map body, {int status = HttpStatus.ok}) => Response
    .empty(status, body);

  Response copy({
    int status,
    Map<String, String> headers,
    dynamic body,
    Map<String, Object> properties
  }) => Response(
    status != null ? status : this.status,
    headers != null ? headers : this.headers,
    body != null ? body : this.body,
    properties != null ? properties : this.properties
  );
}
