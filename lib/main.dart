import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stopwatch/models/lap.dart';
import 'package:stopwatch/utils/formatter.dart';

import 'package:stopwatch/app/stopwatch/custom_stopwatch.dart';
import 'package:stopwatch/widgets/stopwatch/lap_list.dart';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch.exe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        textTheme: GoogleFonts.openSansTextTheme(const TextTheme(
            displayLarge: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ))),
        useMaterial3: true,
      ),
      home: const StopwatchPage(title: 'STOPWATCH.exe'),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  // Initialize an instance of Stopwatch
  final CustomStopwatch _stopwatch = CustomStopwatch();
  final List<Lap> laps = [];

  String _stopwatchText = formatStopwatch(const Duration(milliseconds: 0));

  _StopwatchPageState() {
    _stopwatch.addUpdateListener((duration) {
      setState(() {
        _stopwatchText = formatStopwatch(duration);
      });
    });
  }

  void _start() {
    _stopwatch.start();
  }

  // This function will be called when the user presses the Stop button
  void _stop() {
    _stopwatch.stop();
  }

  // This function will be called when the user presses the Reset button
  void _reset() {
    _stopwatch.reset();
    _clearLaps();

    // Update the UI
    setState(() {
      _stopwatchText = formatStopwatch(const Duration(milliseconds: 0));
    });
  }

  void _toggleStopwatchRun() {
    if (_stopwatch.isRunning) {
      _stop();
      return;
    }

    _start();
  }

  void _addLap() {
    if (!_stopwatch.isRunning) {
      return;
    }

    setState(() {
      laps.add(Lap(_stopwatch.currentTime));
    });
  }

  void _clearLaps() {
    laps.clear();
  }

  @override
  void dispose() {
    _stopwatch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Stack(children: [
      SvgPicture.asset(
        'assets/images/background.svg',
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    letterSpacing: 2.5, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                const SizedBox(height: 150),
                Text(_stopwatchText,
                    key: const Key("stopwatch_text"),
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(letterSpacing: 4)),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Start button
                    ElevatedButton(
                        onPressed: _toggleStopwatchRun,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 60),
                        ),
                        child: Icon(
                          !_stopwatch.isRunning
                              ? Icons.play_arrow
                              : Icons.pause,
                          size: 34.0,
                          semanticLabel: !_stopwatch.isRunning
                              ? "Start stopwatch"
                              : "Pause stopwatch",
                        )),
                    // Reset button
                    ElevatedButton(
                      onPressed: _reset,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 60),
                      ),
                      child: const Icon(Icons.refresh_sharp,
                          size: 34.0, semanticLabel: "Reset stopwatch"),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _addLap,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 60),
                    ),
                    child: const Row(
                      children: [Icon(Icons.add), Text("Lap")],
                    ),
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton(
                    onPressed: _clearLaps,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 60),
                    ),
                    child: const Row(
                      children: [Text("Reset laps")],
                    ),
                  ),
                  const Spacer()
                ]),
                SizedBox(height: 150, child: LapListView(laps: laps))
              ],
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    ]);
  }
}
