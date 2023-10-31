import 'dart:async';

class CustomStopwatch {
  // Initialize an instance of Stopwatch
  final Stopwatch _stopwatch = Stopwatch();
  bool _isRunning = false;

  // Timer
  Timer? _timer;

  List<void Function(Duration duration)> _listeners = [];

  void start() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      _notifyListeners(_stopwatch.elapsed);
    });
    _stopwatch.start();
  }

  void stop() {
    _isRunning = false;
    if (_timer != null) {
      _timer!.cancel();
    }

    _stopwatch.stop();
  }

  void reset() {
    stop();
    _stopwatch.reset();

    _notifyListeners(const Duration());
  }

  bool get isRunning {
    return _isRunning;
  }

  Duration get currentTime {
    return _stopwatch.elapsed;
  }

  void _notifyListeners(Duration duration) {
    for (var listener in _listeners) {
      listener.call(duration);
    }
  }

  void addUpdateListener(void Function(Duration duration) listener) {
    _listeners.add(listener);
  }

  // Could add event listener remove but not in the scope

  void dispose() {
    stop();
    _listeners = [];
  }
}
