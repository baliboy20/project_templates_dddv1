import 'dart:io';

void listFilesAndFolders(String directoryPath) {
  final directory = Directory(directoryPath);

  if (!directory.existsSync()) {
    print('Directory does not exist: $directoryPath');
    return;
  }

  directory.list(recursive: true).forEach((entity) {
    if (entity is File) {
      print('File: ${entity.path}');
    } else if (entity is Directory) {
      print('Folder: ${entity.path}');
    }
  });
}

void main() {
  listFilesAndFolders('./lib');
}