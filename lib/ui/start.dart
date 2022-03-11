import 'package:flutter/material.dart';
import 'new_pdf.dart' as n;
import '../logic/new_pdf.dart' as nl;

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
        '/newPDF': (context) => const n.NewPDFHome()
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
                      builder: (BuildContext context) => const n.NewPDFHome()),
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
