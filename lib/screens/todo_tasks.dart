import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/screens/task_detail.dart';
import '../models/task.dart';

class ToDoTasks extends StatefulWidget {
  static const id = 'todo_tasks_screen';

  const ToDoTasks({Key? key}) : super(key: key);

  @override
  State<ToDoTasks> createState() => _ToDoTasksState();
}

class _ToDoTasksState extends State<ToDoTasks> {
  final List<Task> _taskList = [
    Task(title: "lorem delete"),
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

  Widget _buildRow(BuildContext context, Task singleTask) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              setState(() {
                _taskList.remove(singleTask);
              });
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          )
        ],
      ),
      child: ListTile(
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
        onTap: () async {
          final result = await Navigator.of(context)
              .pushNamed(TaskDetail.id, arguments: singleTask);
          if (result != null) {
            //test add
            setState(() {
              _taskList.remove(singleTask);
              _taskList.add(result as Task);
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
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
                  itemCount: _taskList.length,
                  itemBuilder: (context, index) =>
                      _buildRow(context, _taskList[index]),
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(child: Text("${_taskList.length} tasks to do")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed(TaskDetail.id);
          if (result != null) {
            setState(() {
              _taskList.add(result as Task);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
