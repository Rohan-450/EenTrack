import 'package:eentrack/models/user_model.dart';
import 'package:eentrack/screen/dialog/user_settings_dialog.dart';
import 'package:eentrack/screen/homescreen/details_qr_view.dart';
import 'package:eentrack/services/dbservice/db_model.dart';
import 'package:flutter/material.dart';

import 'new_meeting_view.dart';
import 'profile_view.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  final DBModel dbprovider;
  final String? error;
  final bool isLoading;
  const HomeScreen({
    Key? key,
    this.isLoading = false,
    this.error,
    required this.user,
    required this.dbprovider,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;

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
      DetailsQrView(user: widget.user),
      ProfileView(
        user: widget.user,
      ),
      NewMeetingView(
        user: widget.user,
        dbprovider: widget.dbprovider,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('EenTrack'),
        actions: [
          IconButton(
            onPressed: () {
              showUserProfileDialog(context, widget.user);
            }, //_onLogout(context),
            icon: Image.asset('assets/logo.png'),
          )
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentIndex,
        useLegacyColorScheme: false,
        type: BottomNavigationBarType.shifting,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: 'Meetings',
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
