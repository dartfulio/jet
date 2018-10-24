# Jet

Jet leverages the powerful features of the Dart programming language and
fuses them with functional concepts to provide a lightweight fabric for building
fast and performant web applications.

## Example

Using the Jet application interface, you can get your web application up and
running in no time. Here's a simple example.

```dart
import 'dart:async';

import 'package:jet/jet.dart';

class Example implements Middleware {
  @override
  Future<Context> resolve(Context context, Resolver next) async => context
    .setResponse(Response.text('Hello, Jet!'));
}

Future main() async => listen(middleware: [
  Example()
]);
```

To run this example, simply paste the code into a file and let Dart evaluate
it. You should then be able to fire up your favorite browser and navigate to
`localhost:9000` to see the example application in action.
