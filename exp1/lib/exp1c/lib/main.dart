import 'package:flutter/material.dart';

void main() {
  runApp(const DailyPlannerApp());
}

class DailyPlannerApp extends StatelessWidget {
  const DailyPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('My Daily Planner')),
        body: SingleChildScrollView(
          // Allows scrolling if content exceeds screen height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Morning Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Morning',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              _buildDailyEvent(
                '9:00 AM',
                'Breakfast',
                'Healthy start to the day',
              ),
              _buildDailyEvent('10:00 AM', 'College', 'Attending Classes'),
              const Divider(),

              // Afternoon Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Afternoon',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              _buildDailyEvent(
                '1:00 PM',
                'Lunch Break',
                'Quick bite at the cafe',
              ),
              _buildDailyEvent('2:00 PM', 'Lab Work', 'Experiments'),
              const Divider(),

              // Evening Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Evening',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              _buildDailyEvent('6:00 PM', 'Gym', 'Workout session'),
              _buildDailyEvent('8:00 PM', 'Dinner', 'Cook a meal at home'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyEvent(String time, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 80,
            child: Text(
              time,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(fontSize: 16.0)),
                Text(description, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
