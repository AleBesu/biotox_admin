import 'dart:io';

import 'package:biotox_admin/UI/utils/crop_image_screen.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/features/files_manage/cropper_image.dart';
import '../../../../core/features/files_manage/get_image_from_device.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

Future<FileImage?> showImageSelecter(
  BuildContext context, {
  int? maxHeight,
  int? maxWidth,
  double? radioX,
  double? radioY,
}) async {
  if (Platform.isWindows) {
    FileImage? imagePicked = await getImageFromDevice(
      ImageSource.gallery,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
    if (context.mounted) {
      return _croppeImage(context, imagePicked);
    }
  }

  return await showModalBottomSheet<FileImage?>(
    // ignore: use_build_context_synchronously
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Selecciona una fuente",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'spaceGrotesk',
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children:
                  [
                        _ImageSourceWidget(
                          icon: Icons.photo_camera_outlined,
                          onTap: () async {
                            FileImage? imagePicked = await getImageFromDevice(
                              ImageSource.camera,
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                            );

                            if (context.mounted) {
                              _croppeImage(context, imagePicked);
                            }
                          },
                          text: "Camara",
                        ),
                        _ImageSourceWidget(
                          icon: Icons.collections_outlined,
                          onTap: () async {
                            FileImage? imagePicked = await getImageFromDevice(
                              ImageSource.gallery,
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                            );

                            if (context.mounted) {
                              _croppeImage(context, imagePicked);
                            }

                            // ignore: use_build_context_synchronously
                          },
                          text: "Galería",
                        ),
                      ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: e,
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      );
    },
  );
}

class _ImageSourceWidget extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final String text;
  const _ImageSourceWidget({
    required this.icon,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white54, width: 1),
            ),
            child: Icon(icon, size: 30),
          ),
        ),
        const SizedBox(height: 5),
        Text(text),
      ],
    );
  }
}

Future<FileImage?> _croppeImage(
  BuildContext context,
  FileImage? imagePicked,
) async {
  if (imagePicked != null && context.mounted) {
    return await Navigator.of(context).push<FileImage>(
      MaterialPageRoute(
        builder: (context) =>
            CropImageScreen(imageToCrop: Image(image: imagePicked)),
      ),
    );
  }
  return imagePicked;
}
