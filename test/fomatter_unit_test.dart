import 'package:stopwatch/app/stopwatch/custom_stopwatch.dart';
import 'package:test/test.dart';

void main() {
  late CustomStopwatch stopwatch;

  setUpAll(() =>
  {
    stopwatch = CustomStopwatch()
  });

  test('Correctly signals running state', () {
    stopwatch.start();

    expect(stopwatch.isRunning, true);
  });

  test('Correctly signals stop state', () {
    stopwatch.start();

    stopwatch.stop();

    expect(stopwatch.isRunning, false);
  });

  test('Correctly notifies listeners', () async {
    callback(duration) {
      // expect(1, 0); // used this to verify it actually throws an error
      expect(duration, greaterThan(const Duration()));
    }
    stopwatch.start();
    stopwatch.addUpdateListener(callback);

    await Future.delayed(const Duration(seconds: 1));
  });

  test('Correctly increases time', () async {
    stopwatch.start();
    await Future.delayed(const Duration(milliseconds: 30));
    expect(stopwatch.isRunning, true);
    expect(stopwatch.currentTime, greaterThan(const Duration()));
  });

  test('Correctly pauses time', () async {
    stopwatch.start();
    await Future.delayed(const Duration(milliseconds: 30));
    expect(stopwatch.isRunning, true);
    expect(stopwatch.currentTime, greaterThan(const Duration()));

    stopwatch.stop();
    var stoppedAt = stopwatch.currentTime;

    // wait again
    await Future.delayed(const Duration(milliseconds: 30));

    expect(stopwatch.currentTime, stoppedAt);
  });

  test('Correctly resets time', () async {
    stopwatch.start();
    await Future.delayed(const Duration(milliseconds: 30));
    expect(stopwatch.isRunning, true);
    expect(stopwatch.currentTime, greaterThan(const Duration()));

    stopwatch.reset();

    // wait again
    await Future.delayed(const Duration(milliseconds: 30));

    expect(stopwatch.currentTime, const Duration());
  });

  tearDownAll(() =>
  {
    stopwatch.dispose()
  });
}