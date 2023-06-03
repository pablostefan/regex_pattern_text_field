import 'dart:core';

import 'package:flutter/material.dart';
import 'package:regex_pattern_text_field/helpers/regex_pattern_text_style_helper.dart';
import 'package:regex_pattern_text_field/models/regex_pattern_matched_text.dart';
import 'package:regex_pattern_text_field/models/regex_pattern_text_style.dart';

class RegexPatternTextEditingController extends TextEditingController {
  RegExp _combinedPattern = RegExp("");
  List<RegexPatternTextStyle>? _textPartStyleList;
  Function(RegexPatternMatchedText)? _onMatch;
  Function(String)? _onNonMatch;

  RegexPatternTextEditingController();

  void setOnMatch(Function(RegexPatternMatchedText)? onMatch) => _onMatch = onMatch;

  void setOnNonMatch(Function(String)? onNonMatch) => _onNonMatch = onNonMatch;

  @override
  set value(TextEditingValue newValue) {
    final String newDetectionContent = _extractLastWordFromValue(newValue);
    newDetectionContent.splitMapJoin(_combinedPattern, onMatch: _onMatchValueText, onNonMatch: _onNonMatchValueText);

    super.value = newValue;
  }

  String _onMatchValueText(Match match) {
    var text = match.group(0) ?? "";
    _onMatch?.call(RegexPatternMatchedText(text: text, start: match.start, end: match.end, pattern: match.pattern));

    return "";
  }

  String _onNonMatchValueText(String nonMatch) {
    _onNonMatch?.call(nonMatch);

    return "";
  }

  String _extractLastWordFromValue(TextEditingValue newValue) {
    try {
      var currentPosition = newValue.selection.baseOffset;
      if (currentPosition == -1) currentPosition = 0;
      if (currentPosition > newValue.text.length) currentPosition = newValue.text.length - 1;
      var subString = newValue.text.substring(0, currentPosition);
      var lastPart = subString.split(" ").last.split("\n").last;
      var startIndex = currentPosition - lastPart.length;
      var detectionContent = newValue.text.substring(startIndex).split(" ").first.split("\n").first;

      return detectionContent;
    } catch (e) {
      return "";
    }
  }

  void setRegexPatternStyle(List<RegexPatternTextStyle>? regexPatternStyles, bool defaultRegexPatternStyles) {
    _setTextPartStyleList(regexPatternStyles, defaultRegexPatternStyles);
    _setCombinedPattern();
  }

  void _setTextPartStyleList(List<RegexPatternTextStyle>? regexPatternStyles, bool defaultRegexPatternStyles) {
    if (defaultRegexPatternStyles) {
      _textPartStyleList = [...RegexPatternTextStyleHelper.defaultTextPartStyleList, ...?regexPatternStyles];
    } else {
      _textPartStyleList = [...?regexPatternStyles];
    }
  }

  void _setCombinedPattern() {
    try {
      final combinedPatternString = _textPartStyleList?.map((style) => style.regexPattern).join('|');
      _combinedPattern = RegExp(combinedPatternString ?? "", multiLine: true, caseSensitive: false);
    } catch (e) {
      _combinedPattern = RegExp("");
    }
  }

  @override
  TextSpan buildTextSpan({BuildContext? context, TextStyle? style, required bool withComposing}) {
    final List<TextSpan> textSpanChildren = [];

    text.splitMapJoin(_combinedPattern,
        onMatch: (Match match) => _addStyledTextOnMatch(textSpanChildren, match),
        onNonMatch: (String nonMatchText) => _addTextOnNonMatch(textSpanChildren, nonMatchText, style));

    return TextSpan(style: style, children: textSpanChildren);
  }

  String _addStyledTextOnMatch(List<InlineSpan> textSpanChildren, Match match) {
    try {
      var textToBeStyled = match.group(0) ?? "";
      var textPart = RegexPatternTextStyleHelper.findMatchingTextStyle(textToBeStyled, _textPartStyleList);
      textSpanChildren.add(TextSpan(text: textToBeStyled, style: textPart?.textStyle));
    } catch (e) {
      throw Exception("Error on _addStyledTextOnMatch: Failed to add styled text for 'textToBeStyled'.");
    }
    return "";
  }

  String _addTextOnNonMatch(List<InlineSpan> textSpanChildren, String textToBeStyled, TextStyle? style) {
    try {
      textSpanChildren.add(TextSpan(text: textToBeStyled, style: style));
    } catch (e) {
      throw Exception("The style of the text part '$textToBeStyled' is not defined in SocialTextFieldHelper");
    }
    return "";
  }
}
