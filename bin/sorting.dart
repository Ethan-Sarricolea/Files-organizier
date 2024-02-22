/*
 * Description: files organizier init
*/

import 'dart:io';
import '../src/read_files.dart';

void main(List<String> args) {
  String pathDir = args[0];

  final paths = readFiles(pathDir);
  createFolders(pathDir);
  try {
    for (final path in paths) {
      moveFile(path, pathDir + Platform.pathSeparator + getNameFolder(path));
    }
  } catch (e) {}
}
