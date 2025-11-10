import 'package:flutter/material.dart';

void main() {
  runApp(DailyPlannerApp());
}

class DailyPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Planner',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: DailyPlannerScreen(),
    );
  }
}

class Task {
  final String title;
  final String time;

  Task({required this.title, required this.time});
}

class DailyPlannerScreen extends StatefulWidget {
  @override
  _DailyPlannerScreenState createState() => _DailyPlannerScreenState();
}

class _DailyPlannerScreenState extends State<DailyPlannerScreen> {
  final List<Task> tasks = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  void _addTask() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        tasks.add(Task(title: titleController.text, time: timeController.text));
        titleController.clear();
        timeController.clear();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Task added successfully!')));
    }
  }

  void _showTaskDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Task Details"),
        content: Text("${task.title}\nTime: ${task.time}"),
        actions: [
          TextButton(
            child: Text("Close"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Planner"),
        backgroundColor: Colors.purple.shade400,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: "Enter Task Title",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: timeController,
                    decoration: InputDecoration(
                      labelText: "Enter Time (e.g., 7:00 AM)",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      // Simple time format check
                      final regex = RegExp(r'^[0-9]{1,2}:[0-9]{2}\s?(AM|PM)?$');
                      if (!regex.hasMatch(value)) {
                        return 'Enter a valid time (e.g., 6:30 AM)';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onPressed: _addTask,
                    child: Text("Add Task"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(task.title[0]),
                      backgroundColor: Colors.purple.shade100,
                    ),
                    title: Text(task.title),
                    subtitle: Text("Time: ${task.time}"),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        _showTaskDialog(task);
                      },
                      child: Text("Done"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
