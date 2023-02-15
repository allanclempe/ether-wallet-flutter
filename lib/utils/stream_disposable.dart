import 'dart:async';

class StreamDisposable {
  StreamSubscription<dynamic>? _resource;

  Future<void> dispose() async {
    if (_resource != null) {
      await _resource!.asFuture();
      await _resource!.cancel();

      _resource = null;
    }
  }

  Future<void> set(StreamSubscription<dynamic> Function() createStream) async {
    await dispose();
    _resource = createStream();
  }
}
