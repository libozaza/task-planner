import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/task.dart';

part 'todo_list_provider.g.dart';

@riverpod
class ToDoList extends _$ToDoList {
  @override
  List<Task> build() {
    ref.keepAlive();
    return [];
  }

  // add to list
  void add(String task) {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: task,
      isDone: false,
    );
    state = [...state, newTask];
  }

  // toggle tasks
  void toggleDone(String id) {
    state = state
        .map(
          (task) => task.id == id ? task.copyWith(isDone: !task.isDone) : task,
        )
        .toList();
  }

  // remove Completed
  void clearCompleted() {
    state = state.where((task) => !task.isDone).toList();
  }
}
