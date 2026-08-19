import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<FileImage?> getImageFromDevice(
  ImageSource imageSourse, {
  int? maxHeight,
  int? maxWidth,
}) async {
  final imagePicker = ImagePicker();

  final image = await imagePicker.pickImage(
    source: imageSourse,
    preferredCameraDevice: CameraDevice.rear,
    maxHeight: maxHeight?.toDouble() ?? 1920,
    maxWidth: maxWidth?.toDouble() ?? 1080,
    imageQuality: 100,
  );

  return image != null ? FileImage(File(image.path)) : null;
}
