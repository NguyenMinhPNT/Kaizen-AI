import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/habit_form_bloc.dart';
import '../bloc/habit_form_event.dart';
import '../widgets/habit_form_body.dart';

class EditHabitPage extends StatelessWidget {
  const EditHabitPage({super.key, required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<HabitFormBloc>()..add(LoadForEdit(habitId)),
      child: HabitFormBody(isEdit: true, habitId: habitId),
    );
  }
}
