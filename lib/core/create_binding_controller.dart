import 'dart:io';

import 'package:smith_cli/utils/utils.dart';

Future<void> generateBinding(String args, String param) async {
  /// Definisikan nama file yang akan digenerate

  String underscore = toUnderscore(args);
  String directoryName = "lib/infrastructure/navigation/bindings/controllers/";
  await checkDirectoryAvailable(directoryName);
  String fileName = "$directoryName$args.controller.binding.dart";
  String className = toCamelCase(underscore);
  String varName = toCamelCaseVar(underscore);

  // Read file contents into a list of strings
  List<String> lines = File(fileName).readAsLinesSync();

  /// Definisikan kode yang akan digenerate ke dalam file
  String importCode = '''
    import '../../../../data/$underscore/datasource/${underscore}_datasource.dart';
    import '../../../../data/$underscore/repository/${underscore}_repository.dart';
    import '../../../../domain/$underscore/service/${underscore}_service.dart';
    import '../../../../domain/$underscore/usecase/${underscore}_usecase.dart';
  ''';

  String codeBinding = '''
    Get.put(${className}DataSource());
    var ${varName}Repository = ${className}Repository();
    var ${varName}UseCase = ${className}UseCase(${varName}Repository);
    var ${varName}Service = ${className}Service(${varName}UseCase);
''';

  // Insert new string at the desired line number
  lines.insert(2, importCode);
  lines.insert(lines.length - 5, codeBinding);

  // Generate kode ke dalam file
  File file = File(fileName);
  file.writeAsStringSync(lines.join('\n'));

  String fileContents = File(fileName).readAsStringSync();

  // Find the line containing "StokController("
  int startIndex = fileContents.indexOf("${className}Controller(");
  int endIndex = fileContents.indexOf(")", startIndex);

  // Insert code before the closing bracket
  String updatedContents =
      fileContents.replaceRange(endIndex, endIndex, '${varName}Service');

  // Write updated string back to file
  File(fileName).writeAsStringSync(updatedContents);

  // Tampilkan pesan sukses
  print("Code generated successfully in $fileName");
}
