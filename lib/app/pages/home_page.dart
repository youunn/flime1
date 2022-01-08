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
            title: const Text('Input Tools'),
            onTap: () {
              context.router.push(const InputRoute());
            },
          ),
          ListTile(
            title: const Text('Setup'),
            onTap: () {
              context.router.push(SetupRoute());
            },
          ),
          const ListTile(
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
