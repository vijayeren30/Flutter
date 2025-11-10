import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Planner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DailyPlannerHome(),
    );
  }
}

class DailyPlannerHome extends StatefulWidget {
  const DailyPlannerHome({super.key});

  @override
  _DailyPlannerHomeState createState() => _DailyPlannerHomeState();
}

class _DailyPlannerHomeState extends State<DailyPlannerHome> {
  final List<Map<String, String>> tasks = [
    {
      'title': 'Morning Task',
      'description': 'Go for a jog at 6:30 AM',
      'image': 'assets/morning.jpg',
    },
    {
      'title': 'Afternoon Task',
      'description': 'Complete work from 12 PM to 3 PM',
      'image': 'assets/Afternoon.jpg',
    },
    {
      'title': 'Evening Task',
      'description': 'Family dinner at 8 PM',
      'image': 'assets/Evening.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daily Planner")),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: ListTile(
              leading: Image.asset(
                task['image']!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                task['title']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(task['description']!),
            ),
          );
        },
      ),
    );
  }
}
