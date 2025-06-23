import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/todo/todo_cubit.dart';
import '../controllers/todo/todo_state.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: BlocBuilder<TodoCubit, TodoState>(
            builder: (context, state) {
              final cubit = context.read<TodoCubit>();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search…',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onSubmitted: cubit.setSearch,
                      ),
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<bool?>(
                      value: state.filterDone,
                      items: const [
                        DropdownMenuItem(value: null, child: Text('All')),
                        DropdownMenuItem(value: false, child: Text('Active')),
                        DropdownMenuItem(value: true, child: Text('Done')),
                      ],
                      onChanged: cubit.setFilter,
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.sort),
                      onSelected: cubit.setOrdering,
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: '-created_at',
                          child: Text('Newest'),
                        ),
                        PopupMenuItem(
                          value: 'created_at',
                          child: Text('Oldest'),
                        ),
                        PopupMenuItem(value: 'title', child: Text('A‑Z')),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          final cubit = context.read<TodoCubit>();

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error.isNotEmpty) {
            return Center(child: Text(state.error));
          }
          if (state.todos.isEmpty) {
            return const Center(child: Text('No todos'));
          }
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) => cubit.toggleDone(index),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => cubit.delete(todo.id!),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          final cubit = context.read<TodoCubit>();
          return FloatingActionButton(
            onPressed: () async {
              final titleC = TextEditingController();
              final descC = TextEditingController();
              await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Add Todo'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleC,
                        decoration: const InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        controller: descC,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.add(titleC.text, descC.text);
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
