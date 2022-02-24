import 'dart:ui';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart' as pd;
import 'package:camera/camera.dart';
import 'dart:io';
import '../ui/newPDF.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:open_file/open_file.dart';
//import 'package:permission_handler/permission_handler.dart';

int pageCount = 0;
late pw.Document pdf1;
void start() {
  pageCount = 0;
  pdf1 = pw.Document();
}

//to create global variable of pdf document

//initialises the pdf file
// Future<void> main() async {
// }

//will get camera and return to frontend
Future<CameraDescription> getCamera() async {
  try {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    return firstCamera;
  } catch (e) {
    //ignore: avoid_print
    print(e);
    throw Exception();
  }
}

//will be called when clicked image has to be added to pdf
Future<void> addPage(imagePath) async {
  final image = pw.MemoryImage(
    File(imagePath).readAsBytesSync(),
  );

  pdf1.addPage(pw.Page(build: (pw.Context context) {
    return pw.Expanded(
      child: pw.Image(image),
    ); // Center
  })); // Page
  await pdf1.document.save();
  pageCount++;
  update();
}

/*
//will ask for permission to store files on device
Future<bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}
*/
//to save pdf
Future<void> savePDF() async {
  //final pdffile = await pdf1.save();
  final dir = await getExternalStorageDirectory();
  final pdfPath = dir!.path + "/mypdf.pdf";
  File pdffile1 = File(pdfPath);
  await pdffile1.writeAsBytes(await pdf1.save());
  OpenFile.open(pdfPath);

  //if (!await pdffile.exists()) {
  //  pdffile.create(recursive: true);
  //}

  //maybe not neaded
  // Directory? directory;
  // if (Platform.isAndroid) {
  //   if (await _requestPermission(Permission.storage)) {
  //     directory = await getExternalStorageDirectory();
  //     String newPath = "";
  //     List<String>? paths = directory!.path.split("/");
  //     for (int x = 1; x < paths.length; x++) {
  //       String folder = paths[x];
  //       if (folder != "Android") {
  //         newPath += "/" + folder;
  //       } else {
  //         break;
  //       }
  //     }
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //     if (await directory.exists()) {
  //       await dio;
  //     }
  //   }
  // }

  //old

  // final directory = await getApplicationDocumentsDirectory();
  // var name = DateTime.now();
  // final pdf1 = File('$directory/mypdf.pdf');
}
