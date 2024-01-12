import 'package:eentrack/models/user_model.dart';
import 'package:eentrack/screen/homescreen/details_qr_view.dart';
import 'package:eentrack/services/dbservice/db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authbloc/auth_events.dart';
import '../../bloc/authbloc/auth_bloc.dart';
import '../dialog/alart_dialog.dart';
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
      DetailsQrView(user: widget.user),
      ProfileView(
        user: widget.user,
      ),
      NewMeetingView(
        user: widget.user,
        dbprovider: widget.dbprovider,
      ),
    ];
    _appBarTitles = [
      'QR',
      'Profile',
      'Meetings',
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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png',
          ),
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
