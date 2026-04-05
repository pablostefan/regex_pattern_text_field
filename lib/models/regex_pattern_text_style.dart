import 'package:flutter/material.dart';

class RegexPatternTextStyle<T> {
  final T? type;
  final String regexPattern;
  final TextStyle textStyle;
  final bool caseSensitive;
  final bool multiLine;

  const RegexPatternTextStyle({
    required this.regexPattern,
    required this.textStyle,
    this.type,
    this.caseSensitive = false,
    this.multiLine = true,
  });

  bool matches(String value) {
    if (value.isEmpty) {
      return false;
    }

    return RegExp(
      regexPattern,
      caseSensitive: caseSensitive,
      multiLine: multiLine,
    ).hasMatch(value);
  }
}
