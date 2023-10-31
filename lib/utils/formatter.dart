String formatStopwatch(Duration duration) {
  return '${_padLeftZeroes(duration.inMinutes.toString())}:${_padLeftZeroes((duration.inSeconds % 60).toString())}.${_padLeftZeroes((duration.inMilliseconds % 100).toString())}';
}

String _padLeftZeroes(String value) {
  return value.padLeft(2, '0');
}
