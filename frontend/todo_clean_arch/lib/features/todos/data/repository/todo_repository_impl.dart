import 'package:dartz/dartz.dart';
import 'package:todo_clean_arch/core/err/failure_abstract_class.dart';
import 'package:todo_clean_arch/features/todos/domain/entites/todo.dart';
import 'package:todo_clean_arch/features/todos/domain/repository/base_todo_repository.dart';

import '../datasources/todo_remote_ds.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements BaseTodoRepository {
  final TodoRemoteDs remote;
  TodoRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<Todo>>> getTodos({
    String? search,
    bool? isDone,
    String? ordering,
  }) async {
    try {
      final list = await remote.fetchTodos(
        search: search,
        isDone: isDone,
        ordering: ordering,
      );
      return Right(list.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(
        ServerFailure(e.toString(), message: 'Failed to fetch todos'),
      );
    }
  }

  @override
  Future<Either<Failure, Todo>> addTodo(Todo t) async {
    try {
      final added = await remote
          .createTodo(TodoModel.fromEntity(t))
          .then((m) => m.toEntity());
      return Right(added);
    } catch (e) {
      return Left(ServerFailure(e.toString(), message: 'Failed to add todo'));
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo t) async {
    try {
      final upd = await remote
          .putTodo(TodoModel.fromEntity(t))
          .then((m) => m.toEntity());
      return Right(upd);
    } catch (e) {
      return Left(
        ServerFailure(e.toString(), message: 'Failed to update todo'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try {
      await remote.removeTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure(e.toString(), message: 'Failed to delete todo'),
      );
    }
  }
}
