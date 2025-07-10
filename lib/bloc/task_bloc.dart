import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/task_event.dart';
import 'package:todo_app_bloc/bloc/task_state.dart';
import 'package:todo_app_bloc/models/task.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }
  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) {
    final tasks = [
      Task(id: '1', title: 'Học Flutter BLoC'),
      Task(id: '2', title: 'Làm dự án Todo List', isCompleted: true),
      Task(id: '3', title: 'Đi ngủ'),
    ];
    emit(TaskLoadSuccess(tasks));
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    if (state is TaskLoadSuccess) {
      final List<Task> updatedTasks = List.from(state.tasks)..add(event.task);
      emit(TaskLoadSuccess(updatedTasks));
    }
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    if (state is TaskLoadSuccess) {
      final List<Task> updatedTasks = state.tasks
          .map((task) => task.id == event.task.id ? event.task : task)
          .toList();
      emit(TaskLoadSuccess(updatedTasks));
    }
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    if (state is TaskLoadSuccess) {
      final List<Task> updatedTasks = state.tasks
          .where((task) => task.id != event.task.id)
          .toList();
      emit(TaskLoadSuccess((updatedTasks)));
    }
  }
}
