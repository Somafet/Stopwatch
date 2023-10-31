// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stopwatch/main.dart';
import 'package:stopwatch/utils/formatter.dart';

void main() {
  StopwatchApp app = const StopwatchApp();
  var defaultString = formatStopwatch(const Duration());

  group('Stopwatch UI tests', ()
  {
    loadAppHomeScreen(WidgetTester tester) async {
      await tester.pumpWidget(app);
    }

    Future<void> verifyStopwatchCanBeStarted(WidgetTester tester) async {
      if (kDebugMode) {
        print("_verifyStopwatchCanBeStarted");
      }
      // Verify that our stopwatch starts at 0.
      expect(find.text(defaultString), findsOneWidget);

      var startButton = find.byIcon(Icons.play_arrow);

      expect(startButton, findsOneWidget);

      // Tap the 'play' icon and trigger a frame.
      await tester.tap(startButton);
      // the timer refreshes every 30 milliseconds
      await tester.pump(const Duration(milliseconds: 30));

      expect(find.text(defaultString), findsNothing);
    }

    Future<void> verifyStopwatchCanBePaused(WidgetTester tester) async {
      if (kDebugMode) {
        print("_verifyStopwatchCanBePaused");
      }
      // Verify that our stopwatch starts at 0.
      expect(find.text(defaultString), findsOneWidget);

      var startButton = find.byIcon(Icons.play_arrow);

      expect(startButton, findsOneWidget);

      // Tap the 'play' icon and trigger a frame.
      await tester.tap(startButton);
      await tester.pump(const Duration(milliseconds: 60));

      // Verify that our counter has incremented.
      expect(find.text(defaultString), findsNothing);

      await tester.tap(find.byIcon(Icons.refresh_sharp));
      await tester.pump();

      expect(find.text(defaultString), findsOneWidget);
    }


    testWidgets('Stopwatch can be reset', (WidgetTester tester) async {
      await loadAppHomeScreen(tester);

      // await verifyStopwatchCanBeStarted(tester);
      await verifyStopwatchCanBePaused(tester);
    });
  });
}
