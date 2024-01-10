import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/models/user_model.dart';
import 'package:eentrack/screen/dialog/alart_dialog.dart';
import 'package:eentrack/screen/dialog/scanner_dialog.dart';
import 'package:eentrack/screen/shared/show_snackbar.dart';
import 'package:eentrack/services/dbservice/db_model.dart';
import 'package:eentrack/services/qr_service/qr_parser.dart';
import 'package:flutter/material.dart';

class CoHostManager extends StatefulWidget {
  final Meeting meeting;
  final DBModel db;
  const CoHostManager({
    super.key,
    required this.meeting,
    required this.db,
  });

  @override
  State<CoHostManager> createState() => _CoHostManagerState();
}

class _CoHostManagerState extends State<CoHostManager> {
  late Future<List<User>> _coHostsFuture;
  List<User> coHosts = [];

  void _addCoHost() async {
    var rawData =
        await showScannerDialog(context: context, title: 'Add Co-Host');
    if (rawData == null) return;
    var coHostId = QrParser.parseHost(rawData);
    if (widget.meeting.coHosts.contains(coHostId)) {
      return;
    }
    var user = await widget.db.getUser(coHostId);
    if (user == null) {
      return;
    }
    widget.meeting.coHosts.add(coHostId);
    await widget.db.updateMeeting(widget.meeting.hostid, widget.meeting);
    setState(() {
      coHosts.add(user);
    });
  }

  void _deleteCoHost(User coHost) async {
    var result = await showAlartDialog(
        'Delete Co-Host', 'You sure want to delete co-host?', context);
    if (result != Option.ok) return;
    widget.meeting.coHosts.remove(coHost.uid);
    await widget.db.updateMeeting(widget.meeting.hostid, widget.meeting);
    setState(() {
      coHosts.remove(coHost);
    });
  }

  @override
  void initState() {
    super.initState();
    _coHostsFuture = widget.db.getUsers(widget.meeting.coHosts);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _coHostsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        coHosts = snapshot.data!;
        return ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Add Co-Host'),
              onTap: _addCoHost,
            ),
            const Divider(),
            ...coHosts.map((e) => CoHostTile(
                  coHost: e,
                  onDelete: _deleteCoHost,
                )),
          ],
        );
      },
    );
  }
}

class CoHostTile extends StatelessWidget {
  final User coHost;
  final Function(User) onDelete;
  const CoHostTile({
    super.key,
    required this.coHost,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(coHost.name),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onDelete(coHost),
      ),
    );
  }
}
