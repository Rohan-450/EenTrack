import 'package:eentrack/models/export_fields.dart';

import '../../models/model.dart';

abstract class ExportModel{
  Future<void> toExcel(String path, List<DataModel> data, List<ExportField> fields);
  Future<void> toPdf(String path, List<DataModel> data);
}
