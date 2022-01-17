import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/basic/key.dart';
import 'package:flime/keyboard/stores/input_status.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyInkwell extends StatefulWidget {
  const KeyInkwell({
    Key? key,
    required this.width,
    required this.k,
    required this.onKey,
  }) : super(key: key);

  final double width;
  final K k;
  final void Function(KEvent event) onKey;

  @override
  State<KeyInkwell> createState() => _KeyInkwellState();
}

class _KeyInkwellState extends State<KeyInkwell> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * widget.k.width,
      child: RawGestureDetector(
        behavior: HitTestBehavior.translucent,
        // 内层手势优先级高
        child: InkWell(
          child: Center(
            child: Text(widget.k.label),
          ),
          onTap: () {
            if (context.read<InputStatus>().isComposing) {
              widget.onKey(widget.k.composing ?? widget.k.click);
            } else {
              widget.onKey(widget.k.click);
            }
          },
        ),
        gestures: <Type, GestureRecognizerFactory>{
          LongPressGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
            () => LongPressGestureRecognizer(
              duration: const Duration(milliseconds: 150),
            ),
            (LongPressGestureRecognizer instance) {
              instance
                ..onLongPress = () async {
                  _isPressed = true;
                  if (widget.k.repeatable) {
                    while (_isPressed) {
                      widget.onKey(widget.k.click);
                      await Future.delayed(const Duration(milliseconds: 50));
                    }
                  } else if (widget.k.longClick != null) {
                    widget.onKey(widget.k.longClick!);
                  } else {
                    widget.onKey(widget.k.click);
                  }
                }
                ..onLongPressEnd = (_) async {
                  setState(() {
                    _isPressed = false;
                  });
                };
            },
          ),
        },
      ),
    );
  }
}
