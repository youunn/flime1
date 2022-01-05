import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../api/api.dart';
import 'layout.dart';

class KeyboardView extends StatelessWidget {
  KeyboardView({Key? key}) : super(key: key);
  final layoutApi = LayoutApi();

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

          SchedulerBinding.instance!.addPostFrameCallback((_) {
            RenderBox box =
                boxKey.currentContext!.findRenderObject() as RenderBox;
            var w = box.getMaxIntrinsicWidth(double.infinity);
            var h = box.getMaxIntrinsicHeight(w);
            // 第一次dpr是1，之后才正常
            layoutApi.setHeight((h * MediaQuery.of(context).devicePixelRatio).toInt());
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
