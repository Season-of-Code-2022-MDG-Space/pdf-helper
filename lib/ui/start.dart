import 'package:flutter/material.dart';
import './newPDF.dart';

void main() {
  runApp(const Startup());
}

class Startup extends StatelessWidget {
  const Startup({Key? key}) : super(key: key);

  _newPDF() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDF Helper',
      initialRoute: '/',
      routes: {
        '/': (context) => const Buttons(),
        '/newPDF': (context) => const newPDFhome()
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
            onPressed: () async {
              Navigator.pushNamed(context, '/newPDF');
            },
            label: const Text('New Pdf'),
          ),
          /*button to edit existing pdf
          FloatingActionButton.extended(
              onPressed: () async {
                Navigator.pushNamed(context, '/editOld');
              },
              label: const Text('Edit Existing PDF'))
              */
        ],
      ),
    );
  }
}
