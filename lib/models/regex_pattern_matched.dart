class RegexPatternMatched<T> {
  final T? type;
  final Pattern pattern;
  final String text;
  final int start;
  final int end;

  const RegexPatternMatched({
    required this.text,
    required this.start,
    required this.end,
    required this.pattern,
    this.type,
  });
}
