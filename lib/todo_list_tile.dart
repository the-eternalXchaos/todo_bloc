import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_bloc/components/app_alert_box.dart';
import 'package:todo_bloc/data/todo.dart';
import 'package:todo_bloc/todo_bloc/todo_bloc.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({super.key});

  @override
  Widget build(BuildContext context) {
    // remove todo
    void removeTodo(Todo todo) {
      context.read<TodoBloc>().add(RemoveTodo(todo));
    }

    // toggle todo
    void toggleTodo(int index) {
      context.read<TodoBloc>().add(ToggleTodo(index));
    }

    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (context, index) {
            final todo = state.todos[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Slidable(
                key: ValueKey('${todo.title}-$index'),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) {
                        showDialog<void>(
                          context: context,
                          builder: (_) => AppAlertDialog(
                            title: 'Delete Task',
                            content: const Text(
                              'Are you sure you want to delete this task?',
                            ),
                            onConfirm: () {
                              removeTodo(todo);
                              return true;
                            },
                          ),
                        );
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(todo.subtitle),
                  onTap: () => context.read<TodoBloc>().add(ToggleTodo(index)),
                  trailing: Checkbox(
                    value: todo.isDone,
                    onChanged: (_) => toggleTodo(index),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
