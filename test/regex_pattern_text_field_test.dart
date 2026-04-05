import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:regex_pattern_text_field/regex_pattern_text_field.dart';

void main() {
  const customStyle = RegexPatternTextStyle<Object?>(
    type: 'custom',
    regexPattern: r'%+([a-zA-Z]+)',
    textStyle: TextStyle(color: Colors.red),
  );

  group('RegexPatternTextField', () {
    testWidgets(
      'GIVEN custom pattern WHEN user types THEN onChanged returns text and matches',
      (tester) async {
        // Given
        List<RegexPatternMatched<Object?>> capturedMatches = const [];
        String? capturedText;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RegexPatternTextField(
                regexPatternStyles: const [customStyle],
                defaultRegexPatternStyles: false,
                onChanged: (matches, text) {
                  capturedMatches = matches;
                  capturedText = text;
                },
              ),
            ),
          ),
        );

        // When
        await tester.enterText(find.byType(TextField), '%token');
        await tester.pump();

        // Then
        expect(capturedText, '%token');
        expect(capturedMatches, hasLength(1));
        expect(capturedMatches.first.type, 'custom');
      },
    );

    testWidgets(
      'GIVEN text input action done WHEN user submits THEN onSubmitted receives aggregated matches',
      (tester) async {
        // Given
        List<RegexPatternMatched<Object?>> submittedMatches = const [];
        String? submittedText;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RegexPatternTextField(
                textInputAction: TextInputAction.done,
                regexPatternStyles: const [customStyle],
                defaultRegexPatternStyles: false,
                onSubmitted: (matches, text) {
                  submittedMatches = matches;
                  submittedText = text;
                },
              ),
            ),
          ),
        );

        // When
        await tester.enterText(find.byType(TextField), '%token');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        // Then
        expect(submittedText, '%token');
        expect(submittedMatches, hasLength(1));
        expect(submittedMatches.first.text, '%token');
      },
    );

    testWidgets(
      'GIVEN onMatch callback WHEN matching text is typed THEN callback is forwarded by widget',
      (tester) async {
        // Given
        RegexPatternMatched<Object?>? captured;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RegexPatternTextField(
                regexPatternStyles: const [customStyle],
                defaultRegexPatternStyles: false,
                onMatch: (model) => captured = model,
              ),
            ),
          ),
        );

        // When
        await tester.enterText(find.byType(TextField), '%token');
        await tester.pump();

        // Then
        expect(captured, isNotNull);
        expect(captured!.text, '%token');
        expect(captured!.type, 'custom');
      },
    );

    testWidgets(
      'GIVEN onNonMatch callback WHEN plain text is typed THEN callback is forwarded by widget',
      (tester) async {
        // Given
        String? captured;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RegexPatternTextField(
                regexPatternStyles: const [customStyle],
                defaultRegexPatternStyles: false,
                onNonMatch: (value) => captured = value,
              ),
            ),
          ),
        );

        // When
        await tester.enterText(find.byType(TextField), 'plain');
        await tester.pump();

        // Then
        expect(captured, 'plain');
      },
    );

    testWidgets(
      'GIVEN default regex styles enabled WHEN url is typed THEN built-in pattern is matched',
      (tester) async {
        // Given
        final controller = RegexPatternTextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RegexPatternTextField(
                regexPatternController: controller,
                defaultRegexPatternStyles: true,
              ),
            ),
          ),
        );

        // When
        await tester.enterText(
          find.byType(TextField),
          'go to https://flutter.dev now',
        );
        await tester.pump();

        // Then
        final matches = controller.regexPatternMatchedList;
        expect(matches.isNotEmpty, isTrue);
        expect(
          matches.any((match) => match.text.contains('https://flutter.dev')),
          isTrue,
        );
      },
    );

    testWidgets(
      'GIVEN stylusHandwritingEnabled false WHEN widget is built THEN TextField receives same value',
      (tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RegexPatternTextField(stylusHandwritingEnabled: false),
            ),
          ),
        );

        // When
        final textField = tester.widget<TextField>(find.byType(TextField));

        // Then
        expect(textField.stylusHandwritingEnabled, isFalse);
      },
    );
  });
}
