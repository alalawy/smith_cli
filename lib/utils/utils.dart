import 'dart:io';

String toUnderscore(String camelCaseString) {
  /// Membuat pattern regex untuk menemukan huruf besar dalam string
  RegExp uppercaseRegex = RegExp(r'[A-Z]');

  /// Mengganti huruf besar dengan "_[huruf_kecil]"
  String underscoreString =
      camelCaseString.replaceAllMapped(uppercaseRegex, (match) {
    return "_${match.group(0)!.toLowerCase()}";
  });

  /// Mengembalikan string dengan huruf kecil semua
  return underscoreString.toLowerCase();
}

Future<void> checkDirectoryAvailable(String directoryName) async {
  if (Directory(directoryName).existsSync()) {
    print("Directory already exists, Continue create file");
  } else {
    /// Membuat direktori jika belum ada
    Directory(directoryName).createSync(recursive: true);
    print("Directory created successfully.");
  }
}

String toCamelCase(String underscoreString) {
  /// Membuat array dari string yang dipisahkan dengan "_"
  List<String> parts = underscoreString.split("_");

  /// Menggabungkan setiap elemen array kecuali yang pertama
  /// dengan membuatnya menjadi huruf besar di awal dan menggabungkan dengan sisa string
  String camelCaseString = parts.map((part) {
    return part[0].toUpperCase() + part.substring(1);
  }).join();

  return camelCaseString;
}

String toCamelCaseVar(String underscoreString) {
  // Membuat array dari string yang dipisahkan dengan "_"
  List<String> parts = underscoreString.split("_");

  // Menggabungkan setiap elemen array kecuali yang pertama
  // dengan membuatnya menjadi huruf besar di awal dan menggabungkan dengan sisa string
  String camelCaseString = parts.first +
      parts.sublist(1).map((part) {
        return part[0].toUpperCase() + part.substring(1);
      }).join();

  return camelCaseString;
}

String removeDataTypesFromString(String inputString) {
  // Regex pattern to match data types
  RegExp dataTypePattern = RegExp(
      '\\b(bool|int|double|num|String|dynamic|List|List<dynamic>|Map<String, dynamic>)\\b');

  // Replace data type matches with an empty string
  String outputString = inputString.replaceAll(dataTypePattern, '');

  return outputString.trim(); // Remove leading/trailing white space
}
