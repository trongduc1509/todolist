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

  Future<bool?> _onEmptyTitle(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Pls fill title of this task'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(false);
                  },
                  child: const Text('OK'))
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool? warning;
        if (widget.task == null) {
          if (_taskTitleController.text.isEmpty &&
              _taskContentController.text.isNotEmpty) {
            warning = await _onEmptyTitle(context);
            return warning ?? false;
          }
        } else {
          if (_taskTitleController.text.isEmpty) {
            warning = await _onEmptyTitle(context);
            return warning ?? false;
          }
        }
        if (_taskTitleController.text.isEmpty) {
          Navigator.of(context).pop();
        } else {
          if (widget.task != null) {
            Navigator.of(context).pop(Task(
                id: widget.task!.id,
                title: _taskTitleController.text,
                content: _taskContentController.text));
          } else {
            Navigator.of(context).pop(Task(
                id: 1,
                title: _taskTitleController.text,
                content: _taskContentController.text));
          }
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
                      if (_taskTitleController.text.isEmpty) {
                        //Check empty title
                        if (widget.task == null &&
                            _taskContentController.text.isEmpty) {
                          return Navigator.of(context).pop();
                        }
                        _onEmptyTitle(context);
                      } else {
                        //Title not empty
                        if (widget.task != null) {
                          //Editting task
                          if (widget.task!.content !=
                                  _taskContentController.text ||
                              widget.task!.title != _taskTitleController.text) {
                            return Navigator.of(context).pop(Task(
                                id: widget.task!.id,
                                title: _taskTitleController.text,
                                content: _taskContentController.text));
                          }
                          return Navigator.of(context).pop();
                        }
                        //Adding task
                        return Navigator.of(context).pop(Task(
                            id: 1,
                            title: _taskTitleController.text,
                            content: _taskContentController.text));
                      }
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
