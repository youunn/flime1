import 'package:flime/input/core/processors/post_filter.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/input/core/processors/translator.dart';

class Schema {
  final List<PreFilter> preFilters;
  final List<Translator> translators;
  final List<PostFilter> postFilters;

  Schema({
    this.preFilters = const [],
    this.translators = const [],
    this.postFilters = const [],
  });
}
