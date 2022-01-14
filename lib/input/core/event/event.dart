import 'package:flime/input/schemas/commands.dart';
import 'package:flime/keyboard/basic/operations.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class KEvent {
  final EventType type;

  // 借用一下shortcuts
  final LogicalKeyboardKey? _click;
  final LogicalKeySet? _combo;
  final List<LogicalKeySet>? _chord;
  final CommandEvent? _command;
  final Operation? _operation;

  // TODO: repeatable
  final bool _repeatable;

  KEvent._(
    this.type, {
    LogicalKeyboardKey? click,
    LogicalKeySet? combo,
    List<LogicalKeySet>? chord,
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

  KEvent.combo(LogicalKeySet combo) : this._(EventType.combo, combo: combo);

  KEvent.chord(List<LogicalKeySet> chord)
      : this._(EventType.chord, chord: chord);

  KEvent.command(CommandEvent command)
      : this._(EventType.command, command: command);

  KEvent.operation(Operation operation)
      : this._(EventType.operation, operation: operation);

  LogicalKeyboardKey get click => _click!;

  LogicalKeySet get combo => _combo!;

  List<LogicalKeySet> get chord => _chord!;

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
        label = combo.keys.fold('', (p, e) => p + e.keyLabel);
        break;
      case EventType.chord:
        label = chord.fold(
          '',
          (p, e) => p + e.keys.fold('', (p, e) => p + e.keyLabel),
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
