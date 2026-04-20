import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/widgets/neumorphic_button.dart';
import '../bloc/habit_list_bloc.dart';
import '../bloc/habit_list_event.dart';
import '../bloc/habit_list_state.dart';
import '../widgets/habit_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<HabitListBloc>()..add(const LoadHabits()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      drawer: const AppDrawer(),
      body: const HabitListView(),
      floatingActionButton: _AddHabitFab(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: Padding(
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
      ),
      title: Text(
        'KAIZEN AI',
        style: AppTextStyles.headlineMedium.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: 'Angkor',
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
          child: NeumorphicIconButton(
            icon: Icons.add,
            iconColor: AppColors.primary,
            backgroundColor: AppColors.surfaceElevated,
            onPressed: () => context.push(RoutePaths.habitCreate),
            size: 46,
          ),
        ),
      ],
    );
  }
}

class _AddHabitFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitListBloc, HabitListState>(
      builder: (context, state) {
        // Only show FAB when list is empty (as extra hint)
        if (state is HabitListLoaded && state.habits.isNotEmpty) {
          return const SizedBox.shrink();
        }
        return NeumorphicIconButton(
          icon: Icons.add,
          iconColor: AppColors.onPrimary,
          backgroundColor: AppColors.primary,
          onPressed: () => context.push(RoutePaths.habitCreate),
          size: 56,
        );
      },
    );
  }
}
