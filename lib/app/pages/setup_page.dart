import 'package:flime/api/api.dart';
import 'package:flutter/material.dart';

class SetupPage extends StatelessWidget {
  SetupPage({Key? key}) : super(key: key);
  final inputMethodApi = InputMethodApi();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Card(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '...',
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                inputMethodApi.enable();
              },
              child: const Text('Enable'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                inputMethodApi.pick();
              },
              child: const Text('Switch'),
            ),
          ),
        ],
      ),
    );
  }
}
