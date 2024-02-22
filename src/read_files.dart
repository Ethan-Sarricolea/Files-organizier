import 'dart:io';

const extensionWord = [".doc", ".docx"];
const extensionPDF = [".pdf"];
const extensionExe = [".exe", ".bat"];
const extensionImages = [".jpeg", ".jpg", ".png", ".gif",".mp3",".wav",".mp4"];
const extensionCompress = [".zip", ".rar", ".7zip", ".tar", ".tar.gz"];
const extensionExcel = [".xlsx",".csv"];
const extensionPresentations = [".pptx"];
const folders = <String>["Word","Multimedia","Compressed","Pdf","Executables","Excel","Presentations","Other"];

var extensionMap = {
  "Word":extensionWord,
  "Pdf": extensionPDF,
  "Executables": extensionExe,
  "Multimedia":extensionImages,
  "Compressed": extensionCompress,
  "Excel": extensionExcel,
  "Presentations": extensionPresentations
};

// leer los archivos de una carpeta y/o subcarpetas

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
 *  Crea las carpetas según la lista de carpetas
 *  Si alguna carpeta ya existe omite la creación
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

// Mueve los archivos cambiando el path original por el de la nueva carpeta

bool moveFile(String pathBase, String pathNewDir){
    
    String name_file = pathBase.split(Platform.pathSeparator).last;

    print("$pathBase -> $pathNewDir${Platform.pathSeparator}$name_file");
    File(pathBase).rename("$pathNewDir${Platform.pathSeparator}$name_file");

    return true;
}

/**
 * Obtiene la extensión y la compara con la lista de extensiones
 * Si no se encuentra en la lista mete el archivo en la carpeta otros
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

/*
//  Test main

void main(List<String> args) {
  String pathDir = "C:\\Users\\usuario\\Documents\\prueba";
  final paths = readFiles(pathDir);
  createFolders(pathDir);

  for(final path in paths){
    moveFile(
      path, 
      pathDir+Platform.pathSeparator+ getNameFolder(path));
  }
}
*/