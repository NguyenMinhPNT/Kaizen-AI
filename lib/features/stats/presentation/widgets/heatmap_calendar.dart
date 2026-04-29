import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/day_stat.dart';
import '../../../habit/domain/enums/habit_status.dart';

/// CustomPainter heatmap calendar.
///
/// Layout: columns = weeks (left → right = older → newer),
///         rows = 7 (top = Monday, bottom = Sunday).
/// Each cell shows the day number. Auto-scrolls to today on load.
class HeatmapCalendar extends StatefulWidget {
  const HeatmapCalendar({super.key, required this.data});

  /// Ordered list of [DayStat] spanning the selected range (daily resolution).
  final List<DayStat> data;

  @override
  State<HeatmapCalendar> createState() => _HeatmapCalendarState();
}

class _HeatmapCalendarState extends State<HeatmapCalendar> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToToday());
  }

  @override
  void didUpdateWidget(HeatmapCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToToday());
    }
  }

  void _scrollToToday() {
    if (!_scrollController.hasClients || widget.data.isEmpty) return;
    final firstDay = widget.data.first.date;
    final gridStart = firstDay.subtract(Duration(days: firstDay.weekday - 1));
    final now = DateTime.now();
    final todayNorm = DateTime(now.year, now.month, now.day);
    if (todayNorm.isBefore(gridStart)) return;

    const cellSize = AppDimensions.heatmapCellSize * 2;
    const gap = AppDimensions.heatmapCellGap;
    final daysDiff = todayNorm.difference(gridStart).inDays;
    final todayCol = (daysDiff / 7).floor();

    final scrollTo =
        (todayCol * (cellSize + gap) - 20.0)
            .clamp(0.0, _scrollController.position.maxScrollExtent);
    _scrollController.animateTo(
      scrollTo,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) return const SizedBox.shrink();

    final firstDay = widget.data.first.date;
    final gridStart = firstDay.subtract(Duration(days: firstDay.weekday - 1));

    final lastDay = widget.data.last.date;
    final gridEnd = lastDay.add(Duration(days: 7 - lastDay.weekday));
    final totalDays = gridEnd.difference(gridStart).inDays + 1;
    final totalCols = (totalDays / 7).ceil();

    const cellSize = AppDimensions.heatmapCellSize * 2;
    const gap = AppDimensions.heatmapCellGap;
    const monthLabelHeight = 18.0;

    final totalWidth = totalCols * (cellSize + gap);
    const totalHeight = monthLabelHeight + 7 * (cellSize + gap);

    final dataMap = <String, DayStat>{};
    for (final d in widget.data) {
      dataMap[_key(d.date)] = d;
    }

    final now = DateTime.now();
    final todayKey = _key(DateTime(now.year, now.month, now.day));

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size(totalWidth, totalHeight),
          painter: _HeatmapPainter(
            gridStart: gridStart,
            totalCols: totalCols,
            dataMap: dataMap,
            cellSize: cellSize,
            gap: gap,
            monthLabelHeight: monthLabelHeight,
            todayKey: todayKey,
          ),
        ),
      ),
    );
  }

  static String _key(DateTime d) => '${d.year}-${d.month}-${d.day}';
}

class _HeatmapPainter extends CustomPainter {
  _HeatmapPainter({
    required this.gridStart,
    required this.totalCols,
    required this.dataMap,
    required this.cellSize,
    required this.gap,
    required this.monthLabelHeight,
    required this.todayKey,
  });

  final DateTime gridStart;
  final int totalCols;
  final Map<String, DayStat> dataMap;
  final double cellSize;
  final double gap;
  final double monthLabelHeight;
  final String todayKey;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    String? lastMonthLabel;

    for (int col = 0; col < totalCols; col++) {
      final colDate = gridStart.add(Duration(days: col * 7));

      final monthLabel = _monthLabel(colDate);
      if (monthLabel != lastMonthLabel) {
        lastMonthLabel = monthLabel;
        _drawText(
          canvas,
          monthLabel,
          Offset(col * (cellSize + gap), 0),
          const TextStyle(
            color: AppColors.textHint,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        );
      }

      for (int row = 0; row < 7; row++) {
        final date = gridStart.add(Duration(days: col * 7 + row));
        final key = '${date.year}-${date.month}-${date.day}';
        final stat = dataMap[key];

        final color = _colorFor(stat);
        paint.color = color;

        final cx = col * (cellSize + gap) + cellSize / 2;
        final cy = monthLabelHeight + row * (cellSize + gap) + cellSize / 2;
        final center = Offset(cx, cy);

        canvas.drawCircle(center, cellSize / 2, paint);

        if (key == todayKey) {
          final borderPaint = Paint()
            ..style = PaintingStyle.stroke
            ..color = AppColors.primary
            ..strokeWidth = 2.5;
          canvas.drawCircle(center, cellSize / 2, borderPaint);
        }

        final isDark =
            stat == null ||
            !stat.hasLog ||
            stat.status == HabitStatus.skipped;
        _drawTextCentered(
          canvas,
          '${date.day}',
          center,
          TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: cellSize * 0.38,
            fontWeight: FontWeight.w600,
          ),
        );
      }
    }
  }

  static Color _colorFor(DayStat? stat) {
    if (stat == null || !stat.hasLog) return AppColors.missed;
    switch (stat.status!) {
      case HabitStatus.skipped:
        return AppColors.missed;
      case HabitStatus.gaveUp:
        return AppColors.warning;
      case HabitStatus.completed:
        final mins = stat.durationMinutes;
        if (mins <= 20) return AppColors.heatLevel1;
        if (mins <= 30) return AppColors.heatLevel2;
        if (mins <= 45) return AppColors.heatLevel3;
        if (mins <= 60) return AppColors.heatLevel4;
        if (mins <= 90) return AppColors.heatLevel5;
        return AppColors.heatLevel6;
    }
  }

  static String _monthLabel(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[d.month - 1];
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset,
    TextStyle style,
  ) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, offset);
  }

  void _drawTextCentered(
    Canvas canvas,
    String text,
    Offset center,
    TextStyle style,
  ) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_HeatmapPainter old) =>
      old.gridStart != gridStart ||
      old.totalCols != totalCols ||
      old.dataMap != dataMap ||
      old.todayKey != todayKey;
}
