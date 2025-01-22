import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 30),

            // Language Settings with black Icon
            TextButton(
              onPressed: () {
                // Show the Language selection dialog
                _showLanguageDialog(context);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // Remove button padding
                foregroundColor: Colors.black45, // Text color
              ),
              child: Row(
                children: [
                  Icon(Icons.language,
                      color: Colors.black45), // Icon for language (black)
                  SizedBox(width: 10), // Space between icon and text
                  Text(
                    'Language',
                    style: TextStyle(
                      fontSize: 14, // Font size of the text
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, height: 20),
            SizedBox(height: 30),

            // About settings with black Icon
            TextButton(
              onPressed: () {
                // Action for about settings
                Navigator.pushNamed(context, '/about');
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // Remove button padding
                foregroundColor: Colors.black45, // Text color
              ),
              child: Row(
                children: [
                  Icon(Icons.info,
                      color: Colors.black45), // Icon for about (black)
                  SizedBox(width: 10), // Space between icon and text
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 14, // Font size of the text
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, height: 20),
            SizedBox(height: 30),

            // Support section with black Icon
            Text(
              'Support',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 30),

            // Help with black Icon
            TextButton(
              onPressed: () {
                // Action for help settings
                print('Get Help Clicked');
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // Remove button padding
                foregroundColor: Colors.black45, // Text color
              ),
              child: Row(
                children: [
                  Icon(Icons.help_outline,
                      color: Colors.black45), // Icon for help (black)
                  SizedBox(width: 10), // Space between icon and text
                  Text(
                    'Get Help',
                    style: TextStyle(
                      fontSize: 14, // Font size of the text
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, height: 20),
            SizedBox(height: 30),

            // Center Settings with black Icon
            TextButton(
              onPressed: () {
                // Action for center settings
                print('Center Clicked');
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // Remove button padding
                foregroundColor: Colors.black45, // Text color
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on,
                      color: Colors.black45), // Icon for center (black)
                  SizedBox(width: 10), // Space between icon and text
                  Text(
                    'Center',
                    style: TextStyle(
                      fontSize: 14, // Font size of the text
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, height: 20),
            SizedBox(height: 30),

            // Additional settings options could go here...
          ],
        ),
      ),
    );
  }

  // Function to show the language selection dialog with flags
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(
                  context, 'English  🇬🇧', Colors.white24, 'English selected'),
              _buildLanguageOption(
                  context, 'Arabic  🇸🇦', Colors.white24, 'Arabic '),
              _buildLanguageOption(
                  context, 'Somali  🇸🇴', Colors.white24, 'Somali selected'),
            ],
          ),
        );
      },
    );
  }

  // Helper function to create a styled container for each language
  Widget _buildLanguageOption(
      BuildContext context, String language, Color color, String logMessage) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(language),
        onTap: () {
          print(logMessage); // Print which language was selected
          Navigator.pop(context); // Close the dialog
        },
      ),
    );
  }
}
