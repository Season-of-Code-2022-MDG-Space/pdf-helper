import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../logic/newPDF.dart' as nl;
import '../logic/clickPic.dart' as c;
import './start.dart' as p;
import 'dart:async';

late int _pc;
Future<CameraDescription> getCam() async {
  return await nl.getCamera();
}

Future<void> start() async {
  nl.start();
  final firstCamera = await nl.getCamera();
  runApp(MaterialApp(
    routes: {
      '/': (context) => const newPDFhome(),
      '/cam': (context) => c.TakePictureScreen(camera: firstCamera)
    },
    initialRoute: '/',
  ));
}

class newPDFhome extends StatefulWidget {
  const newPDFhome({Key? key}) : super(key: key);

  @override
  _newPDFhomeState createState() => _newPDFhomeState();
}

class _newPDFhomeState extends State<newPDFhome> {
  _defineChildren() {
    if (nl.pageCount == 0) {
      return [
        FloatingActionButton.extended(
            onPressed: () async {
              try {
                final _cam = await getCam();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => c.TakePictureScreen(
                              camera: _cam,
                            )),
                    (route) => false);
              } catch (e) {
                //ignore:avoid_print
                print(e);
              }
            },
            label: const Text('go to click pic screen'))
      ];
    } else {
      return [
        FloatingActionButton.extended(
            heroTag: null,
            onPressed: () async {
              try {
                final _cam = await getCam();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => c.TakePictureScreen(
                              camera: _cam,
                            )),
                    (route) => false);
              } catch (e) {
                //ignore:avoid_print
                print(e);
              }
            },
            label: const Text('go to click pic screen')),
        FloatingActionButton.extended(
            heroTag: null,
            onPressed: () async {
              await nl.savePDF();
            },
            label: const Text('save'))
      ];
    }
  }

  @override
  void initState() {
    _pc = nl.pageCount;
  }

  var childrenDefined;
  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
        appBar: AppBar(
          title: const Text('new PDF home page'),
          leading: FloatingActionButton.extended(
              heroTag: "newPDFback",
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const p.Buttons()),
                    (route) => false);
              },
              label: const Text('back')),
        ),
        body: Column(children: [
          Text('U hv clicked $_pc pages'),
          Column(
            children: childrenDefined = _defineChildren(),
          )
        ]));
  }
}
