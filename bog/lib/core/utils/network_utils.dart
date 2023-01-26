
import 'dart:io';

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return Future<bool>.value(true);
    }
  } on SocketException catch (_) {
    print('not connected');
    return Future<bool>.value(false);
  }

  return Future<bool>.value(false);
}