import 'package:regex_pattern_text_field/helpers/regex_pattern_type.dart';
import 'package:regex_pattern_text_field/models/regex_pattern_text_style.dart';

class RegexPatternTextStyleHelper {
  static final List<RegexPatternTextStyle> defaultTextPartStyleList = RegexPatternType.values
      .map((type) => RegexPatternTextStyle(regexPattern: type.pattern, textStyle: type.style, type: type))
      .toList();

  static RegexPatternTextStyle? findMatchingTextStyle(String textPart, List<RegexPatternTextStyle>? partStyleList) {
    try {
      return partStyleList?.firstWhere((style) => RegExp(style.regexPattern, caseSensitive: false).hasMatch(textPart));
    } catch (e) {
      return null;
    }
  }
}
