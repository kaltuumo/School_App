import 'package:flutter/material.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Donor'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Create Donor',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot');
                    },
                    child: const Text(
                      "Don,t have an account?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Space between the buttons
            SizedBox(
              width: double
                  .infinity, // Makes the button take up the full width of the screen
              height: 50, // Set the height of the button
              child: ElevatedButton(
                onPressed: () {
                  // Handle login logic here
                  Navigator.pushNamed(context,
                      '/home'); // Update '/home' with your actual route
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('Log In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
