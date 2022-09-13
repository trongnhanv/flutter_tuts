import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systemPath;

class ImageInput extends StatefulWidget {
  final void Function(File image) onSelectImage;
  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final ImagePicker _picker = ImagePicker();
  File? _file;

  Future<void> _copyFile(File file) {
    return systemPath.getApplicationDocumentsDirectory().then((value) {
      var filename = path.basename(file.path);
      file.copy('${value.path}/$filename');
    });
  }

  void _handleSelectImage(XFile? value) {
    if (value == null) {
      return;
    }
    File converFile = File(value.path);
    setState(() {
      _file = converFile;
    });
    widget.onSelectImage(converFile);
  }

  Future<void> _handleCamera() {
    return _picker
        .pickImage(source: ImageSource.camera, maxWidth: 600)
        .then((value) {
      _handleSelectImage(value);
    });
  }

  Future<void> _handleGallery() {
    return _picker
        .pickImage(source: ImageSource.gallery, maxWidth: 600)
        .then((value) {
      print(value);
      _handleSelectImage(value);
    });
  }

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
                                  _handleGallery();
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Pick a image')),
                            TextButton.icon(
                                onPressed: () {
                                  Navigator.of(_).pop(false);
                                  _handleCamera();
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
