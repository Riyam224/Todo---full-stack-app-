import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/core/err/failure_abstract_class.dart';
import 'package:todo_clean_arch/features/todos/domain/entites/todo.dart';
import 'package:todo_clean_arch/features/todos/domain/usecases/add_update_delete.dart';
import 'package:todo_clean_arch/features/todos/domain/usecases/get_todo_usecase.dart';

import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTodos _getTodos;
  final AddTodo _addTodo;
  final UpdateTodo _updateTodo;
  final DeleteTodo _deleteTodo;

  TodoCubit(this._getTodos, this._addTodo, this._updateTodo, this._deleteTodo)
    : super(const TodoState());

  Future<void> loadTodos() async {
    emit(state.copyWith(isLoading: true, error: ''));
    final result = await _getTodos(
      GetTodosParams(
        search: state.searchQuery,
        isDone: state.filterDone,
        ordering: state.ordering,
      ),
    );
    result.fold(
      (Failure f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (todos) => emit(state.copyWith(todos: todos, isLoading: false)),
    );
  }

  Future<void> add(String title, String description) async {
    final t = Todo(
      id: null,
      title: title,
      description: description,
      isDone: false,
    );
    final result = await _addTodo(t);
    result.fold(
      (Failure f) => emit(state.copyWith(error: f.message)),
      (newTodo) => emit(state.copyWith(todos: [...state.todos, newTodo])),
    );
  }

  Future<void> toggleDone(int index) async {
    final old = state.todos[index];
    final upd = old.copyWith(isDone: !old.isDone);
    final res = await _updateTodo(upd);
    res.fold((Failure f) => emit(state.copyWith(error: f.message)), (t) {
      final list = [...state.todos]..[index] = t;
      emit(state.copyWith(todos: list));
    });
  }

  Future<void> delete(int id) async {
    final res = await _deleteTodo(id);
    res.fold(
      (Failure f) => emit(state.copyWith(error: f.message)),
      (_) => emit(
        state.copyWith(todos: state.todos.where((t) => t.id != id).toList()),
      ),
    );
  }

  // Query setters
  void setSearch(String q) {
    emit(state.copyWith(searchQuery: q));
    loadTodos();
  }

  void setFilter(bool? d) {
    emit(state.copyWith(filterDone: d));
    loadTodos();
  }

  void setOrdering(String o) {
    emit(state.copyWith(ordering: o));
    loadTodos();
  }
}
