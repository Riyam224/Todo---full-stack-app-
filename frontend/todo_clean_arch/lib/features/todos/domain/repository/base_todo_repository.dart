import 'package:dartz/dartz.dart';
import 'package:todo_clean_arch/core/err/failure_abstract_class.dart';
import 'package:todo_clean_arch/features/todos/domain/entites/todo.dart';

abstract class BaseTodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos({
    String? search,
    bool? isDone,
    String? ordering,
  });

  Future<Either<Failure, Todo>> addTodo(Todo todo);
  Future<Either<Failure, Todo>> updateTodo(Todo todo);
  Future<Either<Failure, void>> deleteTodo(int id);
}
