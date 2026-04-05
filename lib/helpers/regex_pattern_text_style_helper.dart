import 'package:regex_pattern_text_field/helpers/regex_pattern_type.dart';
import 'package:regex_pattern_text_field/models/regex_pattern_text_style.dart';

class RegexPatternTextStyleHelper {
  static final Expando<RegExp> _compiledPatternCache = Expando<RegExp>(
    'regex_pattern_cache',
  );

  static final List<RegexPatternTextStyle<Object?>> defaultTextPartStyleList =
      RegexPatternType.values
          .map(
            (type) => RegexPatternTextStyle(
              regexPattern: type.pattern,
              textStyle: type.style,
              type: type,
            ),
          )
          .toList();

  static RegexPatternTextStyle<T>? findMatchingTextStyle<T>(
    String textPart,
    List<RegexPatternTextStyle<T>>? partStyleList,
  ) {
    if (textPart.isEmpty || partStyleList == null || partStyleList.isEmpty) {
      return null;
    }

    for (final style in partStyleList) {
      final compiledPattern = _compiledPatternCache[style] ??= RegExp(
        style.regexPattern,
        caseSensitive: style.caseSensitive,
        multiLine: style.multiLine,
      );

      if (compiledPattern.hasMatch(textPart)) {
        return style;
      }
    }

    return null;
  }
}
