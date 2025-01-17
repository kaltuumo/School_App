import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditDonor extends StatefulWidget {
  @override
  _EditDonorState createState() => _EditDonorState();
}

class _EditDonorState extends State<EditDonor> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String donorId = "";

  @override
  void initState() {
    super.initState();
    donorId = ModalRoute.of(context)?.settings.arguments as String;
    _loadDonorDetails();
  }

  Future<void> _loadDonorDetails() async {
    try {
      final donorDoc = await _firestore.collection('donors').doc(donorId).get();
      final donor = donorDoc.data();
      if (donor != null) {
        _nameController.text = donor['name'];
        _emailController.text = donor['email'];
        _phoneController.text = donor['phone'];
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _updateDonor() async {
    try {
      await _firestore.collection('donors').doc(donorId).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'updatedAt': Timestamp.now(),
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Donor Updated')));
      Navigator.pushNamed(
          context, '/editdonor'); // Go back to the previous screen
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error updating donor')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Donor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateDonor,
              child: Text('Update Donor'),
            ),
          ],
        ),
      ),
    );
  }
}
