extension DurationExtensions on Duration {
  /// Formats the duration as "MM:SS".
  String formatMMSS() {
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Formats the duration as "HH:MM:SS" (only when hours > 0).
  String formatHHMMSS() {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    if (inHours > 0) return '$hours:$minutes:$seconds';
    return '$minutes:$seconds';
  }
}

extension IntDurationExtensions on int {
  /// Converts an int (seconds) to a MM:SS string.
  String toMMSS() {
    final duration = Duration(seconds: this);
    return duration.formatMMSS();
  }

  /// Converts minutes to a human-readable string like "10 min".
  String toMinLabel() => '$this min';
}
