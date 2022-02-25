import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/processors/post_filter.dart';

class DeDupFilter extends PostFilter {
  static DeDupFilter? _filter;

  DeDupFilter._();

  factory DeDupFilter() => _filter ??= DeDupFilter._();

  @override
  Future<List<String>> process(List<String> candidates, Engine engine) async =>
      candidates.toSet().toList();
}
