import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  late String email;

  ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'Forgot Password',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Enter your email address to receive a password reset link.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (email.isNotEmpty) {
                    try {
                      await _auth.sendPasswordResetEmail(email: email);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password reset link sent to $email.'),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${e.message}'),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a valid email address.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    // textStyle: TextStyle(fontSize: 18), // Font size
                    ),
                child: Text('Back To Login'),
              ),

              // No action for now
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                    // textStyle: TextStyle(fontSize: 18), // Font size
                    ),
                child: Text('Back To Login'),
              ),

              // No action for now
            )
          ],
        ),
      ),
    );
  }
}
