import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flime/keyboard/stores/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpandMore extends StatefulWidget {
  const ExpandMore({Key? key}) : super(key: key);

  @override
  _ExpandMoreState createState() => _ExpandMoreState();
}

class _ExpandMoreState extends State<ExpandMore> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final darkMode = context.read<KeyboardTheme>().darkMode;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: TextButton(
          child: Icon(
            expanded ? Icons.expand_less : Icons.expand_more,
            color: darkMode ? Colors.grey.shade400 : Colors.grey.shade800,
            size: 18,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: MaterialStateProperty.all(
              darkMode ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
          ),
          onPressed: () {
            if (expanded) {
              context.router.replace(const PrimaryRoute());
              setState(() {
                expanded = false;
              });
            } else {
              context.router.replace(const CandidatesRoute());
              setState(() {
                expanded = true;
              });
            }
          },
        ),
      ),
    );
  }
}
