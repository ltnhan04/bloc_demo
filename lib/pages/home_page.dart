import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/task_bloc.dart';
import 'package:todo_app_bloc/bloc/task_event.dart';
import 'package:todo_app_bloc/bloc/task_state.dart';
import 'package:todo_app_bloc/models/task.dart';
import 'package:todo_app_bloc/pages/add_edit_task_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks'), centerTitle: true),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskInitial || state is TaskLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TaskLoadSuccess) {
            final tasks = state.tasks;
            if (tasks.isEmpty) {
              return const Center(child: Text('No task yet. Add one!'));
            }
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskListItem(task: task);
              },
            );
          }
          if (state is TaskLoadFailure) {
            return const Center(child: Text('Failed to load task'));
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditTaskPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (bool? value) {
          context.read<TaskBloc>().add(
            UpdateTask(task.copyWith(isCompleted: !task.isCompleted)),
          );
        },
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          context.read<TaskBloc>().add(DeleteTask(task));
        },
        icon: const Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
