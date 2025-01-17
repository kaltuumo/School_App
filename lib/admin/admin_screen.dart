import 'package:flutter/material.dart';
import 'package:school_app/donors/donor_create.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pushNamed(
                context, '/login'); // Go back to the previous screen
          },
        ),
      ),
    );
  }
}
