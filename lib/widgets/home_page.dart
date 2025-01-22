import 'package:flutter/material.dart';
import 'package:school_app/widgets/about.dart';
import 'package:school_app/widgets/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected index

  final List<String> imageData = [
    "images/quiz.png",
    "images/pdf.png",
    "images/job.png",
    "images/about.png",
  ];

  final List<String> titles = [
    'Primary and Secondary School',
    'Basic and Memorizing Holy Quran',
    'Sharica Schools',
    'About Us',
  ];

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    if (index == 1) {
      // Navigate to About Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => About()),
      ).then((_) {
        setState(() {
          _selectedIndex = 0; // Reset to Home tab
        });
      });
    } else if (index == 2) {
      // Navigate to Settings Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingPage()),
      ).then((_) {
        setState(() {
          _selectedIndex = 0; // Reset to Home tab
        });
      });
    }
  }

  // Function to show the menu when the menu icon is clicked
  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Admin"),
                onTap: () {
                  Navigator.pushNamed(context, '/admindashboard');
                  // Navigator.pop(context); // Close the menu
                },
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text("Student"),
                onTap: () {
                  Navigator.pushNamed(context, '/student');
                  // Navigator.pop(context); // Close the menu
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.indigo,
          height: height,
          width: width,
          child: Column(
            children: [
              // Top Section
              Container(
                height: height * 0.25,
                width: width,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 45, left: 30, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              // Show the menu when the menu icon is clicked
                              _showMenu(context);
                            },
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              image: const DecorationImage(
                                image: AssetImage("images/woman.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Welcome to our educational platform",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white54,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Grid Section
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                height: height * 0.75,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 25,
                    ),
                    itemCount: imageData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (index == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => About()),
                            );
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                imageData[index],
                                width: 100,
                              ),
                              Text(
                                titles[index],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white54,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
      ),
      backgroundColor: Colors.blue,
    );
  }
}
