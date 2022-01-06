import 'package:flime/app/app.dart';
import 'package:flime/keyboard/view.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

@pragma('vm:entry-point')
void showKeyboard() => runApp(KeyboardView());
