import 'package:flutter/material.dart';
import 'package:regex_pattern_text_field/regex_pattern_text_field.dart';

void main() {
  runApp(const RegexPatternDemoApp());
}

class RegexPatternDemoApp extends StatelessWidget {
  const RegexPatternDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Regex Pattern Text Field Demo',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const RegexPatternDemoPage(),
    );
  }
}

class RegexPatternDemoPage extends StatefulWidget {
  const RegexPatternDemoPage({super.key});

  @override
  State<RegexPatternDemoPage> createState() => _RegexPatternDemoPageState();
}

class _RegexPatternDemoPageState extends State<RegexPatternDemoPage> {
  final RegexPatternTextEditingController _controller =
      RegexPatternTextEditingController();

  bool _useDefaultPatterns = true;
  String _lastEvent = 'Type something to see matches.';
  List<RegexPatternMatched<Object?>> _matches = const [];

  static const _customStyles = <RegexPatternTextStyle<Object?>>[
    RegexPatternTextStyle<Object?>(
      type: 'github',
      regexPattern: RegexPatternHelper.github,
      textStyle: TextStyle(color: Colors.redAccent),
    ),
    RegexPatternTextStyle<Object?>(
      type: 'facebook',
      regexPattern: RegexPatternHelper.facebook,
      textStyle: TextStyle(color: Colors.lightGreen),
    ),
    RegexPatternTextStyle<Object?>(
      type: 'twitter',
      regexPattern: RegexPatternHelper.twitter,
      textStyle: TextStyle(color: Colors.deepOrangeAccent),
    ),
    RegexPatternTextStyle<Object?>(
      type: 'instagram',
      regexPattern: RegexPatternHelper.instagram,
      textStyle: TextStyle(color: Colors.brown),
    ),
    RegexPatternTextStyle<Object?>(
      type: 'phone',
      regexPattern: RegexPatternHelper.phone,
      textStyle: TextStyle(color: Colors.amber),
    ),
    RegexPatternTextStyle<Object?>(
      type: 'date',
      regexPattern: RegexPatternHelper.dateTime,
      textStyle: TextStyle(color: Colors.red),
    ),
    RegexPatternTextStyle<Object?>(
      type: 'myRegexPattern',
      regexPattern: r'%+([a-zA-Z]+)',
      textStyle: TextStyle(color: Colors.pink),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_syncMatchesFromController);
    _controller.text =
        'Try: #flutter @user user@mail.com https://flutter.dev %token';
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_syncMatchesFromController)
      ..dispose();
    super.dispose();
  }

  void _syncMatchesFromController() {
    setState(() {
      _matches = _controller.regexPatternMatchedList;
    });
  }

  void _applyPatternMode(bool enabled) {
    setState(() {
      _useDefaultPatterns = enabled;
      _lastEvent = enabled
          ? 'Default patterns enabled.'
          : 'Default patterns disabled.';
    });

    _controller.setRegexPatternStyle(_customStyles, _useDefaultPatterns);
    _syncMatchesFromController();
  }

  void _insertSampleText() {
    const sample =
        'Contact @alice via alice@example.com on 08 Jan 2026 and visit https://github.com';
    _controller.value = _controller.value.copyWith(
      text: sample,
      selection: const TextSelection.collapsed(offset: sample.length),
    );
  }

  void _clearText() {
    _controller.clear();
    setState(() {
      _lastEvent = 'Input cleared.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regex Pattern Text Field Demo')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _useDefaultPatterns,
                onChanged: _applyPatternMode,
                title: const Text('Use default built-in patterns'),
                subtitle: const Text('email, url, hashtag, mention'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  FilledButton.tonal(
                    onPressed: _insertSampleText,
                    child: const Text('Insert sample'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: _clearText,
                    child: const Text('Clear'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              RegexPatternTextField(
                maxLines: 5,
                regexPatternController: _controller,
                defaultRegexPatternStyles: _useDefaultPatterns,
                regexPatternStyles: _customStyles,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      'Type text with @mentions, #tags, emails, urls and %custom.',
                ),
                onChanged: (matches, text) {
                  setState(() {
                    _matches = matches;
                    _lastEvent =
                        'Changed: ${matches.length} match(es) in ${text.length} chars';
                  });
                },
                onSubmitted: (matches, text) {
                  setState(() {
                    _lastEvent =
                        'Submitted: ${matches.length} match(es) in ${text.length} chars';
                  });
                },
                onMatch: (model) {
                  setState(() {
                    _lastEvent =
                        'Match -> text: "${model.text}", type: ${model.type}';
                  });
                },
                onNonMatch: (text) {
                  setState(() {
                    _lastEvent = 'Non-match token: "$text"';
                  });
                },
              ),
              const SizedBox(height: 12),
              Text(
                _lastEvent,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Text(
                'Matches (${_matches.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _matches.isEmpty
                    ? const Center(child: Text('No matches yet.'))
                    : ListView.separated(
                        itemCount: _matches.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final match = _matches[index];
                          return ListTile(
                            dense: true,
                            title: Text(match.text),
                            subtitle: Text(
                              'type: ${match.type} | range: ${match.start}-${match.end}',
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
