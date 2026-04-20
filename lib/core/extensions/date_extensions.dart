extension DateExtensions on DateTime {
  /// Returns a DateTime with time set to midnight (00:00:00.000).
  DateTime toDateOnly() => DateTime(year, month, day);

  /// Returns true if this date falls on the same calendar day as [other].
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Returns true if this date is yesterday relative to [other].
  bool isYesterdayOf(DateTime other) {
    final yesterday = other.subtract(const Duration(days: 1));
    return isSameDay(yesterday);
  }

  /// Returns a compact date string like "2024-01-15".
  String toIsoDateString() => '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  /// Returns the start of the day (midnight UTC) as a DateTime.
  DateTime toMidnightUtc() => DateTime.utc(year, month, day);
}
