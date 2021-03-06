import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/schemas/schemas.dart';
import 'package:flime/input/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPage extends StatelessWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input test'),
      ),
      body: const InputColumn(),
    );
  }
}

class InputColumn extends StatefulWidget {
  const InputColumn({Key? key}) : super(key: key);

  @override
  _InputColumnState createState() => _InputColumnState();
}

class _InputColumnState extends State<InputColumn> {
  late final Service service;
  String text = '依次按f，w，v，q，再依次点两个按钮测试';

  @override
  void initState() {
    super.initState();
    service = Service();
    getDefaultSchemaAsync().then((value) => service.engine.schema = value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...[
          for (var k in [
            LogicalKeyboardKey.keyF,
            LogicalKeyboardKey.keyW,
            LogicalKeyboardKey.keyV,
            LogicalKeyboardKey.keyQ,
          ])
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  service.onKey(KEvent.click(k));
                },
                child: Text(k.keyLabel),
              ),
            ),
        ],
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () async {
              if (!(await service
                  .onKey(KEvent.click(LogicalKeyboardKey.space)))) {}
            },
            child: const Text('commit'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              setState(() {
                text = service.popCommitText();
              });
            },
            child: const Text('update'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(text),
        ),
      ],
    );
  }
}
