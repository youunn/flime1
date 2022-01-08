import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class KEvent {
  final EventType type;

  // 借用一下shortcuts
  final LogicalKeyboardKey? _click;
  final LogicalKeySet? _combo;
  final List<LogicalKeySet>? _chord;
  final Function()? _command;

  // TODO: repeatable
  final bool _repeatable;

  KEvent._(this.type, this._click, this._combo, this._chord, this._command,
      {bool repeatable = false})
      : _repeatable = repeatable {
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
    }
  }

  KEvent.click(LogicalKeyboardKey click, {bool repeatable = false})
      : this._(EventType.click, click, null, null, null,
            repeatable: repeatable);

  KEvent.combo(LogicalKeySet combo)
      : this._(EventType.combo, null, combo, null, null);

  KEvent.chord(List<LogicalKeySet> chord)
      : this._(EventType.chord, null, null, chord, null);

  KEvent.command(Function() command)
      : this._(EventType.command, null, null, null, command);

  LogicalKeyboardKey get click => _click!;

  LogicalKeySet get combo => _combo!;

  List<LogicalKeySet> get chord => _chord!;

  Function() get command => _command!;

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
    }
    return label;
  }
}

enum EventType { click, combo, chord, command }
