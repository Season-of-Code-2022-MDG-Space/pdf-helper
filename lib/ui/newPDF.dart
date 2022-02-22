import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../logic/newPDF.dart';
import '../logic/clickPic.dart' as c;
import './start.dart' as p;
import 'package:camera/camera.dart';

Future<void> main() async {
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
  final int _pageCount = pageCount;

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
          Text('U hv clicked $_pageCount pages'),
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
        ]));
  }
}
