import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import 'model/user_mdel.dart';

class ImageUploadPage extends StatefulWidget {
  final User userDetails;

  const ImageUploadPage({super.key, required this.userDetails});

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      print('Please select an image to upload.');
      return;
    }

    const url = 'https://flutter.magadh.co/1689598933233-carbon (22).png';

    // Create a MultipartRequest and attach the image file
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      http.MultipartFile(
        'image',
        _imageFile!.readAsBytes().asStream(),
        _imageFile!.lengthSync(),
        filename: 'user_image.jpg',
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully.');
    } else {
      print('Image upload failed. Status Code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                height: 200,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: const Text('Take Photo'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: const Text('Choose from Gallery'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
