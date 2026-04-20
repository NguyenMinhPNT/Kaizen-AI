import 'dart:ui';

extension ColorExtensions on Color {
  /// Returns a hex string like "#4CAF50" (no alpha).
  String toHex() {
    final r = ((this.r * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0');
    final g = ((this.g * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0');
    final b = ((this.b * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0');
    return '#${r.toUpperCase()}${g.toUpperCase()}${b.toUpperCase()}';
  }

  /// Creates a Color from a hex string like "#4CAF50" or "4CAF50".
  static Color fromHex(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    final value = int.parse(
      cleaned.length == 6 ? 'FF$cleaned' : cleaned,
      radix: 16,
    );
    return Color(value);
  }
}
