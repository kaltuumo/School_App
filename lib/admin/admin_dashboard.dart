import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AdminDashboard(),
  ));
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Grid of dashboard cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 columns for the layout
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                      context, 'Admin', Icons.admin_panel_settings),
                  _buildDashboardCard(context, 'Donor', Icons.person),
                  _buildDashboardCard(context, 'Supervisor', Icons.people_alt),
                  _buildDashboardCard(context, 'Students', Icons.school),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set default index
        onTap: (index) {},
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Setting',
          ),
        ],
      ),
    );
  }

  // Build individual dashboard cards (without functionality)
  Widget _buildDashboardCard(
      BuildContext context, String title, IconData icon) {
    return Card(
      elevation: 4,
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
