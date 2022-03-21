import 'package:pdf/widgets.dart' as pw;
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:open_file/open_file.dart';
import './click_pic.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

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
    return pw.Flexible(
      child: pw.Image(image),
      fit: pw.FlexFit.tight,
    );
  }));
  pageCount++;
  dividers = 0;
}

//to save pdf
Future<void> savePDF() async {
  //final pdffile = await pdf1.save();
  final dir = await getExternalStorageDirectory();
  final pdfPath = dir!.path + "/mypdf.pdf";
  File pdffile1 = File(pdfPath);
  final pdfForSaving = pdf1;
  final pdfne = await pdfForSaving.save();
  await pdffile1.writeAsBytes(pdfne);
  OpenFile.open(pdfPath);
}

//to divide page as per dividers
Future<void> dividePage(imagePath, arr) async {
  //arr - contains all dividers and some extra things
  final int noOfImages = arr.length - 1;

  ImageProperties properties =
      await FlutterNativeImage.getImageProperties(imagePath);
  final int width = properties.width as int;
  await addPage(
      (await FlutterNativeImage.cropImage(imagePath, 0, 0, width, arr[2].top))
          .path);
  for (var i = 1; i <= noOfImages - 2; i++) {
    await addPage((await FlutterNativeImage.cropImage(imagePath, 0,
            arr[1 + i].top, width, arr[i + 2].top - arr[i + 1].top))
        .path);
  }
  await addPage((await FlutterNativeImage.cropImage(
          imagePath,
          0,
          arr[arr.length - 1].top,
          width,
          (properties.height! - arr[arr.length - 1].top) as int))
      .path);
}
