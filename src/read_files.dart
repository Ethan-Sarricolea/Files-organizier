/**
 * Descripcion:
 * Autor: @Ethan-Sarricolea
 */

import 'dart:io';

// Lista de archivos por organización
const extensionWord = [".doc", ".docx"];
const extensionPDF = [".pdf"];
const extensionExe = [".exe", ".bat"];
const extensionImages = [".jpeg", ".jpg", ".png", ".gif",".mp3",".wav",".mp4", ".ico"];
const extensionCompress = [".zip", ".rar", ".7zip", ".tar", ".tar.gz"];
const extensionExcel = [".xlsx",".csv"];
const extensionPresentations = [".pptx"];
const folders = <String>["Word","Multimedia","Compressed","Pdf",
                        "Executables","Excel","Presentations","Other"];

// Mapa de carpetas donde se organizaran los archivos
var extensionMap = {
  "Word":extensionWord,
  "Pdf": extensionPDF,
  "Executables": extensionExe,
  "Multimedia":extensionImages,
  "Compressed": extensionCompress,
  "Excel": extensionExcel,
  "Presentations": extensionPresentations
};

/**
 * Description: Este metodo lee los archivos en un directorio o subdirectorios
 *     Y los retorna como lista de Strings
 * @param pathDir - Ruta de directorio principal
 * @[bool recurive] - Recursividad en la lectura
 */

List<String> readFiles(String pathDir, [bool recursive = false]) {
  var paths = <String>[];
  var dir = Directory(pathDir);
  var files = dir.listSync(followLinks: false, recursive: recursive);

  for(final file in files){
    paths.add(file.path);
  }

 return paths;
}

/**
 *  Description: Se encarga de crear las carpetas segun
 *      Según la lista definida de carpetas (folder).
 *  Si alguna carpeta ya existe omite la creación.
 */

bool createFolders(String pathDir){
  for (final folder in folders){
    if (Directory("$pathDir${Platform.pathSeparator}$folder").existsSync()){
      continue;
    } else{
      Directory("$pathDir${Platform.pathSeparator}$folder").createSync();
    }
  }
    return true;
}

/**
 * Descripción: Mueve los archivos,
 *     cambiando su path original por el nuevo dentro de la carpeta
 */
  void moveFile(String pathBase, String pathNewDir) async{
    // print("$pathBase -> $pathNewDir${Platform.pathSeparator}$name_file");

    // Si path es un folder -> pass
    if (await FileSystemEntity.isDirectory(pathBase)){
      return;
    } else {
      String name_file = pathBase.split(Platform.pathSeparator).last;
      File(pathBase).rename("$pathNewDir${Platform.pathSeparator}$name_file");
    }
}

/**
 * Description: Obtiene la extensión y la compara con la lista de extensiones
 *     Si no se encuentra en la lista mete el archivo en la carpeta otros
 */

String getNameFolder(String path){
    String folder = "Other";
    String name_file = path.split(Platform.pathSeparator).last;

    for(final key in extensionMap.keys){
      var listExt = extensionMap[key];
      for(final ext in listExt!){
        if(name_file.endsWith(ext)){
          return key;
        }
      }
    }

    return folder;
}