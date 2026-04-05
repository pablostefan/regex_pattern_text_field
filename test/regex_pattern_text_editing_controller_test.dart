import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:regex_pattern_text_field/controllers/regex_pattern_text_editing_controller.dart';
import 'package:regex_pattern_text_field/models/regex_pattern_matched.dart';
import 'package:regex_pattern_text_field/models/regex_pattern_text_style.dart';

void main() {
  const customStyle = RegexPatternTextStyle<Object?>(
    type: 'custom',
    regexPattern: r'%+([a-zA-Z]+)',
    textStyle: TextStyle(color: Colors.pink),
  );

  group('RegexPatternTextEditingController', () {
    test(
      'GIVEN custom style WHEN getting matched list THEN returns typed match',
      () {
        // Given
        final controller = RegexPatternTextEditingController();
        controller.setRegexPatternStyle(const [customStyle], false);

        // When
        controller.text = 'prefix %token suffix';
        final matches = controller.regexPatternMatchedList;

        // Then
        expect(matches, hasLength(1));
        expect(matches.first.type, 'custom');
        expect(matches.first.text, '%token');
      },
    );

    test(
      'GIVEN token match at cursor WHEN value changes THEN onMatch is fired',
      () {
        // Given
        final controller = RegexPatternTextEditingController();
        controller.setRegexPatternStyle(const [customStyle], false);

        RegexPatternMatched<Object?>? captured;
        controller.setOnMatch((match) => captured = match);

        // When
        controller.value = const TextEditingValue(
          text: '%token',
          selection: TextSelection.collapsed(offset: 6),
        );

        // Then
        expect(captured, isNotNull);
        expect(captured!.text, '%token');
        expect(captured!.type, 'custom');
      },
    );

    test(
      'GIVEN token without match WHEN value changes THEN onNonMatch is fired',
      () {
        // Given
        final controller = RegexPatternTextEditingController();
        controller.setRegexPatternStyle(const [customStyle], false);

        String? captured;
        controller.setOnNonMatch((value) => captured = value);

        // When
        controller.value = const TextEditingValue(
          text: 'plain',
          selection: TextSelection.collapsed(offset: 5),
        );

        // Then
        expect(captured, 'plain');
      },
    );

    test(
      'GIVEN cursor on whitespace WHEN value changes THEN no callbacks are fired',
      () {
        // Given
        final controller = RegexPatternTextEditingController();
        controller.setRegexPatternStyle(const [customStyle], false);

        RegexPatternMatched<Object?>? onMatchValue;
        String? onNonMatchValue;
        controller.setOnMatch((match) => onMatchValue = match);
        controller.setOnNonMatch((value) => onNonMatchValue = value);

        // When
        controller.value = const TextEditingValue(
          text: 'hello  world',
          selection: TextSelection.collapsed(offset: 6),
        );

        // Then
        expect(onMatchValue, isNull);
        expect(onNonMatchValue, isNull);
      },
    );

    test(
      'GIVEN tabs and line breaks WHEN matching at cursor THEN token is extracted correctly',
      () {
        // Given
        final controller = RegexPatternTextEditingController();
        controller.setRegexPatternStyle(const [customStyle], false);

        RegexPatternMatched<Object?>? captured;
        controller.setOnMatch((match) => captured = match);

        // When
        controller.value = const TextEditingValue(
          text: 'line1\n\t%token\tline2',
          selection: TextSelection.collapsed(offset: 13),
        );

        // Then
        expect(captured, isNotNull);
        expect(captured!.text, '%token');
      },
    );

    test(
      'GIVEN case-sensitive style WHEN global match is insensitive THEN style type can be null',
      () {
        // Given
        final controller = RegexPatternTextEditingController();
        controller.setRegexPatternStyle(const [
          RegexPatternTextStyle<Object?>(
            type: 'strict',
            regexPattern: r'ABC',
            textStyle: TextStyle(color: Colors.purple),
            caseSensitive: true,
          ),
        ], false);

        // When
        controller.text = 'abc';
        final matches = controller.regexPatternMatchedList;

        // Then
        expect(matches, hasLength(1));
        expect(matches.first.type, isNull);
      },
    );

    test(
      'GIVEN empty style list WHEN querying matches THEN returns empty list',
      () {
        // Given
        final controller = RegexPatternTextEditingController();
        controller.setRegexPatternStyle(const [], false);

        // When
        controller.text = '%token';
        final matches = controller.regexPatternMatchedList;

        // Then
        expect(matches, isEmpty);
      },
    );

    test(
      'GIVEN no styles WHEN building text span THEN all text stays unstyled',
      () {
        // Given
        final controller = RegexPatternTextEditingController();
        controller.setRegexPatternStyle(const [], false);
        controller.text = 'plain text';

        // When
        final span = controller.buildTextSpan(
          context: null,
          style: const TextStyle(color: Colors.black),
          withComposing: false,
        );

        // Then
        final children = span.children ?? <InlineSpan>[];
        expect(children, hasLength(1));
        expect((children.first as TextSpan).text, 'plain text');
      },
    );

    test(
      'GIVEN matching and non-matching text WHEN building text span THEN keeps segment boundaries',
      () {
        // Given
        final controller = RegexPatternTextEditingController();
        controller.setRegexPatternStyle(const [
          RegexPatternTextStyle<Object?>(
            type: 'custom',
            regexPattern: r'%+([a-zA-Z]+)',
            textStyle: TextStyle(color: Colors.red),
          ),
        ], false);
        controller.text = 'mail %token tail';

        // When
        final span = controller.buildTextSpan(
          context: null,
          style: const TextStyle(color: Colors.black),
          withComposing: false,
        );

        // Then
        final children = span.children ?? <InlineSpan>[];
        expect(children, hasLength(3));
        expect((children[0] as TextSpan).text, 'mail ');
        expect((children[1] as TextSpan).text, '%token');
        expect((children[2] as TextSpan).text, ' tail');
        expect((children[1] as TextSpan).style?.color, Colors.red);
      },
    );
  });
}
