class RegexPatternMatchedText {
  final dynamic type;
  final Pattern pattern;
  final String text;
  final int start;
  final int end;

  RegexPatternMatchedText({
    required this.text,
    required this.start,
    required this.end,
    required this.pattern,
    this.type,
  });
}
