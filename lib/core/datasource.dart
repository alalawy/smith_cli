import 'dart:io';

import 'package:smith_cli/utils/utils.dart';

Future<void> generateDataDataSource(String args, String param) async {
  /// Definisikan nama file yang akan digenerate

  String underscore = toUnderscore(args);
  String directoryName = "lib/data/$args/datasource/";
  await checkDirectoryAvailable(directoryName);
  String fileName = "$directoryName${args}_datasource.dart";
  String className = toCamelCase(underscore);

  /// Definisikan kode yang akan digenerate ke dalam file
  String code = '''
    import 'package:get/get.dart';
    import 'package:get_storage/get_storage.dart';
    import '../../../config.dart';

    class ${className}DataSource extends GetConnect {
      final box = GetStorage();
      Future<Response> get$className($param) {
        var env = ConfigEnvironments.getEnvironments();
        return get('\${env['url']}/',
            headers: {"Authorization": 'Bearer \${box.read('jwt')}'});
      }
    }

  ''';

  // Generate kode ke dalam file
  File file = File(fileName);
  file.writeAsString(code);

  // Tampilkan pesan sukses
  print("Code generated successfully in $fileName");
}
