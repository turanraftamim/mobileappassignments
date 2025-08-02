import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redesigned Counter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Creative Counter'),
    );
  }
}

/// Stateful Home Page
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// Counter state logic
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Increment counter
  void _incrementCounter() => setState(() => _counter++);

  // Decrement counter (only if > 0)
  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  // Reset with snackbar
  void _resetCounter() {
    setState(() => _counter = 0);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Counter has been reset! 🔄'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Get message based on value
  String getFeedbackMessage() {
    if (_counter == 0) return 'Let’s get started! 🟢';
    if (_counter < 5) return 'Keep going! 🔥';
    if (_counter < 10) return 'You\'re doing great! 💪';
    return 'Whoa! Chill out 😅';
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
    _counter % 2 == 0 ? Colors.purple.shade50 : Colors.orange.shade50;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Counter Number
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Text(
                '$_counter',
                key: ValueKey(_counter),
                style: TextStyle(
                  fontSize: 90,
                  fontWeight: FontWeight.bold,
                  color: _counter % 2 == 0
                      ? Colors.deepPurple
                      : Colors.deepOrangeAccent,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Dynamic Message
            Text(
              getFeedbackMessage(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 40),

            // Button Column
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ActionButton(
                      icon: Icons.add_circle,
                      label: 'Add',
                      color: Colors.green,
                      onPressed: _incrementCounter,
                    ),
                    const SizedBox(height: 20),
                    ActionButton(
                      icon: Icons.remove_circle,
                      label: 'Subtract',
                      color: Colors.redAccent,
                      onPressed: _decrementCounter,
                    ),
                  ],
                ),
                ActionButton(
                  icon: Icons.restart_alt,
                  label: 'Reset',
                  color: Colors.grey,
                  onPressed: _resetCounter,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable Custom Button Widget
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 26),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        shadowColor: Colors.black26,
      ),
    );
  }
}