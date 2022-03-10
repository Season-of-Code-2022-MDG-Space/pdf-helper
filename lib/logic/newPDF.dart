import 'package:pdf/widgets.dart' as pw;
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:open_file/open_file.dart';

int pageCount = 0;
late pw.Document pdf1;
void start() {
  pageCount = 0;
  pdf1 = pw.Document();
}

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
    );
  }));
  pageCount++;
}

//to save pdf
Future<void> savePDF() async {
  //final pdffile = await pdf1.save();
  final dir = await getExternalStorageDirectory();
  final pdfPath = dir!.path + "/mypdf.pdf";
  File pdffile1 = File(pdfPath);
  final pdf_for_saving_purposes = pdf1;
  final pdfne = await pdf_for_saving_purposes.save();
  await pdffile1.writeAsBytes(pdfne);
  OpenFile.open(pdfPath);
}
