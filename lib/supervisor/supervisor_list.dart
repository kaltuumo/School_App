import 'package:flutter/material.dart';

class SupervisorList extends StatefulWidget {
  const SupervisorList({super.key});

  @override
  State<SupervisorList> createState() => _SupervisorListState();
}

class _SupervisorListState extends State<SupervisorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supervisor List"),
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
