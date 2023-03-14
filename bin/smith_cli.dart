import 'package:smith_cli/smith_cli.dart' as smith_cli;

void main(List<String> arguments) {
  // Cek apakah command yang dimasukkan adalah "smith -g all"
  // Panggil fungsi generateEventCode()
  if (arguments[0] == "-g" || arguments[0] == "generate") {
    if (arguments[1] == "all") {
      smith_cli.generateDataDataSource(arguments[2]);
      smith_cli.generateDataRepository(arguments[2]);
      smith_cli.generateDomainRepositoryInterface(arguments[2]);
      smith_cli.generateDomainService(arguments[2]);
      smith_cli.generateDomainUsecase(arguments[2]);
    }
  } else {
    // Jika command yang dimasukkan salah, tampilkan pesan error
    print("Command not recognized. Usage: smith -g all [className]");
  }
}
