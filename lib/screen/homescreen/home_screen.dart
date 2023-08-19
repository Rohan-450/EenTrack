import 'package:flutter/material.dart';
import 'package:project_f/screen/homescreen/newmeeting_screen.dart';
import 'package:project_f/screen/homescreen/profile_screen.dart';
import 'package:project_f/screen/homescreen/scanner_screen.dart';

import '../authscreens/shared/custombuttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final List<String> _appBarTitles = [
    'Scanner',
    'Profile',
    'New Meeting',
  ];

  final List<Widget> _screens = [
    const ScannerScreen(),
    const ProfileScreen(),
    const NewMeetingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitles[_currentIndex],
          style: const TextStyle(),
        ),
        centerTitle: true, // No need of center widget
        leading: Image.asset(
          'assets/logo_rounded.png',
          width: 40,
          height: 40,
        ),
        actions: [
          CustomIconButton(
            onPressed: () {},
            icon: Icons.logout,
            iconColor: Colors.white,
          )
        ],
      ),
      // body: Navigator(
      //   initialRoute: '/',
      //   onGenerateRoute: (RouteSettings settings) {
      //     return MaterialPageRoute(
      //       builder: (BuildContext context) {
      //         return _screens[_currentIndex];
      //       },
      //     );
      //   },
      // ),
      body: Center(
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        useLegacyColorScheme: false,
        type: BottomNavigationBarType.shifting,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'Join Meeting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: 'Create Meeting',
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
