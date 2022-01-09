import 'package:flime/input/core/processors/post_filter.dart';

class DeDupFilter extends PostFilter {
  @override
  List<String> process(List<String> candidates) {
    return candidates.toSet().toList();
  }
}
