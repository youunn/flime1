import 'package:auto_route/auto_route.dart';
import 'package:flime/app/router/router.gr.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flime'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('setup'),
            onTap: () {
              context.router.push(SetupRoute());
            },
          ),
          ListTile(
            title: const Text('input'),
            onTap: () {
              context.router.push(const InputRoute());
            },
          )
        ],
      ),
    );
  }
}
