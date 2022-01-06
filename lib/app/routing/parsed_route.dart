class ParsedRoute {
  final String path;

  ParsedRoute(this.path);

  @override
  bool operator ==(Object other) => other is ParsedRoute && other.path == path;

  @override
  int get hashCode => path.hashCode;
}
