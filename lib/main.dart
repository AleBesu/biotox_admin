import 'dart:io';

import 'package:biotox_admin/UI/add_animal_screen.dart';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(titleBarStyle: TitleBarStyle.hidden);

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'BioTox Admin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        home: Column(
          children: [
            if (Platform.isWindows)
              GestureDetector(
                onPanStart: (_) {
                  windowManager.startDragging();
                },
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    color: Colors.black,
                    // padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                          [
                                InkWell(
                                  child: const Icon(Icons.remove, size: 17),
                                  onTap: () {
                                    windowManager.minimize();
                                  },
                                ),

                                InkWell(
                                  child: const Icon(
                                    Icons.crop_square,
                                    size: 14,
                                  ),
                                  onTap: () async {
                                    if (await windowManager.isMaximized()) {
                                      await windowManager.unmaximize();
                                    } else {
                                      await windowManager.maximize();
                                    }
                                  },
                                ),

                                InkWell(
                                  onTap: () {
                                    windowManager.close();
                                  },
                                  child: Icon(Icons.close, size: 17),
                                ),
                              ]
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 12,
                                    right: 13.0,
                                  ),
                                  child: e,
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
              ),
            Expanded(child: AddAnimalScreen()),
          ],
        ),
      ),
    );
  }
}
