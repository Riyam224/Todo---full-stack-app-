import 'package:dartz/dartz.dart';
import 'package:todo_clean_arch/core/err/failure_abstract_class.dart';
import 'package:todo_clean_arch/core/usecases/base_usecase.dart';
import 'package:todo_clean_arch/features/todos/domain/entites/todo.dart';
import 'package:todo_clean_arch/features/todos/domain/repository/base_todo_repository.dart';

class AddTodo extends BaseUsecase<Todo, Todo> {
  final BaseTodoRepository repo;

  AddTodo(this.repo);

  @override
  Future<Either<Failure, Todo>> call(Todo t) {
    return repo.addTodo(t);
  }
}

class UpdateTodo extends BaseUsecase<Todo, Todo> {
  final BaseTodoRepository repo;

  UpdateTodo(this.repo);

  @override
  Future<Either<Failure, Todo>> call(Todo t) {
    return repo.updateTodo(t);
  }
}

class DeleteTodo extends BaseUsecase<void, int> {
  final BaseTodoRepository repo;

  DeleteTodo(this.repo);

  @override
  Future<Either<Failure, void>> call(int id) {
    return repo.deleteTodo(id);
  }
}
