import 'package:flime/app/app.dart';
import 'package:flime/keyboard/view.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

@pragma('vm:entry-point')
void showKeyboard() => runApp(KeyboardView());
