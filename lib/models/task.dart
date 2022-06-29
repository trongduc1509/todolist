class Task {
  late int _id;
  late String _title;
  late String _content;

  Task(
      {int id = 1,
      required String title,
      String content =
          'lorem content, some description, some description, some description, some description, some description, some description, some description, some description, some description, some description, some description, some description, some description'}) {
    _id = id;
    _title = title;
    _content = content;
  }

  set id(int id) {
    _id = id;
  }

  set title(String title) {
    _title = title;
  }

  set content(String content) {
    _content = content;
  }

  int get id => _id;

  String get title => _title;

  String get content => _content;
}
