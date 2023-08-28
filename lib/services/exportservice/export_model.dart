import '../../models/model.dart';

abstract class ExportModel{
  Future<void> toExcel(String path, List<DataModel> data);
  Future<void> toPdf(String path, List<DataModel> data);
}
