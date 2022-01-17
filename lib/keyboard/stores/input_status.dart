import 'package:flime/keyboard/services/input_service.dart';
import 'package:mobx/mobx.dart';

part 'input_status.g.dart';

class InputStatus = _InputStatus with _$InputStatus;

abstract class _InputStatus with Store {
  final InputService _inputService;

  _InputStatus(this._inputService)
      : candidates = ObservableList.of(
          _inputService.engine.context.candidates,
        ),
        input = _inputService.engine.context.input,
        shifted = false {
    _inputService.bindStatus(this as InputStatus);
  }

  @observable
  ObservableList<String> candidates;
  @observable
  String input;
  @observable
  bool shifted;

  @action
  void update() {
    candidates = ObservableList.of(
      _inputService.candidates,
    );
    input = _inputService.input;
  }

  @computed
  bool get isComposing => candidates.isNotEmpty;
}
