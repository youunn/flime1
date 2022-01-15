class Context {
  // 有点简陋
  String _input = '';
  final _candidates = <String>[];

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

  List<String> get candidates => _candidates;

  bool get hasCandidates => _candidates.isNotEmpty;

  bool get hasSingleCandidate => _candidates.length == 1;

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
    _candidates.clear();
    await _onChange();
  }

  Future<bool> commitAt(int index) async {
    if (index < 0 || _candidates.length <= index) {
      return false;
    }
    _onCommit(_candidates[index]);
    await clear();
    return true;
  }

  Future<bool> commitCurrent() async => commitAt(0);

  Future<void> commitDirectly(String text) async {
    _onCommit(text);
    await clear();
  }
}
