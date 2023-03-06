import 'package:smith_cli/smith_cli.dart' as smith_cli;

import 'dart:io';

void main(List<String> arguments) {
  // Cek apakah command yang dimasukkan adalah "smith -g all event"
  if (arguments.length >= 2 && arguments[0] == "smith") {
    // Panggil fungsi generateEventCode()
    if (arguments[1] == "-g" || arguments[1] == "generate") {
      if (arguments[2] == "all") {
        smith_cli.generateDataDataSource(arguments[3]);
        smith_cli.generateDataRepository(arguments[3]);
        smith_cli.generateDomainRepositoryInterface(arguments[3]);
        smith_cli.generateDomainService(arguments[3]);
        smith_cli.generateDomainUsecase(arguments[3]);
      }
    }
  } else {
    // Jika command yang dimasukkan salah, tampilkan pesan error
    print("Command not recognized. Usage: smith -g all event");
  }
}
