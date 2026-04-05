import 'package:flutter/material.dart';
import 'package:regex_pattern_text_field/helpers/regex_pattern_text_style_helper.dart';
import 'package:regex_pattern_text_field/models/regex_pattern_matched.dart';
import 'package:regex_pattern_text_field/models/regex_pattern_text_style.dart';

class RegexPatternTextEditingController extends TextEditingController {
  static final RegExp _noMatchPattern = RegExp(r'(?!)');
  static final RegExp _tokenSeparator = RegExp(r'\s+');
  static const String _emptyString = '';

  RegExp _combinedPattern = _noMatchPattern;
  List<RegexPatternTextStyle<Object?>>? _textPartStyleList;
  ValueChanged<RegexPatternMatched<Object?>>? _onMatch;
  ValueChanged<String>? _onNonMatch;

  RegexPatternTextEditingController();

  void setOnMatch(ValueChanged<RegexPatternMatched<Object?>>? onMatch) =>
      _onMatch = onMatch;

  void setOnNonMatch(ValueChanged<String>? onNonMatch) =>
      _onNonMatch = onNonMatch;

  List<RegexPatternMatched<Object?>> get regexPatternMatchedList {
    return _combinedPattern.allMatches(text).map((e) {
      return _createMatchedModelFromMatch(e);
    }).toList();
  }

  @override
  set value(TextEditingValue newValue) {
    final token = _extractTokenAtCursor(newValue);
    if (token.isNotEmpty) {
      final match = _combinedPattern.firstMatch(token);
      if (match != null) {
        _onMatch?.call(_createMatchedModelFromMatch(match));
      } else {
        _onNonMatch?.call(token);
      }
    }

    super.value = newValue;
  }

  RegexPatternMatched<Object?> _createMatchedModelFromMatch(Match match) {
    final matchedText = match.group(0) ?? _emptyString;
    final textPart = RegexPatternTextStyleHelper.findMatchingTextStyle(
      matchedText,
      _textPartStyleList,
    );

    return RegexPatternMatched<Object?>(
      type: textPart?.type,
      text: matchedText,
      start: match.start,
      end: match.end,
      pattern: match.pattern,
    );
  }

  String _extractTokenAtCursor(TextEditingValue value) {
    final fullText = value.text;
    if (fullText.isEmpty) {
      return _emptyString;
    }

    final cursor = value.selection.baseOffset.clamp(0, fullText.length);

    var tokenStart = cursor;
    while (tokenStart > 0 && !_isTokenSeparator(fullText[tokenStart - 1])) {
      tokenStart--;
    }

    var tokenEnd = cursor;
    while (tokenEnd < fullText.length &&
        !_isTokenSeparator(fullText[tokenEnd])) {
      tokenEnd++;
    }

    if (tokenStart >= tokenEnd) {
      return _emptyString;
    }

    return fullText.substring(tokenStart, tokenEnd);
  }

  bool _isTokenSeparator(String char) {
    return _tokenSeparator.hasMatch(char);
  }

  void setRegexPatternStyle(
    List<RegexPatternTextStyle<Object?>>? regexPatternStyles,
    bool defaultRegexPatternStyles,
  ) {
    _setTextPartStyleList(regexPatternStyles, defaultRegexPatternStyles);
    _setCombinedPattern();
  }

  void _setTextPartStyleList(
    List<RegexPatternTextStyle<Object?>>? regexPatternStyles,
    bool defaultRegexPatternStyles,
  ) {
    if (defaultRegexPatternStyles) {
      _textPartStyleList = [
        ...?regexPatternStyles,
        ...RegexPatternTextStyleHelper.defaultTextPartStyleList,
      ];
    } else {
      _textPartStyleList = [...?regexPatternStyles];
    }
  }

  void _setCombinedPattern() {
    final combinedPatternString = _textPartStyleList
        ?.where((style) => style.regexPattern.isNotEmpty)
        .map((style) => style.regexPattern)
        .join('|');

    if (combinedPatternString == null || combinedPatternString.isEmpty) {
      _combinedPattern = _noMatchPattern;
      return;
    }

    _combinedPattern = RegExp(
      combinedPatternString,
      multiLine: true,
      caseSensitive: false,
    );
  }

  @override
  TextSpan buildTextSpan({
    BuildContext? context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> textSpanChildren = [];

    text.splitMapJoin(
      _combinedPattern,
      onMatch: (Match match) => _addStyledTextOnMatch(textSpanChildren, match),
      onNonMatch: (String nonMatchText) =>
          _addTextOnNonMatch(textSpanChildren, nonMatchText, style),
    );

    return TextSpan(style: style, children: textSpanChildren);
  }

  String _addStyledTextOnMatch(List<InlineSpan> textSpanChildren, Match match) {
    final textToBeStyled = match.group(0) ?? _emptyString;
    final textPart = RegexPatternTextStyleHelper.findMatchingTextStyle(
      textToBeStyled,
      _textPartStyleList,
    );
    textSpanChildren.add(
      TextSpan(text: textToBeStyled, style: textPart?.textStyle),
    );
    return _emptyString;
  }

  String _addTextOnNonMatch(
    List<InlineSpan> textSpanChildren,
    String textToBeStyled,
    TextStyle? style,
  ) {
    textSpanChildren.add(TextSpan(text: textToBeStyled, style: style));
    return _emptyString;
  }
}
