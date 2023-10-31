import 'package:stopwatch/utils/formatter.dart';
import 'package:test/test.dart';

void main() {
  group("formatStopwatch should format correctly", () {
    var expectedOutputs = {
      const Duration(seconds: 2, milliseconds: 3): "00:02.03",
      const Duration(seconds: 17, milliseconds: 48): "00:17.48",
      const Duration(minutes: 2, milliseconds: 38): "02:00.38",
      const Duration(minutes: 100, milliseconds: 38): "100:00.38",
      const Duration(hours: 100, milliseconds: 38): "6000:00.38",
    };

    expectedOutputs.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(formatStopwatch(input), expected);
      });
    });
  });
}