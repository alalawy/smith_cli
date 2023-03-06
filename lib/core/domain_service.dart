import 'dart:io';

import 'package:smith/utils/utils.dart';

Future<void> generateDomainService(String args) async {
  /// Definisikan nama file yang akan digenerate

  String underscore = toUnderscore(args);
  String directoryName = "lib/domain/$args/service/";
  await checkDirectoryAvailable(directoryName);
  String fileName = "$directoryName${args}_service.dart";
  String className = toCamelCase(underscore);
  String varName = toCamelCaseVar(underscore);

  /// Definisikan kode yang akan digenerate ke dalam file
  String code = '''
    import '../../../data/$underscore/model/${underscore}_model.dart';

    import '../usecase/${underscore}_usecase.dart';

    class ${className}Service {
      final ${className}UseCase _${varName}UseCase;

      ${className}Service(this._${varName}UseCase);

      Future<List<Data>> get${className}s() async {
        return _${varName}UseCase.get${className}s();
      }
    }


  ''';

  // Generate kode ke dalam file
  File file = File(fileName);
  file.writeAsString(code);

  // Tampilkan pesan sukses
  print("Code generated successfully in $fileName");
}
