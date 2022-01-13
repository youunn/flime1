import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flime/keyboard/widgets/preset_builder.dart';
import 'package:flutter/material.dart';

class SecondaryLayout extends StatelessWidget {
  const SecondaryLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PresetBuilder(
      child: Material(
        child: SizedBox(
          height: 200,
          child: InkWell(
            onTap: () {
              context.router.replace(PrimaryRoute());
            },
            child: const Center(
              child: Text('Back'),
            ),
          ),
        ),
      ),
    );
  }
}
