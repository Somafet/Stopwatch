import 'package:flutter/material.dart';
import 'package:stopwatch/models/lap.dart';
import 'package:stopwatch/utils/formatter.dart';

class LapListView extends StatelessWidget {
  const LapListView({
    super.key,
    required this.laps,
  });

  final List<Lap> laps;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: laps.length,
        itemBuilder: (BuildContext context, int index) {
          var entryNum = laps.length - index;
          var lap = laps[entryNum - 1];
          return Row(
              children: [Text('$entryNum. ${formatStopwatch(lap.time)}')]);
        });
  }
}
