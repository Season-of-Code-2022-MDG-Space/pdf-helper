import 'package:pdf/widgets.dart' as pw;
import 'package:camera/camera.dart';
import 'dart:io';

int pageCount = 0;
void main() {
  pageCount = 0;
}

//to create global variable of pdf document
late pw.Document pdf = pw.Document();

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

  pdf.addPage(pw.Page(build: (pw.Context context) {
    return pw.Center(
      child: pw.Image(image),
    ); // Center
  })); // Page

  pageCount++;
}

//to save pdf
Future<void> savePDF() async {
  var name = DateTime.now();
  final file = File(name.toString());
}

//will be called when image is confirmed
void pageAdded() {
  pageCount += 1;
}
