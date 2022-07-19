import 'dart:async';

/// This class defines the implementation of a class that emulates a function
/// that converts a data with a given type (S) into a data with another type (T).
abstract class TypeCaster<S, T> {
  T call(S element);
}

/// https://stackoverflow.com/q/53372895/132396
class GenericStreamTransformer<S, T> implements StreamTransformer<S, T> {
  late final StreamController<T> _controller;

  late StreamSubscription _subscription;

  final bool cancelOnError;

  // Original Stream
  late Stream<S> _stream;

  late TypeCaster<S, T> _caster;

  GenericStreamTransformer(TypeCaster<S, T> caster, {bool sync = false, this.cancelOnError = false}) {
    _controller = StreamController<T>(
        onListen: _onListen,
        onCancel: _onCancel,
        onPause: () {
          _subscription.pause();
        },
        onResume: () {
          _subscription.resume();
        },
        sync: sync);
    _caster = caster;
  }

  GenericStreamTransformer.broadcast(TypeCaster<S, T> caster, {bool sync = false, this.cancelOnError = false}) {
    _controller = StreamController<T>.broadcast(
      onListen: _onListen,
      onCancel: _onCancel,
      sync: sync,
    );
    _caster = caster;
  }

  void _onListen() {
    _subscription = _stream.listen(onData, onError: _controller.addError, onDone: _controller.close, cancelOnError: cancelOnError);
  }

  void _onCancel() {
    _subscription.cancel();
    //_subscription = null;
  }

  /// Transformation
  void onData(S data) {
    // print('in: ${data.runtimeType}');
    T transformedData = _caster(data);
    // print('out: ${transformedData.runtimeType}');
    _controller.add(transformedData);
  }

  /// Bind
  @override
  Stream<T> bind(Stream<S> stream) {
    _stream = stream;
    return _controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() => StreamTransformer.castFrom(this);
}

// Example
/// This class emulates a converter from integers to strings.
class Caster extends TypeCaster<int, String> {
  @override
  String call(int value) {
    return "<${value.toString()}>";
  }
}

main() {
  // ---------------------------------------------------------------------------
  // TEST: unicast controller.
  // ---------------------------------------------------------------------------

  // Create a controller that will be used to inject integers into the "input"
  // stream.
  StreamController<int> controllerUnicast = StreamController<int>();
  // Get the stream "to control".
  Stream<int> integerStreamUnicast = controllerUnicast.stream;
  // Apply a transformer on the "input" stream.
  // The method "transform" calls the method "bind", which returns the stream that
  // receives the transformed values.
  Stream<String> stringStreamUnicast = integerStreamUnicast.transform(GenericStreamTransformer<int, String>(Caster()));

  stringStreamUnicast.listen((data) {
    print('String => $data');
  });

  // Inject integers into the "input" stream.
  controllerUnicast.add(1);
  controllerUnicast.add(2);
  controllerUnicast.add(3);

  // ---------------------------------------------------------------------------
  // TEST: broadcast controller.
  // ---------------------------------------------------------------------------

  StreamController<int> controllerBroadcast = StreamController<int>.broadcast();
  Stream<int> integerStreamBroadcast = controllerBroadcast.stream;
  Stream<String> stringStreamBroadcast = integerStreamBroadcast.transform(GenericStreamTransformer<int, String>.broadcast(Caster()));

  stringStreamBroadcast.listen((data) {
    print('Listener 1: String => $data');
  });

  stringStreamBroadcast.listen((data) {
    print('Listener 2: String => $data');
  });

  controllerBroadcast.add(1);
  controllerBroadcast.add(2);
  controllerBroadcast.add(3);
}
