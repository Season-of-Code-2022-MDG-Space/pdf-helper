import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../logic/newPDF.dart';

class newPDFhome extends StatefulWidget {
  const newPDFhome({Key? key}) : super(key: key);

  @override
  _newPDFhomeState createState() => _newPDFhomeState();
}

class _newPDFhomeState extends State<newPDFhome> {
  final int _pageCount = pageCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('new PDF home page'), actions: [
          IconButton(
            onPressed: () async {
              try {
                Navigator.of(context)
                    .push(MaterialPageRoute<void>(builder: (context) {
                  TakePicture;
                  throw Error();
                }));
              } catch (e) {
                //ignore:avoid_print
                print(e);
              }
            },
            icon: const Icon(Icons.list),
            tooltip: "Saved Suggestions",
          )
        ]),
        body: Column(children: [Text('U hv clicked $_pageCount pages')]));
  }
}

class TakePicture extends StatefulWidget {
  const TakePicture({Key? key}) : super(key: key);

  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
