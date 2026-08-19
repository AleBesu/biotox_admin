import 'dart:io';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CropImageScreen extends StatefulWidget {
  final Image imageToCrop;
  const CropImageScreen({super.key, required this.imageToCrop});

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  final CropController controller = CropController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                final cropedImage = await controller.croppedBitmap();

                //======save Image=======
                //create file
                final imageFile = File(
                  "${(await getTemporaryDirectory()).path}/images/${DateTime.now().millisecondsSinceEpoch}.jpg",
                );

                ///create folder
                await imageFile.parent.create(recursive: true);
                //write bits of image
                await imageFile.writeAsBytes(
                  (await cropedImage.toByteData(
                    format: ImageByteFormat.png,
                  ))!.buffer.asUint8List(),
                );
                if (mounted) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, FileImage(imageFile));
                }
              },

              child: Icon(Icons.done, color: Colors.white),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: CropImage(
          alwaysShowThirdLines: true,
          image: widget.imageToCrop,
          controller: controller,
        ),
      ),
    );
  }
}
