import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:regex_pattern_text_field/helpers/regex_pattern_text_style_helper.dart';
import 'package:regex_pattern_text_field/helpers/regex_pattern_type.dart';
import 'package:regex_pattern_text_field/models/regex_pattern_text_style.dart';

void main() {
  group('RegexPatternTextStyleHelper', () {
    test(
      'GIVEN null style list WHEN finding matching style THEN returns null',
      () {
        // Given
        const String textPart = '%token';

        // When
        final result =
            RegexPatternTextStyleHelper.findMatchingTextStyle<Object?>(
              textPart,
              null,
            );

        // Then
        expect(result, isNull);
      },
    );

    test(
      'GIVEN empty input text WHEN finding matching style THEN returns null',
      () {
        // Given
        const styles = [
          RegexPatternTextStyle<Object?>(
            type: 'custom',
            regexPattern: r'%+([a-zA-Z]+)',
            textStyle: TextStyle(color: Colors.red),
          ),
        ];

        // When
        final result = RegexPatternTextStyleHelper.findMatchingTextStyle(
          '',
          styles,
        );

        // Then
        expect(result, isNull);
      },
    );

    test(
      'GIVEN multiple styles WHEN matching text THEN returns first matching style',
      () {
        // Given
        const styles = [
          RegexPatternTextStyle<Object?>(
            type: 'first',
            regexPattern: r'.*token.*',
            textStyle: TextStyle(color: Colors.red),
          ),
          RegexPatternTextStyle<Object?>(
            type: 'second',
            regexPattern: r'%+([a-zA-Z]+)',
            textStyle: TextStyle(color: Colors.green),
          ),
        ];

        // When
        final result = RegexPatternTextStyleHelper.findMatchingTextStyle(
          '%token',
          styles,
        );

        // Then
        expect(result, isNotNull);
        expect(result!.type, 'first');
      },
    );

    test(
      'GIVEN strict case style WHEN input casing differs THEN does not match',
      () {
        // Given
        const styles = [
          RegexPatternTextStyle<Object?>(
            type: 'strict',
            regexPattern: r'ABC',
            textStyle: TextStyle(color: Colors.blue),
            caseSensitive: true,
          ),
        ];

        // When
        final result = RegexPatternTextStyleHelper.findMatchingTextStyle(
          'abc',
          styles,
        );

        // Then
        expect(result, isNull);
      },
    );

    test(
      'GIVEN default style list WHEN loaded THEN includes all enum pattern types',
      () {
        // Given
        final expectedCount = RegexPatternType.values.length;

        // When
        final defaultStyles =
            RegexPatternTextStyleHelper.defaultTextPartStyleList;

        // Then
        expect(defaultStyles, hasLength(expectedCount));
        for (final type in RegexPatternType.values) {
          expect(defaultStyles.any((style) => style.type == type), isTrue);
        }
      },
    );
  });
}
