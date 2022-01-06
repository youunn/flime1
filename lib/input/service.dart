/// 输入服务接口。
///
/// *真得劲，我慢慢整明白了。*首先有一个单例`Service`当接口，主要负责获取提交的文本和发送
/// 用户按键输入给`Engine`。
///
/// 获取到按键输入时，由`Engine`处理。首先交给`Processor`判断什么类型的事件，并作出对应处
/// 理。以一般字母输入为例，`Processor`更新`Context`的`input`文本。
///
/// 接收按键后，`Engine`监听`Context`的变化，将编码转换为候选字，并对候选字后处理，添加到
/// `Context`（中间件都不要了）。这一步可能在`Processor`处理按键的过程中进行。
///
/// 关于自动上屏，在`Processor`记录当前候选词，如果更新`Context`的`input`文本之后，候选
/// 字为空，则提交之前的候选词，再更新`Composition`。另外还需要实现单候选字自动上屏。
///
/// 什么时候通知引擎提交呢？其实是每发送一次事件处理请求就检查一次。
///
/// `Engine`收到提交信号后，清空`Context`的`composition`文本。然后`Service`更新预提交
/// 文本。
///
/// 有一说一，*Rime源代码可读性真的高。*
class Service {
  static Service? _service;

  final _Context _context = _Context();
  final _Status _status = _Status();

  factory Service() {
    _service ??= Service._init();
    return _service!;
  }

  // init
  Service._init() {
    // TODO: init
  }

  // exit
  void destroy() {
    // destroy
    _service = null;
  }

  // getter
  bool get composing => _status.composing;

  bool get asciiMode => _status.asciiMode;

  String get composition => _context.composition;

  List<String> get candidates => _context.candidates;

  // setter
  // TODO: setter

  // input
  bool onKey(int keycode, int mask) {
    return false;
  }

  bool commit() {
    return false;
  }

  // keycode
  int getKeycode(String name) {
    return 0;
  }
}

class _Context {
  String composition = '';
  List<String> candidates = [];
}

class _Status {
  _Schema schema = _Schema.defaultSchema;
  bool composing = false;
  bool asciiMode = false;
}

enum _Schema {
  defaultSchema,
}
