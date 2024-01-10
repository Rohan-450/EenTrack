import 'package:eentrack/models/export_fields.dart';

abstract class DataModel {
  Map<String, dynamic> toMap();
  Map<String, dynamic> exportData({List<ExportField> fields = const []});
}
