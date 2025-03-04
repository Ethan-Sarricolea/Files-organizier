/**
 * Description: Code tester
 * Author: @Ethan-Sarricolea
 */

import 'read_files.dart';
import 'dart:io';

//  Test main

void main(List<String> args) {
  String pathDir = "C:\\Users\\usuario\\Documents\\prueba"; // Should be replaced
  final paths = readFiles(pathDir);
  createFolders(pathDir);

  for(final path in paths){
    moveFile(
      path, 
      pathDir+Platform.pathSeparator+ getNameFolder(path));
  }
}