// import 'dart:io';

import 'package:smith_cli/utils/utils.dart';

Future<void> generateModel(String args, String param) async {
  /// Definisikan nama file yang akan digenerate

  String underscore = toUnderscore(args);
  String directoryName = "lib/data/$args/model/";
  await checkDirectoryAvailable(directoryName);
}
