import 'package:dartz/dartz.dart';
import 'package:todo_clean_arch/core/err/failure_abstract_class.dart';
import 'package:todo_clean_arch/core/usecases/base_usecase.dart';
import 'package:todo_clean_arch/features/todos/domain/entites/todo.dart';
import 'package:todo_clean_arch/features/todos/domain/repository/base_todo_repository.dart';

class GetTodos extends BaseUsecase<List<Todo>, GetTodosParams> {
  final BaseTodoRepository repo;

  GetTodos(this.repo);
  @override
  Future<Either<Failure, List<Todo>>> call(GetTodosParams p) {
    return repo.getTodos(
      search: p.search,
      isDone: p.isDone,
      ordering: p.ordering,
    );
  }
}

class GetTodosParams {
  final String? search;
  final bool? isDone;
  final String? ordering;
  const GetTodosParams({this.search, this.isDone, this.ordering});
}
