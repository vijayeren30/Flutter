import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// ---------------------- Data Model ----------------------
class DailyTask {
  int? id;
  String title;
  String description;
  bool isCompleted;

  DailyTask({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory DailyTask.fromMap(Map<String, dynamic> map) {
    return DailyTask(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}

// ---------------------- Database Helper ----------------------
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('daily_planner.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE daily_tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        isCompleted INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertTask(DailyTask task) async {
    final db = await instance.database;
    return await db.insert('daily_tasks', task.toMap());
  }

  Future<List<DailyTask>> getTasks() async {
    final db = await instance.database;
    final result = await db.query('daily_tasks', orderBy: 'id DESC');
    return result.map((map) => DailyTask.fromMap(map)).toList();
  }

  Future<int> updateTask(DailyTask task) async {
    final db = await instance.database;
    return await db.update(
      'daily_tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete('daily_tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

// ---------------------- Main App ----------------------
void main() {
  runApp(DailyPlannerApp());
}

class DailyPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Planner',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: DailyPlannerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ---------------------- UI ----------------------
class DailyPlannerPage extends StatefulWidget {
  @override
  _DailyPlannerPageState createState() => _DailyPlannerPageState();
}

class _DailyPlannerPageState extends State<DailyPlannerPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  List<DailyTask> _tasks = [];

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  Future<void> _refreshTasks() async {
    final tasks = await DatabaseHelper.instance.getTasks();
    setState(() => _tasks = tasks);
  }

  Future<void> _addTask() async {
    if (_formKey.currentState!.validate()) {
      final newTask = DailyTask(
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
      );

      await DatabaseHelper.instance.insertTask(newTask);
      _titleController.clear();
      _descController.clear();
      _refreshTasks();
    }
  }

  Future<void> _toggleTaskCompletion(DailyTask task) async {
    task.isCompleted = !task.isCompleted;
    await DatabaseHelper.instance.updateTask(task);
    _refreshTasks();
  }

  Future<void> _deleteTask(int id) async {
    await DatabaseHelper.instance.deleteTask(id);
    _refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Planner App')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // ------------------ Task Input Form ------------------
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Task Title'),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter task title' : null,
                  ),
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(
                      labelText: 'Task Description',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addTask,
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ------------------ Task List ------------------
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(child: Text('No tasks yet.'))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return Card(
                          color: task.isCompleted
                              ? Colors.indigo[50]
                              : Colors.white,
                          child: ListTile(
                            leading: Checkbox(
                              value: task.isCompleted,
                              onChanged: (_) => _toggleTaskCompletion(task),
                              activeColor: Colors.indigo,
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(task.description),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTask(task.id!),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
