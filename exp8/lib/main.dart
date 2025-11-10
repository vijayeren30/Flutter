import 'package:flutter/material.dart';

void main() {
  runApp(const EmulatorApp());
}

class EmulatorApp extends StatelessWidget {
  const EmulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emulator Preview',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: const Center(child: FakePhoneFrame()),
      ),
    );
  }
}

class FakePhoneFrame extends StatelessWidget {
  const FakePhoneFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 640,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 20, spreadRadius: 2),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: TaskSearchScreen(),
          ),
        ),
      ),
    );
  }
}

class TaskSearchScreen extends StatefulWidget {
  const TaskSearchScreen({super.key});

  @override
  State<TaskSearchScreen> createState() => _TaskSearchScreenState();
}

class _TaskSearchScreenState extends State<TaskSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _taskData;

  // Mock Firestore-like data
  final Map<String, Map<String, dynamic>> _mockDatabase = {
    'running': {'minutes': 20, 'time': '3:00 AM'},
    'eating': {'minutes': 15, 'time': '10:00 AM'},
    'reading': {'minutes': 30, 'time': '8:00 PM'},
  };

  void _searchTask() {
    final name = _controller.text.trim().toLowerCase();
    setState(() {
      _taskData = _mockDatabase[name];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Task Search using Firestore'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter task name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _searchTask, child: const Text('Search')),
            const SizedBox(height: 20),
            if (_taskData != null)
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${_controller.text}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Minutes: ${_taskData!['minutes']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Time: ${_taskData!['time']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            const Spacer(),
            const Text(
              'Total Completed Tasks: 1',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
