import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class AddPictureWidget extends StatefulWidget {
  const AddPictureWidget({Key? key}) : super(key: key);

  @override
  State<AddPictureWidget> createState() => _AddPictureWidgetState();
}

class _AddPictureWidgetState extends State<AddPictureWidget> {
  late File? _storedImage = null;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
  }

  Future<void> _pickPictureFromGallery() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_storedImage != null)
          Container(
            width: double.infinity,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _storedImage!,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        if (_storedImage == null)
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("請拍張當下美麗的天氣"), Icon(Icons.photo)],
                ),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: _pickPictureFromGallery,
                icon: Icon(Icons.image_search_rounded),
                label: Text("選張照片")),
            TextButton.icon(
                onPressed: _takePicture,
                icon: Icon(Icons.camera_alt_outlined),
                label: Text("為天空拍張照")),
          ],
        )
      ],
    );
  }
}
