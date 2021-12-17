import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui' as ui;

import '../api/api.dart';
import 'layout.dart';
import 'state.dart';

class KeyboardView extends StatelessWidget {
  const KeyboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.light,
      home: LayoutBuilder(
        builder: (context, constraints) {
          var boxKey = GlobalKey();

          var keyboardState = KeyboardState();
          LayoutApi.setup(KeyboardStateApi(keyboardState));

          SchedulerBinding.instance!.addPostFrameCallback((_) {
            RenderBox box =
                boxKey.currentContext!.findRenderObject() as RenderBox;
            var w = box.getMaxIntrinsicWidth(double.infinity);
            var h = box.getMaxIntrinsicHeight(w);
            keyboardState.height = (h * ui.window.devicePixelRatio).toInt();
          });

          return Container(
            key: boxKey,
            decoration: const BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1)),
            child: KeyboardLayout(),
          );
        },
      ),
    );
  }
}
