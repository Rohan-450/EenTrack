import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_f/bloc/authbloc/auth_events.dart';
import 'package:project_f/bloc/authbloc/authbloc.dart';
import 'package:project_f/screen/homescreen/newmeeting_screen.dart';
import 'package:project_f/screen/homescreen/profile_screen.dart';
import 'package:project_f/screen/homescreen/scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? error;
  final bool isLoading;
  const HomeScreen({
    Key? key,
    this.isLoading = false,
    this.error,
    required String name,
    required String department,
    required String rollNo,
    required String semester,
    required String github,
    required String linkedin,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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
    const ProfileScreen(
      department: '',
      github: '',
      linkedin: '',
      rollNo: '',
      name: '',
      semester: '',
    ),
    NewMeetingScreen()
  ];

  Future<void> showAllertDialogBox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Are you sure to log out',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  _onLogout(context);
                },
                child: const Text('Logout'),
              ),
            ],
          );
        });
  }

  void _onLogout(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(AuthEventLogout());
  }

  @override
  void initState() {
    super.initState();
    if (widget.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.error!),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          _appBarTitles[_currentIndex],
          style: const TextStyle(),
        ),
        centerTitle: true, // No need of center widget
        leading: Image.asset(
          'assets/logo.png',
        ),
        actions: [
          IconButton(
            onPressed: () => showAllertDialogBox(context), //_onLogout(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
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
