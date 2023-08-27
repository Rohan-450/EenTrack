import 'package:eentrack/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authbloc/auth_events.dart';
import '../../bloc/authbloc/authbloc.dart';
import '../dialog/alart_dialog.dart';
import 'newmeeting_screen.dart';
import 'profile_screen.dart';
import 'scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  final String? error;
  final bool isLoading;
  const HomeScreen({
    Key? key,
    this.isLoading = false,
    this.error,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;

  late final List<String> _appBarTitles;
  late final List<Widget> _screens;

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

    _screens = [
      const ScannerScreen(),
      ProfileScreen(
        user: widget.user,
      ),
      NewMeetingScreen(),
    ];
    _appBarTitles = [
      'Scanner',
      'Profile',
      'New Meeting',
    ];
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
            onPressed: () {
              showAlartDialog('Logout', 'You sure want to logout?', context)
                  .then((value) {
                if (value == Option.ok) {
                  BlocProvider.of<AuthBloc>(context).add(AuthEventLogout());
                }
              });
            }, //_onLogout(context),
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
