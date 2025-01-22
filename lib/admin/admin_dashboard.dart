import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Supervisors'),
    Text('Donors'),
    Text('Students'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Admin Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Admin'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pushNamed(context, '/admindashboard');
              },
            ),
            ListTile(
              leading: Icon(Icons.supervisor_account), // Icon-ka supervisor

              title: Text('Supervisors'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pushNamed(context, '/supervisor');
              },
            ),
            ListTile(
              leading: Icon(Icons.people), // Donor icon

              title: Text('Donors'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pushNamed(context, '/createdonor');
              },
            ),
            ListTile(
              leading: Icon(Icons.school), // Students icon

              title: Text('Students'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pushNamed(context, '/student');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
