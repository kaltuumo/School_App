import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2, // 2 columns for the layout
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildDashboardCard(
                  context, 'Admin', Icons.admin_panel_settings, '/createdonor'),
              _buildDashboardCard(context, 'Donor', Icons.person, '/donorlist'),
              _buildDashboardCard(
                  context, 'Supervisor', Icons.people_alt, '/supervisor'),
              _buildDashboardCard(
                  context, 'Students', Icons.school, '/student'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
      BuildContext context, String title, IconData icon, String route) {
    return InkWell(
      onTap: () {
        // Navigate to the route when the card is tapped
        Navigator.pushNamed(context, route);
      },
      child: Card(
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
      ),
    );
  }
}
