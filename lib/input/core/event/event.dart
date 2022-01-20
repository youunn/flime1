import 'package:flime/input/schemas/commands.dart';
import 'package:flime/keyboard/basic/operations.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class KEvent {
  final EventType type;

  // 借用一下shortcuts
  final LogicalKeyboardKey? _click;

  // 好像暂时不需要LogicalKeySet
  final SingleActivator? _combo;
  final List<SingleActivator>? _chord;
  final CommandEvent? _command;
  final Operation? _operation;
  final bool _repeatable;

  KEvent._(
    this.type, {
    LogicalKeyboardKey? click,
    SingleActivator? combo,
    List<SingleActivator>? chord,
    CommandEvent? command,
    Operation? operation,
    bool repeatable = false,
  })  : _click = click,
        _combo = combo,
        _chord = chord,
        _command = command,
        _operation = operation,
        _repeatable = repeatable {
    switch (type) {
      case EventType.click:
        assert(_click != null);
        break;
      case EventType.combo:
        assert(_combo != null);
        break;
      case EventType.chord:
        assert(_chord != null);
        break;
      case EventType.command:
        assert(_command != null);
        break;
      case EventType.operation:
        assert(_operation != null);
        break;
    }
  }

  KEvent.click(LogicalKeyboardKey click, {bool repeatable = false})
      : this._(EventType.click, click: click, repeatable: repeatable);

  KEvent.combo(SingleActivator combo) : this._(EventType.combo, combo: combo);

  KEvent.chord(List<SingleActivator> chord)
      : this._(EventType.chord, chord: chord);

  KEvent.command(CommandEvent command)
      : this._(EventType.command, command: command);

  KEvent.operation(Operation operation)
      : this._(EventType.operation, operation: operation);

  LogicalKeyboardKey get click => _click!;

  SingleActivator get combo => _combo!;

  List<SingleActivator> get chord => _chord!;

  CommandEvent get command => _command!;

  Operation get operation => _operation!;

  bool get repeatable => _repeatable;

  String parseLabel() {
    String label;
    switch (type) {
      case EventType.click:
        label = click.keyLabel;
        break;
      case EventType.combo:
        label = combo.triggers.fold('', (p, e) => p + e.keyLabel);
        break;
      case EventType.chord:
        label = chord.fold(
          '',
          (p, e) => p + e.triggers.fold('', (p, e) => p + e.keyLabel),
        );
        break;
      case EventType.command:
        label = 'command';
        break;
      case EventType.operation:
        label = 'operation';
        break;
    }
    return label;
  }
}

enum EventType {
  click,
  combo,
  chord,
  command,
  operation,
}
