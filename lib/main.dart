import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ImgPicker(),
    );
  }
}

class ImgPicker extends StatefulWidget {
  const ImgPicker({super.key});

  @override
  _ImgPickerState createState() => _ImgPickerState();
}

class _ImgPickerState extends State<ImgPicker> {
  final ImagePicker _picker = ImagePicker();
  File? _img;

  Future<void> _pickImg() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _img = File(picked.path);
      });
    }
  }

  Future<void> _takePic() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _img = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Package: image_picker',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Description: Select image or take a photo.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: _img != null
                  ? Image.file(
                _img!,
                height: 300,
              )
                  : const Text(
                'No image selected.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _pickImg,
                  child: const Text('Pick Image'),
                ),
                ElevatedButton(
                  onPressed: _takePic,
                  child: const Text('Take Photo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
