import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? pickedImage;

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    imagePicker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        setState(() {
          pickedImage = File(value.path);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        pickedImage != null
            ? CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: FileImage(pickedImage!),
              )
            : CircleAvatar(
                child: Text('I'),
              ),
        TextButton.icon(
          onPressed: () {
            pickImage();
          },
          icon: const Icon(Icons.camera_alt_rounded),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
