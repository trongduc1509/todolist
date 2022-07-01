const String tableTask = 'tasks';

class TaskFields {
  static const List<String> values = [id, title, content];

  static const String id = '_id';
  static const String title = 'title';
  static const String content = 'content';
}

class Task {
  final int? id;
  final String title;
  final String content;

  Task({this.id, required this.title, required this.content});

  static Task fromJSON(Map<String, Object?> map) => Task(
      id: map[TaskFields.id] as int?,
      title: map[TaskFields.title] as String,
      content: map[TaskFields.content] as String);

  Task copy({
    int? id,
    String? title,
    String? content,
  }) =>
      Task(
          id: id ?? this.id,
          title: title ?? this.title,
          content: content ?? this.content);

  Map<String, Object?> toJSON() => {
        TaskFields.id: id,
        TaskFields.title: title,
        TaskFields.content: content,
      };
}
