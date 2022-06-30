import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetail extends StatefulWidget {
  static const id = 'task_detail_screen';

  final Task? task;

  const TaskDetail({Key? key, this.task}) : super(key: key);

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  final _taskTitleController = TextEditingController();
  final _taskContentController = TextEditingController();
  bool _onChange = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Task? task = widget.task;
    if (task != null) {
      _taskTitleController.text = task.title;
      _taskContentController.text = task.content;
    }
    _taskTitleController.addListener(() => setState(() => _onChange = true));
    _taskContentController.addListener(() => setState(() => _onChange = true));
  }

  Future<bool?> _onBackPressed(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Pls fill title of this task'),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('OK'))
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_taskTitleController.text.isEmpty &&
            _taskContentController.text.isNotEmpty) {
          final warning = await _onBackPressed(context);
          return warning ?? false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task Detail'),
          actions: [
            _onChange
                ? TextButton(
                    onPressed: () {
                      if (_taskTitleController.text.isEmpty) {}
                    },
                    child: const Text(
                      'DONE',
                      style: TextStyle(color: Colors.white),
                    ))
                : Container(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                  controller: _taskTitleController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Title...',
                    label: Text(
                      'Title',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: TextField(
                  style: const TextStyle(fontSize: 20.0),
                  controller: _taskContentController,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'Content...',
                      label: Text(
                        'Content',
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      border: InputBorder.none),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
