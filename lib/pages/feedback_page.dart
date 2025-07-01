import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todolist_page.dart';
import '../providers/todo_list_provider.dart';

class FeedbackPage extends ConsumerStatefulWidget {
  const FeedbackPage(this.task, {super.key});

  final String task;

  @override
  ConsumerState<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends ConsumerState<FeedbackPage> {
  final taskFieldCtrl = TextEditingController();

  void addToList() {
    final newTask = taskFieldCtrl.text.trim();
    if (newTask.isEmpty) return;

    ref.read(toDoListProvider.notifier).add(newTask);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TodoList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Feedback'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              'You typed: ${widget.task}',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          Text(
            '\n AI feedback: Why was 5 afraid of 7? because he was a registered six-offender! HA HA HA',
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: taskFieldCtrl,
                  decoration: InputDecoration(
                    hintText: 'Revise your task',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        taskFieldCtrl.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  minLines: 1,
                  maxLines: 100,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: addToList,
                child: Icon(Icons.add, size: 18),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
