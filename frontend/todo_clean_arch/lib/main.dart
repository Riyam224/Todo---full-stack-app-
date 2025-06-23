import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/core/services/service_locator.dart' as di;
import 'features/todos/presentation/controllers/todo/todo_cubit.dart';
import 'features/todos/presentation/screens/todo_screen.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<TodoCubit>(
        create: (_) => di.sl<TodoCubit>()..loadTodos(),
        child: const TodoScreen(),
      ),
    );
  }
}
