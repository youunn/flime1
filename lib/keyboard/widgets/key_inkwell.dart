import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/basic/highlights.dart';
import 'package:flime/keyboard/basic/key.dart';
import 'package:flime/keyboard/stores/constraint.dart';
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
  bool _preview = false;

  Widget _buildInner(BuildContext context, {required void Function() onTap}) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
        ),
        Padding(
          padding: <Highlight, EdgeInsets>{
                Highlight.space: const EdgeInsets.only(
                  top: 22,
                  bottom: 22,
                ),
                Highlight.enter: const EdgeInsets.only(
                  top: 22,
                  bottom: 22,
                  left: 10,
                  right: 10,
                ),
              }[widget.k.highlight] ??
              const EdgeInsets.all(0),
          child: Ink(
            decoration: <Highlight, BoxDecoration>{
                  Highlight.space: BoxDecoration(
                    color: context.read<KeyboardTheme>().darkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                  ),
                  Highlight.enter: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                }[widget.k.highlight] ?? const BoxDecoration(),
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: widget.k.iconData == null
                    ? Text(
                        widget.k.label.toLowerCase(),
                        style: TextStyle(
                          fontSize: widget.k.preset.fontSize,
                          color: widget.k.highlight == Highlight.enter
                              ? Colors.white
                              : context.read<KeyboardTheme>().darkMode
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      )
                    : Icon(
                        widget.k.iconData,
                        size: widget.k.preset.fontSize,
                        color: widget.k.highlight == Highlight.enter
                            ? Colors.white
                            : context.read<KeyboardTheme>().darkMode
                                ? Colors.grey
                                : Colors.grey.shade900,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: widget.width * widget.k.width,
          child: Listener(
            onPointerDown: (event) {
              if (!_preview) {
                setState(() {
                  _preview = true;
                });
              }
            },
            onPointerUp: (event) {
              if (_preview) {
                setState(() {
                  _preview = false;
                });
              }
            },
            onPointerCancel: (event) {
              if (_preview) {
                setState(() {
                  _preview = false;
                });
              }
            },
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
                    GestureRecognizerFactoryWithHandlers<
                        LongPressGestureRecognizer>(
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
                            await Future.delayed(
                                const Duration(milliseconds: 50));
                          }
                        } else if (widget.k.longClick != null) {
                          widget.onKey(widget.k.longClick!);
                        } else {
                          widget.onKey(widget.k.click);
                        }
                        if (_preview) {
                          setState(() {
                            _preview = false;
                          });
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
          ),
        ),
        if (_preview && widget.k.highlight != Highlight.space)
          Positioned(
            // TODO: make clipBehavior-like work for FlutterView
            top: widget.k.firstRow ? 0 - context.read<Constraint>().baseHeight: 0 - widget.k.height,
            child: Container(
              decoration: BoxDecoration(
                color: context.read<KeyboardTheme>().darkMode
                    ? Colors.grey.shade800
                    : Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
              ),
              width: widget.width * widget.k.width,
              height: 63, // const value or not?
              child: Center(
                child: widget.k.iconData == null
                    ? Text(
                        widget.k.label.toLowerCase(),
                        style: TextStyle(
                          fontSize: widget.k.preset.fontSize,
                          color: widget.k.highlight == Highlight.enter
                              ? Colors.white
                              : context.read<KeyboardTheme>().darkMode
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      )
                    : Icon(
                        widget.k.iconData,
                        size: widget.k.preset.fontSize,
                        color: widget.k.highlight == Highlight.enter
                            ? Colors.white
                            : context.read<KeyboardTheme>().darkMode
                                ? Colors.grey
                                : Colors.grey.shade900,
                      ),
              ),
            ),
          ),
      ],
    );
  }
}
