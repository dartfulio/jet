import 'dart:async';

import 'context.dart';

typedef Resolver = Future<Context> Function(Context);

abstract class Middleware {
  Future<Context> resolve(Context context, Resolver next);
}

Resolver applyMiddleware(List<Middleware> middleware, Resolver tail) =>
  middleware
    .reversed
    .fold(
      tail,
      (a, b) => (context) => b.resolve(context, a)
    );
