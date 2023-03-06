import 'dart:io';

import 'package:smith/utils/utils.dart';

Future<void> generateDomainRepositoryInterface(String args) async {
  /// Definisikan nama file yang akan digenerate

  String underscore = toUnderscore(args);
  String directoryName = "lib/domain/$args/repository/";
  await checkDirectoryAvailable(directoryName);
  String fileName = "$directoryName${args}_repository_interface.dart";
  String className = toCamelCase(underscore);

  /// Definisikan kode yang akan digenerate ke dalam file
  String code = '''
    import '../../../data/$underscore/model/${underscore}_model.dart';

    abstract class I${className}Repository {
      Future<List<Data>> get$className();
    }

  ''';

  // Generate kode ke dalam file
  File file = File(fileName);
  file.writeAsString(code);

  // Tampilkan pesan sukses
  print("Code generated successfully in $fileName");
}
