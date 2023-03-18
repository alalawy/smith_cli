import 'dart:io';

import 'package:smith_cli/utils/utils.dart';

Future<void> generateDomainService(String args, String param) async {
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

      // delete this code if not use
      // BEGIN
      Future<List<Data>> get${className}s($param) async {
        return _${varName}UseCase.get${className}s(${removeDataTypesFromString(param)});
      }
      // END
      
      // delete this code if not use
      // BEGIN
      Future<BaseResponse<List<Data$className>>> get$className($param) async {
        return _${varName}UseCase.get$className(${removeDataTypesFromString(param)});
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
