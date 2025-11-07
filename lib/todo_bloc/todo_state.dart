part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, loaded, success, error }

class TodoState extends Equatable {
  final List<Todo> todos;
  final TodoStatus status;

  const TodoState({
    this.todos = const <Todo>[],
    this.status = TodoStatus.initial,
  });

  TodoState copyWith({TodoStatus? status, List<Todo>? todos}) {
    return TodoState(todos: todos ?? this.todos, status: status ?? this.status);
  }

  factory TodoState.fromJson(Map<String, dynamic> json) {
    try {
      final todoList =
          (json['todos'] as List<dynamic>?)
              ?.map((e) => Todo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <Todo>[];

      final status = TodoStatus.values.firstWhere(
        (element) => element.name == (json['status'] as String?),
        orElse: () => TodoStatus.initial,
      );

      return TodoState(todos: todoList, status: status);
    } catch (_) {
      return const TodoState();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'todos': todos.map((t) => t.toJson()).toList(),
      'status': status.name,
    };
  }

  @override
  List<Object> get props => [todos, status];
}
