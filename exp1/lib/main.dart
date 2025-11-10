import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Stateless widget — App setup
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Planner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DailyPlannerHome(),
    );
  }
}

// Stateful widget — For interactive UI
class DailyPlannerHome extends StatefulWidget {
  @override
  _DailyPlannerHomeState createState() => _DailyPlannerHomeState();
}

class _DailyPlannerHomeState extends State<DailyPlannerHome> {
  List<Map<String, String>> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daily Planner")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Plan:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Time selection buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tasks = [
                        {"title": "Exercise", "image": "assets/morning.png"},
                        {
                          "title": "Healthy Breakfast",
                          "image": "assets/morning.png",
                        },
                        {
                          "title": "Plan Daily Goals",
                          "image": "assets/morning.png",
                        },
                        {"title": "Read a Book", "image": "assets/morning.png"},
                        {"title": "Meditation", "image": "assets/morning.png"},
                      ];
                    });
                  },
                  child: Text("Morning"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tasks = [
                        {
                          "title": "Work on Project",
                          "image": "assets/afternoon.png",
                        },
                        {
                          "title": "Lunch Break",
                          "image": "assets/afternoon.png",
                        },
                        {
                          "title": "Reply Emails",
                          "image": "assets/afternoon.png",
                        },
                        {
                          "title": "Team Meeting",
                          "image": "assets/afternoon.png",
                        },
                        {
                          "title": "Client Call",
                          "image": "assets/afternoon.png",
                        },
                      ];
                    });
                  },
                  child: Text("Afternoon"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tasks = [
                        {
                          "title": "Evening Walk",
                          "image": "assets/evening.png",
                        },
                        {"title": "Dinner", "image": "assets/evening.png"},
                        {
                          "title": "Watch a Movie",
                          "image": "assets/evening.png",
                        },
                        {
                          "title": "Write Journal",
                          "image": "assets/evening.png",
                        },
                        {
                          "title": "Plan for Tomorrow",
                          "image": "assets/evening.png",
                        },
                      ];
                    });
                  },
                  child: Text("Evening"),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Customized ListView for tasks
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        tasks[index]["image"]!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        tasks[index]["title"]!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text("Tap to mark as done"),
                      trailing: Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Marked '${tasks[index]["title"]}' as done",
                            ),
                          ),
                        );
                      },
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
