import 'package:flutter/material.dart';

void main() {
  runApp(DailyPlannerApp());
}

class Task {
  final String title;
  final String time;
  final String description;

  Task({required this.title, required this.time, required this.description});
}

class DailyPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Planner',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: DailyPlannerScreen(),
    );
  }
}

class DailyPlannerScreen extends StatelessWidget {
  final List<Task> tasks = [
    Task(
      title: "Morning Exercise",
      time: "6:00 AM",
      description: "Go for a 30 min jog",
    ),
    Task(
      title: "Team Meeting",
      time: "10:00 AM",
      description: "Discuss project updates",
    ),
    Task(
      title: "Lunch",
      time: "1:00 PM",
      description: "Healthy meal and quick break",
    ),
    Task(
      title: "Work Session",
      time: "3:00 PM",
      description: "Focus on coding tasks",
    ),
    Task(
      title: "Evening Reading",
      time: "7:00 PM",
      description: "Read 20 pages of a book",
    ),
  ];

  void _showTaskDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Task Reminder"),
        content: Text("${task.title} at ${task.time}\n\n${task.description}"),
        actions: [
          TextButton(
            child: Text("OK"),
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
        backgroundColor: Colors.indigoAccent,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "TODAY",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade100,
                child: Text(task.title[0]),
              ),
              title: Text(task.title),
              subtitle: Text("${task.time}\n${task.description}"),
              isThreeLine: true,
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  _showTaskDialog(context, task);
                },
                child: Text("Done"),
              ),
            ),
          );
        },
      ),
    );
  }
}
