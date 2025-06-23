import 'package:dio/dio.dart';
import 'package:todo_clean_arch/features/todos/data/models/todo_model.dart';

class TodoRemoteDs {
  final Dio dio;

  TodoRemoteDs(this.dio);

  Future<List<TodoModel>> fetchTodos({
    String? search,
    bool? isDone,
    String? ordering,
  }) async {
    final res = await dio.get(
      'todos/',
      queryParameters: {
        if (search != null && search.isNotEmpty) 'search': search,
        if (isDone != null) 'is_done': isDone,
        if (ordering != null) 'ordering': ordering,
      },
    );
    return (res.data as List).map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<TodoModel> createTodo(TodoModel m) async =>
      TodoModel.fromJson((await dio.post('todos/', data: m.toJson())).data);

  Future<TodoModel> putTodo(TodoModel m) async => TodoModel.fromJson(
    (await dio.put('todos/${m.id}/', data: m.toJson())).data,
  );

  Future<void> removeTodo(int id) async => dio.delete('todos/$id/');
}
