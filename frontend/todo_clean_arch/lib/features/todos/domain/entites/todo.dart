import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int? id;
  final String title;
  final String description;
  final bool isDone;

  const Todo({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  Todo copyWith({int? id, String? title, String? description, bool? isDone}) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isDone: isDone ?? this.isDone,
      );

  @override
  List<Object?> get props => [id, title, description, isDone];
}
