import 'package:flutter/material.dart';
import 'package:regex_pattern_text_field/helpers/regex_pattern_helper.dart';

enum RegexPatternType { url, hashtag, mention, emoji, email }

extension RegexPatternTypeExtension on RegexPatternType {
  String get pattern {
    switch (this) {
      case RegexPatternType.url:
        return RegexPatternHelper.url;
      case RegexPatternType.hashtag:
        return RegexPatternHelper.hashtag;
      case RegexPatternType.mention:
        return RegexPatternHelper.mention;
      case RegexPatternType.emoji:
        return RegexPatternHelper.emoji;
      case RegexPatternType.email:
        return RegexPatternHelper.email;
      default:
        return "";
    }
  }

  TextStyle get style {
    switch (this) {
      case RegexPatternType.url:
        return const TextStyle(color: Colors.blue, decoration: TextDecoration.underline, decorationColor: Colors.blue);
      case RegexPatternType.hashtag:
        return const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold);
      case RegexPatternType.mention:
        return const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold);
      case RegexPatternType.emoji:
        return const TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
      case RegexPatternType.email:
        return const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold);
      default:
        return const TextStyle();
    }
  }
}
