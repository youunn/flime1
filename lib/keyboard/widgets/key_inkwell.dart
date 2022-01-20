import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/basic/highlights.dart';
import 'package:flime/keyboard/basic/key.dart';
import 'package:flime/keyboard/stores/input_status.dart';
import 'package:flime/keyboard/stores/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyInkWell extends StatefulWidget {
  const KeyInkWell({
    Key? key,
    required this.width,
    required this.k,
    required this.onKey,
  }) : super(key: key);

  final double width;
  final K k;
  final void Function(KEvent event) onKey;

  @override
  State<KeyInkWell> createState() => _KeyInkWellState();
}

class _KeyInkWellState extends State<KeyInkWell> {
  bool _isPressed = false;

  Widget _buildInner(BuildContext context, {required void Function() onTap}) {
    switch (widget.k.highlight) {
      case Highlight.space:
        return Stack(
          children: <Widget>[
            GestureDetector(
              onTap: onTap,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 22,
                bottom: 22,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  color: context.read<KeyboardTheme>().darkMode
                      ? Colors.grey.shade700
                      : Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                ),
                child: InkWell(
                  onTap: onTap,
                  child: Center(
                    child: widget.k.iconData == null
                        ? Text(
                            widget.k.label.toLowerCase(),
                            style: TextStyle(
                              fontSize: widget.k.preset.fontSize,
                              color: context.read<KeyboardTheme>().darkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )
                        : Icon(
                            widget.k.iconData,
                            size: widget.k.preset.fontSize,
                            color: context.read<KeyboardTheme>().darkMode
                                ? Colors.grey
                                : Colors.grey.shade900,
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      case Highlight.enter:
        return Stack(
          children: <Widget>[
            GestureDetector(
              onTap: onTap,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 22,
                left: 10,
                bottom: 22,
                right: 10,
              ),
              child: Ink(
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: InkWell(
                  onTap: onTap,
                  child: Center(
                    child: widget.k.iconData == null
                        ? Text(
                            widget.k.label.toLowerCase(),
                            style: TextStyle(
                              fontSize: widget.k.preset.fontSize,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            widget.k.iconData,
                            size: widget.k.preset.fontSize,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      case null:
        return InkWell(
          child: Center(
            child: widget.k.iconData == null
                ? Text(
                    widget.k.label.toLowerCase(),
                    style: TextStyle(
                      fontSize: widget.k.preset.fontSize,
                      color: context.read<KeyboardTheme>().darkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                : Icon(
                    widget.k.iconData,
                    size: widget.k.preset.fontSize,
                    color: context.read<KeyboardTheme>().darkMode
                        ? Colors.grey
                        : Colors.grey.shade900,
                  ),
          ),
          onTap: onTap,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * widget.k.width,
      child: RawGestureDetector(
        behavior: HitTestBehavior.translucent,
        child: _buildInner(
          context,
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
                  if (widget.k.repeatable) {
                    _isPressed = true;
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
                  if (_isPressed) {
                    setState(() {
                      _isPressed = false;
                    });
                  }
                };
            },
          ),
        },
      ),
    );
  }
}
