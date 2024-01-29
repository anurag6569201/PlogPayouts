import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LocationImage extends StatefulWidget {
  LocationImage(this.onPickedImage, {super.key});

  void Function(File? pickedImage) onPickedImage;

  @override
  State<LocationImage> createState() => _LocationImageState();
}

class _LocationImageState extends State<LocationImage> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);

      print(_pickedImageFile);
    });

    widget.onPickedImage(_pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
          radius: 40,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.image),
            label: const Text('Photo'))
      ],
    );
  }
}
