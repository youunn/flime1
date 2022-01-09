class Context {
  // 有点简陋
  String _input = '';

  var candidates = <String>[];

  // TODO: 回调换成changeNotifier
  late Future Function() _onChange;
  late void Function(String) _onCommit;

  Context();

  String get input => _input;

  Future setInput(String value) async {
    _input = value;
    await _onChange();
  }

  set onChange(Future Function() value) {
    _onChange = value;
  }

  set onCommit(void Function(String) value) {
    _onCommit = value;
  }

  Future pushInput(String s) async {
    _input += s;
    await _onChange();
  }

  Future<bool> popInput() async {
    if (_input.isEmpty) {
      return false;
    } else {
      _input = _input.substring(0, input.length - 1);
    }
    await _onChange();
    return true;
  }

  Future clear() async {
    _input = '';
    candidates.clear();
    await _onChange();
  }

  bool commit(int index) {
    if (index < 0 || candidates.length <= index) {
      return false;
    }
    _onCommit(candidates[index]);
    return true;
  }

  bool commitCurrent() => commit(0);
}
