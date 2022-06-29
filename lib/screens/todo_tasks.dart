import 'package:flutter/material.dart';
import '../models/task.dart';

class ToDoTasks extends StatefulWidget {
  const ToDoTasks({Key? key}) : super(key: key);

  @override
  State<ToDoTasks> createState() => _ToDoTasksState();
}

class _ToDoTasksState extends State<ToDoTasks> {
  List<Task> taskList = [
    Task(title: "lorem"),
    Task(title: "lorem"),
    Task(title: "lorem"),
    Task(title: "lorem"),
    Task(title: "lorem"),
    Task(title: "lorem"),
    Task(title: "lorem"),
    Task(title: "lorem"),
    Task(title: "lorem"),
    Task(title: "lorem"),
  ];

  Widget _buildRow(Task singleTask) {
    return ListTile(
      title: Text(
        singleTask.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 18.0),
      ),
      subtitle: Text(
        singleTask.content,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 0.9,
                child: ListView.separated(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) => _buildRow(taskList[index]),
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(child: Text("${taskList.length} notes")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
