import 'package:flutter/material.dart';

import 'app/app.dart';
import 'keyboard/view.dart';

void main() => runApp(const MyApp());

@pragma('vm:entry-point')
void showKeyboard() => runApp(const KeyboardView());
