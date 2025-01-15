import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String currentpass;
  late String newpass;
  late String compass;
  String errorMessage = '';

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isComfPasswordVisible = false;

  void _changePassword() async {
    try {
      User? user = _auth.currentUser;

      // Ensure user is logged in and email matches
      if (user != null && user.email == email) {
        // Reauthenticate the user with the provided credentials
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: currentpass,
        );

        try {
          // Try to reauthenticate the user with the current password
          await user.reauthenticateWithCredential(credential);

          // If reauthentication is successful, show SnackBar
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Your Current Password is valid.'),
          //     backgroundColor: Colors.green,
          //   ),
          // );

          // Check if the new password matches the confirm password
          if (newpass == compass) {
            // Update the password
            await user.updatePassword(newpass);

            // Show success dialog for password change
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Success'),
                content: Text('Your password has been changed successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context); // Navigate back to login screen
                    },
                    child: Text('Ok'),
                  ),
                ],
              ),
            );
          } else {
            setState(() {
              errorMessage = 'Passwords do not match.';
            });
          }
        } catch (e) {
          // If reauthentication fails, display error
          setState(() {
            errorMessage = 'Invalid current password.';
          });
        }
      } else {
        // If email doesn't exist, show error
        setState(() {
          errorMessage = 'Email does not exist.';
        });
      }
    } catch (e) {
      // Catch any other exceptions
      setState(() {
        errorMessage = e.toString(); // Display error message in case of failure
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 100),
              Text(
                'Change Your Password',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Please enter your email, current password, and the new password you want to set.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              // Email Field
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email, color: Colors.black),
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 20),

              // Current Password Field
              TextField(
                obscureText: !_isCurrentPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isCurrentPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  currentpass = value;
                },
              ),
              SizedBox(height: 20),

              // New Password Field
              TextField(
                obscureText: !_isNewPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  newpass = value;
                },
              ),
              SizedBox(height: 20),

              // Confirm New Password Field
              TextField(
                obscureText: !_isComfPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isComfPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isComfPasswordVisible = !_isComfPasswordVisible;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  compass = value;
                },
              ),
              SizedBox(height: 40),

              // Display error message if any
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),

              // Update Password Button
              ElevatedButton(
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Update Password',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Cancel Button
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
