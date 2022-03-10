import 'package:flutter/material.dart';
import './newPDF.dart' as n;
import '../logic/newPDF.dart' as nl;

class Startup extends StatelessWidget {
  const Startup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    nl.start();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDF Helper',
      routes: {
        '/': (context) => const Buttons(),
        '/newPDF': (context) => const n.newPDFhome()
      },
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            heroTag: "newPDF",
            onPressed: () async {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const n.newPDFhome()),
                  (route) => false);
              //Navigator.pushNamed(context, '/newPDF');
            },
            label: const Text('New Pdf'),
          ),
        ],
      ),
    );
  }
}
