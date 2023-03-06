import 'dart:io';

import 'package:smith_cli/utils/utils.dart';

Future<void> generateDataRepository(String args) async {
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
      Future<List<Data>> get$className() async {
        final response = await _${varName}DataSource.get${className}s();

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
      Future<Data> get${className}By(String data) async {
        final response = await _${varName}DataSource.get${className}By(data);

        if (response.statusCode == 200) {
          final dataJson = response.body;
          return Data.fromJson(dataJson);
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
