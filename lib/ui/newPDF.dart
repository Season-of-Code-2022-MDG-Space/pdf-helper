import 'package:flutter/material.dart';
//import 'package:path/path.dart' as Path;
import '../logic/newPDF.dart';
import '../logic/clickPic.dart' as c;
import './start.dart' as p;
import 'package:camera/camera.dart';

int pc = 0;
Future<void> main() async {
  //pc = pageCount;
  final firstCamera = await getCamera();
  runApp(MaterialApp(
    routes: {
      '/': (context) => const newPDFhome(),
      '/bak': (context) => const p.Buttons(),
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
  //int _pageCount = pageCount;

  _defineChildren() {
    if (pageCount == 0) {
      return [
        FloatingActionButton.extended(
            onPressed: () async {
              try {
                Navigator.pushNamed(context, '/cam');
              } catch (e) {
                //ignore:avoid_print
                print(e);
              }
            },
            tooltip: "Saved Suggestions",
            label: const Text('go to click pic screen'))
      ];
    } else {
      return [
        FloatingActionButton.extended(
            onPressed: () async {
              try {
                Navigator.pushNamed(context, '/cam');
              } catch (e) {
                //ignore:avoid_print
                print(e);
              }
            },
            tooltip: "Saved Suggestions",
            label: const Text('go to click pic screen')),
        FloatingActionButton.extended(
            onPressed: () async {
              await savePDF();
            },
            label: const Text('save'))
      ];
    }
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
                //Navigator.pushNamed(context, '/bak');
              },
              label: const Text('back')),
        ),
        body: Column(children: [
          Text('U hv clicked $pc pages'),
          Column(
            children: _defineChildren(),
          )
        ]));
  }
}
