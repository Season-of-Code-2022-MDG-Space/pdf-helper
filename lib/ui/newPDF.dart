import 'package:flutter/material.dart';
//import 'package:path/path.dart' as Path;
import '../logic/newPDF.dart' as nl;
import '../logic/clickPic.dart' as c;
import './start.dart' as p;
//import 'package:camera/camera.dart';
import 'dart:async';

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

void update() {
  _newPDFhomeState().updatePc();
}

class newPDFhome extends StatefulWidget {
  const newPDFhome({Key? key}) : super(key: key);

  @override
  _newPDFhomeState createState() => _newPDFhomeState();
}

class _newPDFhomeState extends State<newPDFhome> {
  //int _pageCount = pageCount;
  int _pc = nl.pageCount;

  void updatePc() {
    setState(() {
      _pc++;
    });
  }

  _defineChildren() {
    // if (pageCount == 0) {
    //   return [
    //     FloatingActionButton.extended(
    //         onPressed: () async {
    //           try {
    //             Navigator.pushNamed(context, '/cam');
    //           } catch (e) {
    //             //ignore:avoid_print
    //             print(e);
    //           }
    //         },
    //         label: const Text('go to click pic screen'))
    //   ];
    // } //else {
    return [
      FloatingActionButton.extended(
          heroTag: null,
          onPressed: () async {
            try {
              Navigator.pushNamed(context, '/cam');
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
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('new PDF home page'),
          leading: FloatingActionButton.extended(
              heroTag: "newPDFback",
              onPressed: () async {
                Navigator.of(context).pop();
                p.main();
              },
              label: const Text('back')),
        ),
        body: Column(children: [
          Text('U hv clicked $_pc pages'),
          Column(
            children: _defineChildren(),
          )
        ]));
  }
}
