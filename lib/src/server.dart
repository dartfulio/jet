import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'context.dart';
import 'middleware.dart';

class BodyTypeError extends Error {
  final String message;

  BodyTypeError([this.message]);
}

class UnsupportedBodyTypeError extends BodyTypeError {
  UnsupportedBodyTypeError(Type type) : super(
    '$type is not a valid body type.'
  );
}

Future listen({List<Middleware> middleware = const [], int port = 9000}) async {
  final resolver = applyMiddleware(middleware, (context) async => context);
  final requests = await HttpServer.bind(InternetAddress.loopbackIPv4, port);

  await for (final request in requests) {
    final context = await resolver(Context.of(request));
    final response = context.response;

    request.response.statusCode = response.status;
    response.headers.forEach((name, value) => request.response.headers.set(
      name, value
    ));

    final body = response.body;

    if (body is Map || body is String) {
      final data = utf8.encode(body is Map ? json.encode(body) : body);
      final contentType = body is Map ? ContentType.json : ContentType.text;

      request.response.headers
        ..set(HttpHeaders.contentTypeHeader, contentType.toString())
        ..set(HttpHeaders.contentLengthHeader, data.length);

      request.response
        ..add(data)
        ..close();
    } else {
      throw UnsupportedBodyTypeError(body.runtimeType);
    }
  }
}
