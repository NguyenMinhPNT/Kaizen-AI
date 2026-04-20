import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../domain/entities/habit_entity.dart';
import '../bloc/habit_list_bloc.dart';
import '../bloc/habit_list_state.dart';
import 'habit_card.dart';

class HabitListView extends StatefulWidget {
  const HabitListView({super.key});

  @override
  State<HabitListView> createState() => _HabitListViewState();
}

class _HabitListViewState extends State<HabitListView> {
  List<HabitEntity>? _orderedHabits;

  void _updateHabitsIfNeeded(List<HabitEntity> habits) {
    if (_orderedHabits == null) {
      _orderedHabits = habits;
      return;
    }

    final currentIds = _orderedHabits!.map((h) => h.id).toSet();
    final newIds = habits.map((h) => h.id).toSet();

    if (currentIds.length != newIds.length || !currentIds.containsAll(newIds)) {
      _orderedHabits = habits;
      return;
    }

    final orderedMap = {for (final habit in habits) habit.id: habit};
    _orderedHabits =
        _orderedHabits!.map((habit) => orderedMap[habit.id] ?? habit).toList();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (_orderedHabits == null) return;
      if (newIndex > oldIndex) newIndex -= 1;
      final habit = _orderedHabits!.removeAt(oldIndex);
      _orderedHabits!.insert(newIndex, habit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitListBloc, HabitListState>(
      builder: (context, state) {
        if (state is HabitListLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HabitListLoaded) {
          final habits = state.habits;
          if (habits.isEmpty) {
            _orderedHabits = null;
            return const EmptyStateWidget(
              title: 'No habits yet',
              subtitle:
                  'Tap + to create your first habit\nand start your Kaizen journey.',
              icon: Icons.eco_outlined,
            );
          }
          _updateHabitsIfNeeded(habits);
          return ReorderableListView.builder(
            padding: const EdgeInsets.symmetric(vertical: AppDimensions.sm),
            itemCount: _orderedHabits!.length,
            onReorder: _onReorder,
            buildDefaultDragHandles: false,
            itemBuilder: (context, index) {
              final habit = _orderedHabits![index];
              return ReorderableDelayedDragStartListener(
                key: ValueKey('reorder-${habit.id}'),
                index: index,
                child: HabitCard(habit: habit),
              );
            },
          );
        }
        if (state is HabitListError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
