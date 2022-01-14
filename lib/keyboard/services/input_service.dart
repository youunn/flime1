import 'package:flime/input/service.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/stores/input_status.dart';

class InputService extends Service {
  InputStatus? _inputStatus;

  void bindStatus(InputStatus inputStatus) {
    _inputStatus = inputStatus;
  }

  @override
  Future<bool> onKey(KEvent event) async {
    var result = await super.onKey(event);
    _inputStatus?.update();
    return result;
  }
}
