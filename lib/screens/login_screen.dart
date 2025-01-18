import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with RouteAware {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String email;
  late String password;
  bool _isPasswordVisible = false; // Controls password visibility
  bool _isLoading = false;

  String _emailErrorMessage = ''; // For email error message
  String _passwordErrorMessage = ''; // For password error message

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    email = '';
    password = '';
  }

  @override
  @override
  void didPopNext() {
    super.didPopNext();
    // Reset all fields when returning to the login screen
    setState(() {
      email = '';
      password = '';
      _emailErrorMessage = '';
      _passwordErrorMessage = '';
    });
  }

  // Reset error messages when the user starts typing
  void _onEmailChanged(String value) {
    email = value;
    setState(() {
      _emailErrorMessage = ''; // Reset email error when typing
    });
  }

  void _onPasswordChanged(String value) {
    password = value;
    setState(() {
      _passwordErrorMessage = ''; // Reset password error when typing
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Welcome Back!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Log in to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _onEmailChanged, // Call function on change
                  ),
                  const SizedBox(height: 5),
                  if (_emailErrorMessage.isNotEmpty)
                    Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          _emailErrorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: !_isPasswordVisible, // Toggle visibility
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible =
                                !_isPasswordVisible; // Toggle visibility
                          });
                        },
                      ),
                    ),
                    onChanged: _onPasswordChanged, // Call function on change
                  ),
                  const SizedBox(height: 5),
                  if (_passwordErrorMessage.isNotEmpty)
                    Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          _passwordErrorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                              _emailErrorMessage = ''; // Reset email error
                              _passwordErrorMessage =
                                  ''; // Reset password error
                            });
                            try {
                              // Sign in with email and password
                              final userCredential =
                                  await _auth.signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                              final user = userCredential.user;

                              if (user != null) {
                                // Fetch the user data from Firestore
                                DocumentSnapshot userDoc = await _firestore
                                    .collection('users')
                                    .doc(user.uid)
                                    .get();

                                if (userDoc.exists) {
                                  // Get user role from Firestore
                                  String role = userDoc['role'];

                                  // Navigate based on the role
                                  if (role == 'Admin') {
                                    Navigator.pushNamed(
                                        context, '/admindashboard');
                                  } else if (role == 'Donor') {
                                    Navigator.pushNamed(context, '/donor');
                                  } else if (role == 'Supervisor') {
                                    Navigator.pushNamed(context, '/supervisor');
                                  } else {
                                    // Show error if no valid role is found
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Access Denied"),
                                        content: const Text(
                                            "Selected role does not match your profile."),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  // User data not found in Firestore
                                  print(
                                      "User data not found for UID: ${user.uid}");
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text(
                                          "User data not found. Please try again."),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                // General login failure dialog
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Error'),
                                    content:
                                        Text('Login failed. Please try again.'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Ok'))
                                    ],
                                  ),
                                );
                              }

                              // Clear email and password fields after successful login
                              setState(() {
                                _isLoading = false;
                              });
                            } catch (e) {
                              setState(() {
                                _isLoading = false;
                              });

                              String errorMessage =
                                  'Login failed. Please try again.';

                              if (e is FirebaseAuthException) {
                                if (e.code == 'user-not-found') {
                                  setState(() {
                                    _emailErrorMessage =
                                        'Invalid Email. Please Try Again.';
                                  });
                                } else if (e.code == 'wrong-password') {
                                  setState(() {
                                    _passwordErrorMessage =
                                        'Invalid password. Please try again.';
                                  });
                                } else if (e.code == 'invalid-email') {
                                  setState(() {
                                    _emailErrorMessage =
                                        'The email address is not valid.';
                                  });
                                }
                              }

                              print("Error during login: $e");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot');
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
