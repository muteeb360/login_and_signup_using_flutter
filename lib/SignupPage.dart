import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:login_and_signup_using_flutter/imagePicker.dart';

final imagePicker = ImagePicker();

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileImage(initials: "JD"),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  final file = await imagePicker.pickImage();
                  if (file != null && file.path.isNotEmpty) {
                    final croppedFile = await imagePicker.crop(
                      file: file,
                      cropStyle: CropStyle.circle,
                    );
                    if (croppedFile != null) {
                      setState(() => _image = File(croppedFile.path));
                    }
                  }
                },
                child: const Text('Select Photo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    required this.initials,
    this.image,
  }) : super(key: key);

  final String initials;
  final File? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 64,
              foregroundImage: image != null ? FileImage(image!) : null,
              child: Text(
                initials,
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
