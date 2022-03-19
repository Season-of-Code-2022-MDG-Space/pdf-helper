import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'new_pdf.dart' as n;
import '../ui/new_pdf.dart' as p;
import 'dart:async';
import '../ui/divider.dart';

late XFile picture;
late String pp;
int dividers = 0;
List<Widget> arr = [];

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
  _initArr() {
    arr.addAll([
      Container(
        child: Image.file(File(picture.path)),
      ),
      Row(
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              arr.add(StatefulDragArea(child: Image.asset('divider.png')));
            },
            label: const Text('+'),
          ),
          FloatingActionButton.extended(
            heroTag: "viewPicback",
            onPressed: () async {
              Navigator.of(context).pop();
              p.start();
            },
            label: const Text('D'),
          ),
          FloatingActionButton.extended(
              heroTag: 'add pic as page to pdf',
              onPressed: () async {
                await n.addPage(pp);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const p.NewPDFHome()),
                    (route) => false);
              },
              label: const Text('a')),
        ],
      ),
    ]);
  }

  @override
  void initState() {
    dividers = 0;
    super.initState();
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // initialize the controller. This returns a Future.
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
    //_initArr();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture'),
      ),
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
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;
            //_initArr();
            // Attempt to take a picture and get the file `image`
            // where it was saved.
            picture = await _controller.takePicture();
            pp = picture.path;
            _initArr();
            // If the picture was taken, display it on a new screen.
            Navigator.of(context)
                .push(MaterialPageRoute<void>(builder: (context) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('View Picture'),
                  ),
                  body: Stack(
                    children: arr,
                  )

                  //SingleChildScrollView(
                  //child: Stack(children: _screenChildren()))
                  );
            }));
          } catch (e) {
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
