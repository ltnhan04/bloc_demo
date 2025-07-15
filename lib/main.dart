import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/task_bloc.dart';
import 'package:todo_app_bloc/bloc/task_event.dart';
import 'package:todo_app_bloc/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc()..add(LoadTasks()),
      child: MaterialApp(
        title: 'Todo App with Bloc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
