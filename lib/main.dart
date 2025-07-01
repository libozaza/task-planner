import 'package:flutter/material.dart';
import 'pages/feedback_page.dart';
import 'pages/todolist_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'bakablaster',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF193722)),
        ),
        home: const MyHomePage(title: 'lock in'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // basic page that prompts the user to add a task with a button to send http req
  var taskFieldCtrl = TextEditingController();

  void sendButton() {
    // this should send users to a new page where they talk to ai bot, this means rerouting first and
    // then running async http req,
    // FOR NOW: I WILL REROUTE TO NEW PAGE AND SPIT USERS INPUT IN THEY FACE
    final String taskDraft = taskFieldCtrl.text;
    taskFieldCtrl.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackPage(taskDraft)),
    );
  }

  void toTaskList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: toTaskList,
        child: Text('open tasks'),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: SizedBox(
                width: 200,
                child: TextField(
                  controller: taskFieldCtrl,
                  decoration: InputDecoration(
                    hintText: 'add a task',
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
            ),
            ElevatedButton(
              onPressed: sendButton,
              child: Text('send', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
