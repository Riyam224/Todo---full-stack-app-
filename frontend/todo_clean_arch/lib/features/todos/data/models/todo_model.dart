import 'package:json_annotation/json_annotation.dart';
import 'package:todo_clean_arch/features/todos/domain/entites/todo.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  final int? id;
  final String title;
  final String description;
  @JsonKey(name: 'is_done')
  final bool isDone;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  Todo toEntity() =>
      Todo(id: id, title: title, description: description, isDone: isDone);

  factory TodoModel.fromEntity(Todo e) => TodoModel(
    id: e.id,
    title: e.title,
    description: e.description,
    isDone: e.isDone,
  );
}
