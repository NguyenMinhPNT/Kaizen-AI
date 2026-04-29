import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/neumorphism/neumorphic_theme.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/neumorphic_button.dart';
import '../../../../app/di/injection_container.dart';
import '../bloc/stats_bloc.dart';
import '../bloc/stats_event.dart';
import '../bloc/stats_state.dart';
import '../widgets/habit_selector_bar.dart';
import '../widgets/range_selector_widget.dart';
import '../widgets/heatmap_calendar.dart';
import '../widgets/heatmap_legend.dart';
import '../widgets/completion_bar_chart.dart';

/// Main statistics page: heatmap calendar + bar chart, per-habit, range-selectable.
class StatsPage extends StatelessWidget {
  const StatsPage({super.key, this.habitId});

  final String? habitId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<StatsBloc>()..add(StatsLoaded(initialHabitId: habitId)),
      child: _StatsView(showDrawer: habitId == null),
    );
  }
}

class _StatsView extends StatelessWidget {
  const _StatsView({required this.showDrawer});
  final bool showDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.neumorphicSurface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: showDrawer
            ? Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
                child: Builder(
                  builder: (ctx) => NeumorphicIconButton(
                    icon: Icons.menu,
                    iconColor: AppColors.primary,
                    backgroundColor: AppColors.surfaceElevated,
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                    size: 46,
                  ),
                ),
              )
            : null,
        title: Text(
          'Statistics',
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Angkor',
          ),
        ),
        centerTitle: true,
      ),
      drawer: showDrawer ? const AppDrawer() : null,
      body: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          if (state is StatsLoading || state is StatsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is StatsEmpty) {
            return const EmptyStateWidget(
              title: 'No habits yet',
              subtitle: 'Create a habit to see statistics.',
            );
          }

          if (state is StatsError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: AppTextStyles.bodyLarge,
              ),
            );
          }

          return const _StatsContent();
        },
      ),
    );
  }
}

class _StatsContent extends StatelessWidget {
  const _StatsContent();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimensions.md),

          // ── Habit selector
          const HabitSelectorBar(),
          const SizedBox(height: AppDimensions.sm),

          // ── Tab bar below habit selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
            child: TabBar(
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelStyle: AppTextStyles.titleMedium,
              tabs: const [
                Tab(text: 'Activity Heatmap'),
                Tab(text: 'Completion Rate'),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.lg),

          // ── Shared range selector
          const RangeSelectorWidget(),
          const SizedBox(height: AppDimensions.lg),

          Expanded(
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionCard(
                        child: BlocBuilder<StatsBloc, StatsState>(
                          builder: (context, state) {
                            if (state is! StatsDataLoaded) {
                              return const SizedBox.shrink();
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeatmapCalendar(data: state.heatmapData),
                                const SizedBox(height: AppDimensions.sm),
                                const HeatmapLegend(),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppDimensions.xl),
                    ],
                  ),
                ),
                const SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionCard(child: CompletionBarChart()),
                      SizedBox(height: AppDimensions.xl),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
      padding: const EdgeInsets.all(AppDimensions.md),
      decoration: context.neumorphicRaised.copyWith(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: child,
    );
  }
}
