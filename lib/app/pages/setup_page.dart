import 'dart:io';

import 'package:flime/api/api.dart';
import 'package:flime/input/schemas/processors/post/opencc.dart';
import 'package:flutter/material.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({Key? key}) : super(key: key);

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final InputMethodApi? inputMethodApi =
      Platform.isAndroid ? InputMethodApi() : null;

  final controller = TextEditingController();
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '...',
              ),
              controller: controller,
              onChanged: (v) {
                setState(() {
                  text = v;
                });
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  inputMethodApi?.enable();
                }
              },
              child: const Text('Enable'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  inputMethodApi?.pick();
                }
              },
              child: const Text('Switch'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final output = await NativeOpenCC().convert(text);
                setState(() {
                  controller.text = output;
                });
              },
              child: const Text('Test'),
            ),
          ),
        ],
      ),
    );
  }
}
