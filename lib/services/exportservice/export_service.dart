import 'dart:core';
import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:eentrack/services/exportservice/export_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/model.dart';

class ExportService implements ExportModel {
  @override
  Future<void> toExcel(String filename, List<DataModel> data) async {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];
    if (data.isNotEmpty) {
      var d = data[0].toMap();
      sheet.appendRow(d.keys.toList());
      for (var d in data) {
        var map = d.toMap();
        sheet.appendRow(map.values.toList());
      }
    }

    var status = await Permission.storage.status;
    if (status == PermissionStatus.denied) {
      status = await Permission.storage.request();
    }

    if (status == PermissionStatus.denied) {
      throw ExportError('Permission denied');
    }

    var fileBytes = excel.save();
    var directory = await getTemporaryDirectory();
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    debugPrint(directory.path);
    var file = File('${directory.path}/$filename.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    var xf = XFile(file.path);
    await Share.shareXFiles([xf]);
  }

  @override
  Future<void> toPdf(String path, List<DataModel> data) async {
    // TODO: implement toPdf
    throw UnimplementedError();
  }
}

class ExportError implements Exception {
  final String message;
  ExportError(this.message);
}
