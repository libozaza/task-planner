import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/todo_list_provider.dart'; // import where your provider & Todo are defined

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toDos = ref.watch(toDoListProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('lock in'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: toDos.length,
        itemBuilder: (context, index) {
          final task = toDos[index];
          return CheckboxListTile(
            title: Text(task.title),
            value: task.isDone,
            onChanged: (_) {
              ref.read(toDoListProvider.notifier).toggleDone(task.id);
            },
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          ref.read(toDoListProvider.notifier).clearCompleted();
        },
        child: Text('Clear Completed'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
