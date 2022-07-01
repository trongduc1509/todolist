import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/screens/task_detail.dart';
import '../models/task.dart';
import '../db/tasks_database.dart';

class ToDoTasks extends StatefulWidget {
  static const id = 'todo_tasks_screen';

  const ToDoTasks({Key? key}) : super(key: key);

  @override
  State<ToDoTasks> createState() => _ToDoTasksState();
}

class _ToDoTasksState extends State<ToDoTasks> {
  List<Task> taskList = [];
  late TaskDatabase taskDb;

  @override
  void initState() {
    super.initState();
    taskDb = TaskDatabase();
    getTasks();
  }

  void getTasks() async {
    List<Task> tempList = await taskDb.readAllTask();
    setState(() {
      taskList = tempList;
    });
  }

  Future<void> deleteTask(int taskId) async {
    await taskDb.deleteTask(taskId);
    getTasks();
  }

  Widget _buildRow(BuildContext context, Task singleTask) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirm your deletion'),
                      content: const Text(
                          'Your task will be deleted permanently! Do you want to do it?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('CANCEL')),
                        TextButton(
                            onPressed: () {
                              deleteTask(singleTask.id!);
                              Navigator.pop(context);
                            },
                            child: const Text('CONFIRM'))
                      ],
                    );
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
            getTasks();
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
                  itemCount: taskList.length,
                  itemBuilder: (context, index) =>
                      _buildRow(context, taskList[index]),
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(child: Text("${taskList.length} tasks to do")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed(TaskDetail.id);
          if (result != null) {
            setState(() {
              taskList.add(result as Task);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
