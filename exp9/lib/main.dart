import 'package:flutter/material.dart';

void main() {
  runApp(const EmulatorApp());
}

class EmulatorApp extends StatelessWidget {
  const EmulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fake Emulator',
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
            home: UpdateDailyTasksScreen(),
          ),
        ),
      ),
    );
  }
}

class UpdateDailyTasksScreen extends StatefulWidget {
  const UpdateDailyTasksScreen({super.key});

  @override
  State<UpdateDailyTasksScreen> createState() => _UpdateDailyTasksScreenState();
}

class _UpdateDailyTasksScreenState extends State<UpdateDailyTasksScreen> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _task;
  bool _taskLoaded = false;

  // Mock database
  final Map<String, Map<String, dynamic>> _mockDB = {
    'running': {'minutes': 30},
    'reading': {'minutes': 45},
    'coding': {'minutes': 120},
  };

  void _searchTask() {
    final name = _controller.text.trim().toLowerCase();
    setState(() {
      _task = _mockDB[name];
      _taskLoaded = _task != null;
    });
  }

  void _updateTask() {
    if (_task != null) {
      setState(() {
        _taskLoaded = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task updated successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Update Daily Tasks'),
        backgroundColor: Colors.redAccent,
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
            ElevatedButton(
              onPressed: _searchTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[100],
              ),
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            if (_task != null)
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task: ${_controller.text}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Minutes: ${_task!['minutes']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 15),
            if (_task != null)
              ElevatedButton(
                onPressed: _updateTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Update'),
              ),
            const SizedBox(height: 10),
            if (_taskLoaded)
              const Text(
                'Task loaded successfully!',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
