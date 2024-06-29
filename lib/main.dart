import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _imageFile;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escáner y Compartir PDF'),
      ),
      body: Center(
        child: _imageFile == null
            ? Text('Presiona el botón para escanear una imagen')
            : Image.file(_imageFile!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanImage,
        tooltip: 'Escanear',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Future<void> _scanImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _createPDFAndShare();
    }
  }

  Future<void> _createPDFAndShare() async {
    if (_imageFile == null) return;

    final pdf = pw.Document();
    final image = pw.MemoryImage(File(_imageFile!.path).readAsBytesSync());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(image),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final filePath = '${output.path}/scanned_document.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    Share.shareFiles([filePath], text: 'Compartir PDF');
  }
}
