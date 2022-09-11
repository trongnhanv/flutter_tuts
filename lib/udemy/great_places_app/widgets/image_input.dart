import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _file;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _file != null
              ? Image.file(
                  _file!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text('No Image taken!'),
          alignment: Alignment.center,
        ),
        TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return SizedBox(
                      height: 150,
                      child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton.icon(
                                onPressed: () async {
                                  Navigator.of(_).pop(false);
                                  var _file = ImagePicker()
                                    ..pickImage(source: ImageSource.gallery);
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Pick a image')),
                            TextButton.icon(
                                onPressed: () async {
                                  Navigator.of(_).pop(false);
                                  var _file = ImagePicker()
                                    ..pickImage(source: ImageSource.camera);
                                },
                                icon: const Icon(Icons.camera_alt),
                                label: const Text('Capture a photo'))
                          ]),
                    );
                  });
            },
            icon: const Icon(Icons.camera),
            label: const Text('Choose a Picture'))
      ],
    );
  }
}
