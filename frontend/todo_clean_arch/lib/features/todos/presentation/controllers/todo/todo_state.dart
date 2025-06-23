import 'package:equatable/equatable.dart';
import 'package:todo_clean_arch/features/todos/domain/entites/todo.dart';

class TodoState extends Equatable {
  final List<Todo> todos;
  final bool isLoading;
  final String error;
  final String searchQuery;
  final bool? filterDone;
  final String ordering;

  const TodoState({
    this.todos = const [],
    this.isLoading = false,
    this.error = '',
    this.searchQuery = '',
    this.filterDone,
    this.ordering = '-created_at',
  });

  TodoState copyWith({
    List<Todo>? todos,
    bool? isLoading,
    String? error,
    String? searchQuery,
    bool? filterDone,
    String? ordering,
  }) => TodoState(
    todos: todos ?? this.todos,
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error,
    searchQuery: searchQuery ?? this.searchQuery,
    filterDone: filterDone ?? this.filterDone,
    ordering: ordering ?? this.ordering,
  );

  @override
  List<Object?> get props => [
    todos,
    isLoading,
    error,
    searchQuery,
    filterDone,
    ordering,
  ];
}
