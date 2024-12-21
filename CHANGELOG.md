## [1.0.0] - First release
    * First release of the project.

## [1.0.1] - Added new regex patterns
    * github = r'((git|ssh|http(s)?)|(git@[\w\.]+))(:(\/\/)?)([\w\.@\:/\-~]+)(\.git)(\/)?'
    * twitter = r'(?:(?:twitter?|tw): @)+[\w/\-_?=%.]+'
    * facebook = r'(?:(?:facebook?|fb?|Facebook): @)+[\w/\-_?=%.]+'
    * instagram = r'(?:(?:instagram?|insta?|Instagram): @)+[\w/\-_?=%.]+'
    * dateTime = r'\d{1,2} [a-zA-Z]{3} \d{4}'
    * phone = r'\(?\+[0-9]{1,3}\)? ?-?[0-9]{1,3} ?-?[0-9]{3,5} ?-?[0-9]{4}( ?-?[0-9]{3})? ?(\w{1,10}\s?\d{1,6})?'
    * email = r'([a-z0-9]+([-+._][a-z0-9]+){0,2}@.*?(\.(a(?:[cdefgilmnoqrstuwxz]|ero|(?:rp|si)a)|b(?:[abdefghijmnorstvwyz]iz)|c(?:[acdfghiklmnoruvxyz]|at|o(?:m|op))|d[ejkmoz]|e(?:[ceghrstu]|du)|f[ijkmor]|g(?:[abdefghilmnpqrstuwy]|ov)|h[kmnrtu]|i(?:[delmnoqrst]|n(?:fo|t))|j(?:[emop]|obs)|k[eghimnprwyz]|l[abcikrstuvy]|m(?:[acdeghklmnopqrstuvwxyz]|il|obi|useum)|n(?:[acefgilopruz]|ame|et)|o(?:m|rg)|p(?:[aefghklmnrstwy]|ro)|qa|r[eosuw]|s[abcdeghijklmnortuvyz]|t(?:[cdfghjklmnoprtvwz]|(?:rav)?el)|u[agkmsyz]|v[aceginu]|w[fs]|y[etu]|z[amw])\b){1,2})'

## [1.0.2] - Added regexPatternMatchedList on RegexPatternTextEditingController
    * Added regexPatternMatchedList on RegexPatternTextEditingController

## [1.0.3] - Change onChanged on RegexPatternTextField
    * final Function(List<RegexPatternMatched> regexPatternMatchedList, String text)? onChanged;

## [1.0.4] - Change onSubmitted on RegexPatternTextField
    * final Function(List<RegexPatternMatched> regexPatternMatchedList, String text)? onSubmitted;

## [1.0.5] - Updated README.md
    * Updated README.md

## [1.0.6] - Add changes to example
    * Add changes to example

## [1.0.7] - Change Email Regex Pattern
    * Change email regex pattern (https://www.ex-parrot.com/pdw/Mail-RFC822-Address.html)

## [1.0.8] - Improved Documentation and Features
    * Updated README.md with:
        * Detailed usage examples and advanced patterns.
        * Clarifications for callbacks (`onMatch`, `onNonMatch`, `onChanged`, `onSubmitted`).
        * Customization options for combining default and custom styles.

## [1.0.9] - Improved Documentation and Features
### Added
- Updated `README.md` with:
    - Detailed usage examples and advanced patterns.
    - Clarifications for callbacks (`onMatch`, `onNonMatch`, `onChanged`, `onSubmitted`).
    - Customization options for combining default and custom styles.
- Enhanced example application with dynamic match listing.

### Changed
- Refactored example code for improved readability and usability:
    - Introduced dynamic feedback for pattern matches.
    - Improved text field handling for large inputs.
- Optimized `RegexPatternTextField` for better performance and accuracy in regex matching.

### Fixed
- Minor bugs in regex pattern processing.
