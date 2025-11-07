import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_bloc/app_theme.dart';
import 'package:todo_bloc/home_page.dart';
import 'package:todo_bloc/todo_bloc/todo_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final appDir = await getApplicationDocumentsDirectory();
    final storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(appDir.path),
    );

    // Set Hydrated storage and start the app. Assigning to
    // [HydratedBloc.storage] is fine as long as it's done before blocs are
    // created. (Older/newer hydrated_bloc APIs may offer runZoned helpers.)
    HydratedBloc.storage = storage;
    runApp(const MyApp());
  } catch (e) {
    // If storage initialization fails for any reason, fall back to running
    // the app without hydration so the app still starts.
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      home: BlocProvider<TodoBloc>(
        create: (context) => TodoBloc()..add(TodoStarted()),
        child: const HomePage(),
      ),

      // home:
      theme: appTheme(),
    );
  }
}
