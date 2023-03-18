import 'dart:io';

import 'package:smith_cli/utils/utils.dart';

Future<void> generateDomainUsecase(String args, String param) async {
  /// Definisikan nama file yang akan digenerate

  String underscore = toUnderscore(args);
  String directoryName = "lib/domain/$args/usecase/";
  await checkDirectoryAvailable(directoryName);
  String fileName = "$directoryName${args}_usecase.dart";
  String className = toCamelCase(underscore);
  String varName = toCamelCaseVar(underscore);

  /// Definisikan kode yang akan digenerate ke dalam file
  String code = '''
    import '../../../data/$underscore/model/${underscore}_model.dart';
    import '../repository/${underscore}_repository_interface.dart';

    class ${className}UseCase {
      final I${className}Repository _${varName}Repository;

      ${className}UseCase(this._${varName}Repository);

      Future<List<Data>> get${className}s($param) async {
        final ${varName}s = await _${varName}Repository.get$className($param);
        return ${varName}s.map(($varName) => $varName).toList();
      }

      Future<BaseResponse<List<Data$className>>> get$className($param) async {
        final $varName = await _${varName}Repository.get$className($param);
        return $varName;
      }
    }

  ''';

  // Generate kode ke dalam file
  File file = File(fileName);
  file.writeAsString(code);

  // Tampilkan pesan sukses
  print("Code generated successfully in $fileName");
}
