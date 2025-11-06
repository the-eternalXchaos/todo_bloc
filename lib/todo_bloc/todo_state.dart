part of 'todo_bloc.dart';

enum TodoState { initial, loading, loaded, error }

class TodoState extends Equatable {
  final List<Todo> todos;
  final TodoStatus status;
}
