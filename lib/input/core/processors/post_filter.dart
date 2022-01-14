abstract class PostFilter {
  Map<String, Enum> get options => {};

  List<String> process(List<String> candidates);
}
