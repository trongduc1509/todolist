import 'package:flutter/material.dart';
import './screens/todo_tasks.dart';
import './screens/task_detail.dart';
import './models/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ToDoTasks.id,
      routes: {
        ToDoTasks.id: (_) => const ToDoTasks(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == TaskDetail.id) {
          return MaterialPageRoute(builder: (context) {
            if (settings.arguments != null) {
              final args = settings.arguments as Task;
              return TaskDetail(task: args);
            }
            return const TaskDetail(task: null);
          });
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
