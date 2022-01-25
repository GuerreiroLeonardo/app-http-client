<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.


## Usage Example
Imagine we want to make a request for our tea machine, telling it to make a coffe, which would not be possible, simulating  bad request.
First define a Tea Service:

```dart
import 'package:dio/dio.dart';

class TeaService {
  TeaService({required this.client});

  final AppHttpClient client;

  Future<Map<String, dynamic>?> brewTea() async {
    final response = await client.post<Map<String, dynamic>>(
      '/tea',
      data: {
        'brew': 'coffee',
      },
    );
    return response.data;
  }
}
```
For handling errors on this api call, we first create our custom exception, say **TeapotResponseException**, which simply takes a message and shows it as a detail on the stdout:

```dart
class TeapotResponseException extends AppNetworkResponseException {
  TeapotResponseException({
    required String message,
  }) : super(exception: Exception(message));
}
```

After that we create our custom **AppHttpClient** instance, wrapping a Dio's instance and treating the error locally:

```dart
final client = AppHttpClient(
  client: Dio(),
  exceptionMapper: <T>(Response<T> response) {
    final data = response.data;
    if (data != null && data is Map<String, dynamic>) {
      // We only map responses containing 
      // data with a status code of 418:
      return TeapotResponseException(
        message: data['message'] ?? 'I\'m a teapot',
      );
    }
    return null;
  },
);
```

Then, we make the api call passing the client instance to our service and catching our custom **TeapotResponseException**:

```dart
final teaService = TeaService(client: client);

try {
  await teaService.brewTea();
} on TeapotResponseException catch (teapot) {
  print(teapot.exception.toString()); 
} catch (e) {
  print('Some other error');
}
```
