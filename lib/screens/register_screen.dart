import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "register_screen";

  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String name;
  late String email;
  late String password;
  late String confpassword;
  String? _selectedRole; // Default role

  bool _isPasswordvisible = false;
  bool _isComfPasswordVisible = false;
  bool _isLoading = false;

  String _nameErrorMessage = '';
  String _confPasswordErrorMessage =
      ''; // Add error message for confirm password
  final List<String> _roles = ['Admin', 'Supervisor', 'Donor'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Sign up to get started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.person),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                        _nameErrorMessage = ''; // Reset error message
                      });
                    },
                  ),
                  if (_nameErrorMessage.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.error, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          _nameErrorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: !_isPasswordvisible,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordvisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordvisible = !_isPasswordvisible;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: !_isComfPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isComfPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isComfPasswordVisible = !_isComfPasswordVisible;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      confpassword = value;
                    },
                  ),
                  if (_confPasswordErrorMessage.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.error, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          _confPasswordErrorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),

                  // Role Selection Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: InputDecoration(
                      labelText: 'Select Role',
                      labelStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.account_circle),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedRole = newValue;
                      });
                    },
                    items: _roles
                        .map((role) => DropdownMenuItem<String>(
                              value: role,
                              child: Text(role),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select a Role';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _nameErrorMessage = '';
                              _confPasswordErrorMessage =
                                  ''; // Reset error messages
                            });

                            // Basic validation checks
                            if (name.isEmpty) {
                              setState(() {
                                _nameErrorMessage = 'Full name is required';
                              });
                              return;
                            }

                            if (email.isEmpty ||
                                password.isEmpty ||
                                confpassword.isEmpty ||
                                _selectedRole == null) {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) => const AlertDialog(
                              //     title: Text("Error"),
                              //     content: Text('Select!'),
                              //   ),
                              // );
                              return;
                            }

                            if (password != confpassword) {
                              setState(() {
                                _confPasswordErrorMessage =
                                    'Passwords do not match';
                              });
                              return;
                            }

                            setState(() {
                              _isLoading = true;
                            });

                            try {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                              );

                              // Save user role to Firestore
                              if (newUser != null) {
                                await _firestore
                                    .collection('users')
                                    .doc(newUser.user?.uid)
                                    .set({
                                  'name': name,
                                  'email': email,
                                  'role': _selectedRole,
                                  'uid': newUser.user?.uid,
                                });

                                setState(() {
                                  _isLoading = false;
                                });

                                // Show success message
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Success'),
                                    content: Text(
                                        'User Registered as $_selectedRole Successfully!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.pushNamed(
                                              context, '/login');
                                        },
                                        child: const Text('Ok'),
                                      )
                                    ],
                                  ),
                                );
                              }
                            } catch (e) {
                              setState(() {
                                _isLoading = false;
                              });
                              showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                  title: Text('Error'),
                                  content: Text(
                                      'Registration failed. Please try again.'),
                                ),
                              );
                              return;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          "Log In",
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
