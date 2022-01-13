import 'package:flime/input/core/processors/post_filter.dart';

class DeDupFilter extends PostFilter {
  static DeDupFilter? _filter;

  DeDupFilter._();

  factory DeDupFilter() => _filter ??= DeDupFilter._();

  @override
  List<String> process(List<String> candidates) {
    return candidates.toSet().toList();
  }
}
