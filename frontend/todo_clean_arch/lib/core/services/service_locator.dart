import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_clean_arch/features/todos/data/datasources/todo_remote_ds.dart';
import 'package:todo_clean_arch/features/todos/data/repository/todo_repository_impl.dart';
import 'package:todo_clean_arch/features/todos/domain/repository/base_todo_repository.dart';
import 'package:todo_clean_arch/features/todos/domain/usecases/add_update_delete.dart';

import 'package:todo_clean_arch/features/todos/domain/usecases/get_todo_usecase.dart';
import 'package:todo_clean_arch/features/todos/presentation/controllers/todo/todo_cubit.dart';

final sl = GetIt.instance;

void init() {
  // ───── External ───────────────────────────────────────────────
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000/api/')),
  );

  // ───── Data sources ───────────────────────────────────────────
  sl.registerLazySingleton<TodoRemoteDs>(
    () => TodoRemoteDs(sl()), // inject Dio
  );

  // ───── Repository ─────────────────────────────────────────────
  sl.registerLazySingleton<BaseTodoRepository>(
    () => TodoRepositoryImpl(sl()), // sl() = TodoRemoteDataSource
  );

  // ───── Use‑cases ──────────────────────────────────────────────
  sl.registerLazySingleton(() => GetTodos(sl())); // inject repository
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));

  // ───── Presentation layer (Cubit / Bloc) ─────────────────────
  sl.registerFactory(
    () => TodoCubit(sl(), sl(), sl(), sl()), // inject use‑cases
  );
}
