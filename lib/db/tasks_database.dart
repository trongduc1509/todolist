import 'package:sqflite/sqflite.dart';
import '../models/task.dart';
import 'package:path/path.dart' as p;

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _db;

  factory TaskDatabase() {
    return instance;
  }

  TaskDatabase._init();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb('tasks.db');
    return _db!;
  }

  Future<Database> initDb(String filePath) async {
    String dbpath = p.join(await getDatabasesPath(), filePath);
    return await openDatabase(dbpath, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const titleType = 'TEXT NOT NULL';
    const contentType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tableTask (
      ${TaskFields.id} $idType,
      ${TaskFields.title} $titleType,
      ${TaskFields.content} $contentType)''');
  }

  Future<void> close() async {
    final dtb = await instance.db;

    dtb.close();
  }

  Future<Task> createTask(Task task) async {
    final dtb = await instance.db;

    final id = await dtb.insert(tableTask, task.toJSON());

    return task.copy(id: id);
  }

  Future<Task> readTask(int id) async {
    final dtb = await instance.db;

    final result = await dtb.query(tableTask,
        columns: TaskFields.values,
        where: '${TaskFields.id} = ?',
        whereArgs: [id]);

    if (result.isNotEmpty) {
      return Task.fromJSON(result.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Task>> readAllTask() async {
    final dtb = await instance.db;

    final result = await dtb.query(tableTask);

    return result.map((e) => Task.fromJSON(e)).toList();
  }

  Future<int> updateTask(Task task) async {
    final dtb = await instance.db;

    final result = dtb.update(tableTask, task.toJSON(),
        where: '${TaskFields.id} = ?', whereArgs: [task.id]);

    return result;
  }

  Future<int> deleteTask(int id) async {
    final dtb = await instance.db;

    return await dtb
        .delete(tableTask, where: '${TaskFields.id} = ?', whereArgs: [id]);
  }
}
