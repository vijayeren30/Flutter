import 'package:flutter/material.dart';

void main() {
  runApp(FakeEmulator());
}

class FakeEmulator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emulator Preview',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Container(
            width: 320,
            height: 640,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: DailyPlannerScreen(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DailyPlannerScreen extends StatefulWidget {
  @override
  State<DailyPlannerScreen> createState() => _DailyPlannerScreenState();
}

class _DailyPlannerScreenState extends State<DailyPlannerScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _tasks = [];

  void _addTask() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _tasks.add({'task': text, 'done': false});
      });
      _controller.clear();
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Planner'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter a new task',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _addTask, child: const Text('Add Task')),
            const SizedBox(height: 20),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'No tasks',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: CheckboxListTile(
                            title: Text(
                              _tasks[index]['task'],
                              style: TextStyle(
                                decoration: _tasks[index]['done']
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            value: _tasks[index]['done'],
                            onChanged: (_) => _toggleTask(index),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total tasks: ${_tasks.length}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
