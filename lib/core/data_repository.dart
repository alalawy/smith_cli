import 'dart:io';

import 'package:smith_cli/utils/utils.dart';

Future<void> generateDataRepository(String args, String param) async {
  /// Definisikan nama file yang akan digenerate

  String underscore = toUnderscore(args);
  String directoryName = "lib/data/$args/repository/";
  await checkDirectoryAvailable(directoryName);
  String fileName = "$directoryName${args}_repository.dart";
  String className = toCamelCase(underscore);
  String varName = toCamelCaseVar(underscore);

  /// Definisikan kode yang akan digenerate ke dalam file
  String code = '''
    import 'package:get/get.dart';

    import '../datasource/${underscore}_datasource.dart';
    import '../model/${underscore}_model.dart';
    import '../../../domain/$underscore/repository/${underscore}_repository_interface.dart';

    class ${className}Repository implements I${className}Repository {
      final ${className}DataSource _${varName}DataSource = Get.find<${className}DataSource>();

      // comment this code if your response data is single
      // BEGIN
      @override
      Future<List<Data>> get$className($param) async {
        final response = await _${varName}DataSource.get${className}s($param);

        if (response.statusCode == 200) {
          final List<dynamic> ${varName}sJson = response.body['data'];
          return ${varName}sJson.map((json) {
            return Data.fromJson(json);
          }).toList();
        } else {
          throw Exception('Failed to load ${varName}s');
        }
      }
      // END

      // =================================================================

      // comment this code if your response data is Multiple
      // BEGIN
      @override
      Future<Data> get${className}By($param) async {
        final response = await _${varName}DataSource.get${className}By($param);

        if (response.statusCode == 200) {
          final dataJson = response.body;
          return Data.fromJson(dataJson);
        } else {
          throw Exception('Failed to load $varName');
        }
      }
      // END

      // BEGIN
      @override
      Future<BaseResponse<List<Data$className>>> get$className($param) async {
        final response = await _${varName}DataSource.get$className($param);

        if (response.statusCode == 200) {
          final dataJson = response.body;
          return BaseResponse<List<Data$className>>.fromJson(
              dataJson,
              (jsonData) =>
                  (jsonData as List).map((e) => Data$className.fromJson(e)).toList());
        } else {
          throw Exception('Failed to load $varName');
        }
      }
      // END

    }
  ''';

  // Generate kode ke dalam file
  File file = File(fileName);
  file.writeAsString(code);

  // Tampilkan pesan sukses
  print("Code generated successfully in $fileName");
}
