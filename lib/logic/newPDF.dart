import 'package:pdf/widgets.dart' as pw;
import 'package:camera/camera.dart';

int pageCount = 0;

Future<CameraDescription> getCamera() async {
  //WidgetsFlutterBinding.ensureInitialized();
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

//will be called when new image has to be clicked
void addPage(imagePath) {}

//will be called when image is confirmed
void pageAdded() {
  pageCount += 1;
}
