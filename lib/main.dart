import 'package:flutter/material.dart';
import 'package:school_app/donors/donor_create.dart';
import 'package:school_app/donors/donor_edit.dart';
import 'package:school_app/donors/donor_list.dart';
import 'package:school_app/widgets/about.dart';
import 'package:school_app/widgets/home_page.dart';
import 'package:school_app/widgets/setting_page.dart';
// import 'package:school_app/donors/donor_edit.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/changepassword_screen.dart';
import 'screens/forget.dart';
import 'package:school_app/admin/display.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:school_app/admin/admin_screen.dart';
import 'package:school_app/students/students_list.dart';
import 'package:school_app/supervisor/supervisor_list.dart';
import 'package:school_app/admin/admin_dashboard.dart';
// import 'package:school_app/donors/donor_edit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login & Register App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ToggleScreen(),
      initialRoute: '/login',
      routes: {
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/display': (context) => DisplayScreen(),
        '/admin': (context) => AdminScreen(),
        '/donorlist': (context) => DonorList(),
        '/student': (context) => StudentsList(),
        '/supervisor': (context) => SupervisorList(),
        '/admindashboard': (context) => AdminDashboard(),
        '/createdonor': (context) => CreateDonor(),
        '/editdonor': (context) => EditDonor(),
        '/about': (context) => About(),
        '/home': (context) => HomePage(),

        '/setting': (context) => SettingPage(),
        // '/forget': (context) => ForgetScreen(),
        '/changepassword': (context) => ChangePasswordScreen(),
        // '/reset': (context) => ResetScreen(),
        // '/update': (context) => UpdateScreen(),
        '/forgot': (context) => ForgotScreen(),
        // '/codepage': (context) => CodePageSceeen(),
        // '/toggle': (context) => ToggleScreen(),
      },
    );
  }
}
