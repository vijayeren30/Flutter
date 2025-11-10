import 'package:flutter/material.dart';

void main() {
  runApp(DailyPlannerApp());
}

class DailyPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Planner',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: TaskInputScreen(),
    );
  }
}

class TaskInputScreen extends StatefulWidget {
  @override
  _TaskInputScreenState createState() => _TaskInputScreenState();
}

class _TaskInputScreenState extends State<TaskInputScreen> {
  final _nameController = TextEditingController();
  final _morningTaskController = TextEditingController();
  final _afternoonTaskController = TextEditingController();
  final _eveningTaskController = TextEditingController();

  void _submitData() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskResultScreen(
          name: _nameController.text,
          morning: _morningTaskController.text,
          afternoon: _afternoonTaskController.text,
          evening: _eveningTaskController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Planner Input Screen"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Your Name"),
            ),
            TextField(
              controller: _morningTaskController,
              decoration: InputDecoration(labelText: "Morning Task"),
            ),
            TextField(
              controller: _afternoonTaskController,
              decoration: InputDecoration(labelText: "Afternoon Task"),
            ),
            TextField(
              controller: _eveningTaskController,
              decoration: InputDecoration(labelText: "Evening Task"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskResultScreen extends StatelessWidget {
  final String name;
  final String morning;
  final String afternoon;
  final String evening;

  TaskResultScreen({
    required this.name,
    required this.morning,
    required this.afternoon,
    required this.evening,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Planner Result Screen"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.purple),
                title: Text("Name: $name"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.wb_sunny, color: Colors.orange),
                title: Text("Morning Task: $morning"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.work, color: Colors.blue),
                title: Text("Afternoon Task: $afternoon"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.nightlight_round, color: Colors.indigo),
                title: Text("Evening Task: $evening"),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Tasks Submitted Successfully!",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
