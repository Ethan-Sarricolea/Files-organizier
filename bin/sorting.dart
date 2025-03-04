/*
 * Author: Ethan Yahel Sarricolea Cortés
 * Description: files organizier init
*/

import 'dart:io';
import '../src/read_files.dart';

void main(List<String> args) {
  // Recibir los argumentos de terminal / interfaz (Ruta de directorio padre a organizar)
  String pathDir = args[0];

  // Constante con la lista de rutas del directorio padre
  final paths = readFiles(pathDir);

  createFolders(pathDir);

  try {
    for (final path in paths) {
      moveFile(path, pathDir + Platform.pathSeparator + getNameFolder(path));
    }
  } catch (e) {}
}
