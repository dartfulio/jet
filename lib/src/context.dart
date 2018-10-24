import 'dart:io';

import 'request.dart';
import 'response.dart';

class Context {
  final Request request;
  final Response response;

  const Context(this.request, this.response);

  factory Context.of(HttpRequest request) {
    final uri = request.uri;

    return Context(Request.of(request), Response.text(
      'Could not find resource $uri.', status: HttpStatus.notFound
    ));
  }

  Context copy({Request request, Response response}) => Context(
    request != null ? request : this.request,
    response != null ? response : this.response
  );

  Context setRequest(Request request) => copy(request: request);

  Context setResponse(Response response) => copy(response: response);
}
