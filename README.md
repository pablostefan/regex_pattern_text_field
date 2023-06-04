# Regex Pattern Text Field

The `RegexPatternTextField` is a custom Flutter widget that allows you to perform pattern matching and apply styles to matched patterns in a text field. It is particularly useful when you want to highlight specific patterns or extract information from user input.


![regex_pattern_text_field](https://github.com/pablostefan/regex_pattern_text_field/blob/db768f72a0df00f304929da44b5753de3c27ddd7/readme_contents/regex_pattern_text_field_image.png)

## Usage

To use the `RegexPatternTextField`, follow these steps:

1. Add the `regex_pattern_text_field` package to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     regex_pattern_text_field: ^1.0.0
   ```

Then, run `flutter pub get` to fetch the package.

2. Import the required packages:

   ```dart
   import 'package:flutter/material.dart';
   import 'package:regex_pattern_text_field/regex_pattern_text_field.dart';
   ```

3. Use the `RegexPatternTextField` widget in your application:

   ```dart
   RegexPatternTextField(
     onNonMatch: (String text) {
       // Logic for handling non-matches
     },
     onMatch: (RegexPatternMatchedText model) {
       // Logic for handling matches
       // Access the matched text and other details using the `model` object
     },
     regexPatternStyles: [
       RegexPatternTextStyle(
         regexPattern: r'\bexample\b',
         textStyle: TextStyle(color: Colors.blue),
       ),
       // Add more pattern styles as needed
     ],
     // Other properties...
   )
   ```
   Replace the standard `TextField` widget with `RegexPatternTextField`. Set the `onNonMatch` and `onMatch` properties to provide custom logic for handling non-matches and matches, respectively. The `model` object passed to the `onMatch` callback provides information about the matched text, such as the text itself, start and end indices, and the matching pattern.

   Define the regex pattern styles using the `regexPatternStyles` property. It expects a list of `RegexPatternTextStyle` objects, where each object contains a regular expression pattern (`regexPattern`) and a text style (`textStyle`) to be applied to the matched text. The `regexPattern` should be a valid regex pattern string.

   You can also customize the appearance and behavior of the `RegexPatternTextField` using its various properties, such as `decoration`, `keyboardType`, `textInputAction`, etc.

## Customization

The `RegexPatternTextEditingController` provides the following customization options:

- `setOnMatch`: Set a callback function that will be called when a pattern match occurs. Pass a function that takes a `RegexPatternMatchedText` object as a parameter. This object contains details about the matched text, such as the text itself, start and end indices, and the matching pattern.

- `setOnNonMatch`: Set a callback function that will be called when a non-match occurs. Pass a function that takes a `String` parameter representing the non-matched text.

- `setRegexPatternStyle`: Set the regex pattern styles using a list of `Regex

## Example

Here's an example of how to use the `RegexPatternTextField`:

```dart
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
                  defaultRegexPatternStyles: true,
                  // Set to 'false' to disable default pattern styles
                  // Set to 'true' to enable default pattern styles
                  regexPatternStyles: [
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
                     // Callback for non-matches
                     // print("Non-match: $text");
                  },
                  onMatch: (RegexPatternMatchedText model) {
                     // Callback for matches
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
```

In this example, we have a `HomePage` widget that uses the `RegexPatternTextField` widget. The `RegexPatternTextField` widget is wrapped in a `Center` widget and placed in the body of the `Scaffold`.

The `RegexPatternTextField` widget has two callback functions: `onNonMatch` and `onMatch`. When a non-match occurs, the `onNonMatch` function is called with the non-matched text as a parameter. Similarly, when a match occurs, the `onMatch` function is called with a `RegexPatternMatchedText` object containing details about the matched text.

In this example, we simply print the non-matched and matched texts to the console. However, you can customize these functions to perform any desired actions based on the pattern matches and non-matches.

The `MyApp` widget is the root widget of the application and sets the `HomePage` as the home screen of the app.

Please note that you will need to import the necessary packages and ensure that the `regex_pattern_text_field` package is added to your `pubspec.yaml` file for this code to work correctly.
