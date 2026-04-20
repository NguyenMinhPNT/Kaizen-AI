import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/habit_form_bloc.dart';
import '../bloc/habit_form_event.dart';
import '../widgets/habit_form_body.dart';

class CreateHabitPage extends StatelessWidget {
  const CreateHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.instance<HabitFormBloc>()..add(const InitializeCreateForm()),
      child: const HabitFormBody(isEdit: false),
    );
  }
}
