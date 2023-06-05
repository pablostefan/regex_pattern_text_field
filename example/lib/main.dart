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
      debugShowCheckedModeBanner: false,
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
  final RegexPatternTextEditingController _controller = RegexPatternTextEditingController();

  List<RegexPatternMatched> allMatches = [];

  @override
  void initState() {
    _controller.addListener(() => setState(() => allMatches = _controller.regexPatternMatchedList));
    // Access allMatches to get the list of RegexPatternMatched using _controller.regexPatternMatchedList
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regex Pattern Text Field'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: RegexPatternTextField(
            maxLines: null,
            regexPatternController: _controller,
            // Controller for the text field that will store the user-entered text.
            onSubmitted: (List<RegexPatternMatched> matches, String text) {
              // Function called when the user submits the text by pressing the "Enter" key or "Submit" button.
              // The 'matches' list contains the corresponding regex patterns matched in the entered text.
              print(matches);
            },
            onChanged: (List<RegexPatternMatched> matches, String text) {
              // Function called whenever the text in the text field is changed.
              // The 'matches' list contains the corresponding regex patterns matched in the updated text.
              print(matches);
            },
            defaultRegexPatternStyles: true,
            // Set to 'false' to disable default pattern styles
            // Set to 'true' to enable default pattern styles
            regexPatternStyles: [
              // Defines the styles for different regex patterns to be applied to the matched text.
              // Each 'RegexPatternTextStyle' object represents a pattern style.
              RegexPatternTextStyle(
                type: "github",
                regexPattern: RegexPatternHelper.github,
                textStyle: const TextStyle(color: Colors.redAccent),
              ),
              RegexPatternTextStyle(
                type: "facebook",
                regexPattern: RegexPatternHelper.facebook,
                textStyle: const TextStyle(color: Colors.lightGreen),
              ),
              RegexPatternTextStyle(
                type: "twitter",
                regexPattern: RegexPatternHelper.twitter,
                textStyle: const TextStyle(color: Colors.deepOrangeAccent),
              ),
              RegexPatternTextStyle(
                type: "instagram",
                regexPattern: RegexPatternHelper.instagram,
                textStyle: const TextStyle(color: Colors.brown),
              ),
              RegexPatternTextStyle(
                type: "phone",
                regexPattern: RegexPatternHelper.phone,
                textStyle: const TextStyle(color: Colors.amber),
              ),
              RegexPatternTextStyle(
                type: "date",
                regexPattern: RegexPatternHelper.dateTime,
                textStyle: const TextStyle(color: Colors.red),
              ),
              RegexPatternTextStyle(
                type: "myRegexPattern",
                regexPattern: "%+([a-zA-Z]+)",
                textStyle: const TextStyle(color: Colors.pink),
              ),
              // Add more pattern styles as needed
            ],
            onNonMatch: (String text) {
              // Callback for non-matches (when no regex pattern is matched in the text).
              print("Non-match: $text");
            },
            onMatch: (RegexPatternMatched model) {
              // Callback for matches (when a regex pattern is matched in the text).
              if (model.type == "myRegexPattern") print("Is my regex pattern");
              print("Match text: ${model.text}");
              print("type: ${model.type}");
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
      ),
    );
  }
}
