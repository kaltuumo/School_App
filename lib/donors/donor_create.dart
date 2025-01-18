import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateDonor extends StatefulWidget {
  const CreateDonor({super.key});

  @override
  _CreateDonorState createState() => _CreateDonorState();
}

class _CreateDonorState extends State<CreateDonor> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  String _gender = 'Male'; // Default value
  bool _isPasswordVisible = false; // To control password visibility
  bool _isLoading = false; // To track loading state

  Future<void> _addDonor() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      await _firestore.collection('donors').add({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
        'gender': _gender,
        'createdAt': Timestamp.now(),
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Donor Added')));

      // Show dialog after donor is successfully added
      _showSuccessDialog();
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error adding donor')));
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  // Function to show success dialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Donor Registered Successfully'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushNamed(context,
                    '/createdonor'); // Navigate back to previous screen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Donor'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 90),
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
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible, // Toggle password visibility
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: false), // Only numbers
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Gender: ', style: TextStyle(fontSize: 16)),
                  Radio<String>(
                    value: 'Male',
                    groupValue: _gender,
                    onChanged: (String? value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  Text('Male'),
                  Radio<String>(
                    value: 'Female',
                    groupValue: _gender,
                    onChanged: (String? value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  Text('Female'),
                ],
              ),
              const SizedBox(height: 20),
              // Show loading indicator while processing
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _addDonor,
                      child: Text('Add Donor'),
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
