import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/components/app_alert_box.dart';
import 'package:todo_bloc/components/app_text_field.dart';
import 'package:todo_bloc/data/todo.dart';
import 'package:todo_bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/todo_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // add todo
  void addTodo(Todo todo) {
    context.read<TodoBloc>().add(AddTodo(todo));
  }

  // remove todo
  void removeTodo(Todo todo) {
    context.read<TodoBloc>().add(RemoveTodo(todo));
  }

  // toggle todo
  void toggleTodo(int index) {
    context.read<TodoBloc>().add(ToggleTodo(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' My Todo App'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // show the  dialouge for it
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              final formKey = GlobalKey<FormState>();
              TextEditingController titleController = TextEditingController();
              TextEditingController descriptionController =
                  TextEditingController();
              return AppAlertDialog(
                title: 'Add your Task',
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        controller: titleController,
                        labelText: 'Title...',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      AppTextField(
                        controller: descriptionController,
                        labelText: 'Description...',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                onConfirm: () {
                  if (formKey.currentState?.validate() ?? false) {
                    addTodo(
                      Todo(
                        title: titleController.text,
                        subtitle: descriptionController.text,
                      ),
                    );
                    titleController.text = '';
                    descriptionController.text = '';
                    return true;
                  }
                  return false;
                },
              );
            },
          );
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.add)],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state.status == TodoStatus.success) {
              return const TodoListTile();
            } else if (state.status == TodoStatus.initial) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
