import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/task_bloc.dart';
import 'package:todo_app_bloc/bloc/task_event.dart';
import 'package:todo_app_bloc/models/task.dart';

class AddEditTaskPage extends StatefulWidget {
  final Task? task;
  const AddEditTaskPage({super.key, this.task});

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final _textController = TextEditingController();

  @override
  void initState() {
    if (widget.task != null) {
      _textController.text = widget.task!.title;
    }
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                final newTask = Task(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: _textController.text,
                );
                context.read<TaskBloc>().add(AddTask(newTask));
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
