import 'package:flutter/material.dart';
import 'package:regex_pattern_text_field/regex_pattern_text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regex Pattern Text Field'),
      ),
      body: Center(
        child: RegexPatternTextField(
          defaultRegexPatternStyles: true,
          // Set to 'false' to disable default pattern styles
          // Set to 'true' to enable default pattern styles
          regexPatternStyles: [
            RegexPatternTextStyle(
              type: 'example',
              regexPattern: r'\example\b',
              textStyle: const TextStyle(color: Colors.blue),
            ),
            RegexPatternTextStyle(
              type: RegexPatternType.mention,
              regexPattern: "@+([-a-zA-Z0-9]+)",
              textStyle: const TextStyle(color: Colors.blue),
            ),
            // Add more pattern styles as needed
          ],
          onNonMatch: (String text) {
            // Callback for non-matches
            print("Non-match: $text");
          },
          onMatch: (RegexPatternMatchedText model) {
            // Callback for matches
            print("Matched: ${model.text}");
            // The 'model' object represents the matched text and its properties.
            // It has the following attributes:
            // - text: The matched text string.
            // - start: The starting index of the matched text within the entered text.
            // - end: The ending index of the matched text within the entered text.
            // - pattern: The regular expression pattern used for matching.

            // Additionally, it has a dynamic 'type' attribute that can be used to validate the type of the matched text.
            // You can access it as: model.type
            // The 'type' attribute can be of any data type, and its usage depends on your application's specific needs.
            // For example, you can use it to assign different types to different patterns and perform type-specific actions.
            // It provides flexibility in handling matched text based on its type.
          },
        ),
      ),
    );
  }
}
