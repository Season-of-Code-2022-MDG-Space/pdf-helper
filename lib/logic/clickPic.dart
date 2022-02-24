import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
//import 'package:path/path.dart' as Path;
import 'dart:io';
import './newPDF.dart' as n;
import '../ui/newPDF.dart' as p;
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;
import '../ui/start.dart' as s;
import 'dart:async';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(
//     MaterialApp(
//       routes: {
//         '/': (context) => TakePictureScreen(camera: firstCamera),
//         '/back': (context) => const p.newPDFhome()
//       },
//       initialRoute: '/',
//     ),
//   );
// }

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  //will show dialog box of confirmation
  _defineChildren() {
    if (n.pageCount == 0) {
      return [
        FloatingActionButton.extended(
          heroTag: "clickPicback",
          onPressed: () async {
            Navigator.of(context).pop();
          },
          label: const Text('Back'),
        ),
      ];
    } else {
      return [
        FloatingActionButton.extended(
          heroTag: "clickPicback",
          onPressed: () async {
            Navigator.of(context).pop();
          },
          label: const Text('Back'),
        ),
        FloatingActionButton.extended(
            onPressed: () async {
              n.savePDF();
            },
            label: const Text('Save'))
      ];
    }
  }

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture'),
        //leading: Row(children: _defineChildren())
      ),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;
            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final picture = await _controller.takePicture();
            // If the picture was taken, display it on a new screen.
            Navigator.of(context)
                .push(MaterialPageRoute<void>(builder: (context) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('View Picture'),
                  ),
                  body: SingleChildScrollView(
                      child: Stack(children: [
                    Image.file(File(picture.path)),
                    Row(
                      children: [
                        FloatingActionButton.extended(
                          heroTag: "viewPicback",
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          label: const Text('Discard Picture'),
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              await n.addPage(picture.path);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            label: const Text('add pic to pdf'))
                      ],
                    )
                  ])));
            }));
          } catch (e) {
            // If an error occurs, log the error to the console.
            // ignore: avoid_print
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}


/* commented out, may be of no use
// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  void addPage() {
    n.addPage(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
      //   floatingActionButton: FloatingActionButton.extended(
      //       onPressed: () async {
      //         final file = File("example.pdf");
      //         await file.writeAsBytes(await pdf.save());
      //         final pdfImage = pw.MemoryImage(
      //           File(imagePath).readAsBytesSync(),
      //         );
      //         addPage();
      //       },
      //       label: const Text('Confirm')),
    );
  }
}
*/