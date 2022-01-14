import 'package:flime/input/core/processors/post_filter.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/input/core/processors/translator.dart';

class Schema {
  final List<PreFilter> preFilters;
  final List<Translator> translators;
  final List<PostFilter> postFilters;

  Map<String, Enum> options = {};

  Schema({
    this.preFilters = const [],
    this.translators = const [],
    this.postFilters = const [],
  }) {
    for (var e in preFilters) {
      e.options.forEach((k, v) {
        options[k] = v;
      });
    }
    for (var e in translators) {
      e.options.forEach((k, v) {
        options[k] = v;
      });
    }
    for (var e in postFilters) {
      e.options.forEach((k, v) {
        options[k] = v;
      });
    }
  }

  Enum? getOption(String s) => options[s];

  void setOption(String s, Enum value) {
    if (options.containsKey(s)) options[s] = value;
  }
}
