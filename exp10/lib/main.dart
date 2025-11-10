import 'package:flutter/material.dart';

void main() {
  runApp(const EmulatorApp());
}

class EmulatorApp extends StatelessWidget {
  const EmulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fake Emulator Login',
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
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 20, spreadRadius: 2),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: UserLoginScreen(),
          ),
        ),
      ),
    );
  }
}

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  // Dummy credentials (manual authentication)
  final String validEmail = 'vijaypraneeth@gmail.com';
  final String validPassword = '12345';

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _errorMessage = null;
    });

    if (email == validEmail && password == validPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserDashboard(name: 'Vijay Praneeth'),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid email or password. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('User Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.spa_rounded,
              size: 100,
              color: Colors.purpleAccent,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent[400],
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 12,
                ),
              ),
              child: const Text('Login'),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class UserDashboard extends StatelessWidget {
  final String name;
  const UserDashboard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text('User Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Welcome, $name!',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
