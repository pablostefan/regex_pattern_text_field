# Compatibility Checklist

Date: 2026-04-05

## Toolchain Baseline Snapshot

- Installed local toolchain: Flutter 3.41.6, Dart 3.11.4.
- Current package constraints before upgrade:
  - Root: sdk >=3.0.1 <4.0.0, flutter >=1.17.0
  - Example: sdk >=3.0.1 <4.0.0

## Public API Compatibility Surface

- Primary exported APIs:
  - RegexPatternTextEditingController
  - RegexPatternTextField
  - RegexPatternMatched
  - RegexPatternTextStyle
  - RegexPatternHelper
  - RegexPatternType

## Compatibility Commitments

- Keep current named parameters and callback behavior source-compatible where possible.
- Prefer additive typing improvements over removals.
- Use deprecation annotations for migration hints instead of abrupt breaking changes.

## Known Compatibility Risks and Mitigations

- Risk: Deprecated Flutter symbols in public widget constructor.
  - Mitigation: Introduce modern replacements and keep compatibility shim parameters that are no-op/deprecated.
- Risk: Dynamic type fields make callback contracts weakly typed.
  - Mitigation: Move public models to generics with Object?-typed defaults to preserve existing call sites.

## Validation Targets

- flutter pub get (root and example)
- flutter analyze (root and example)
- flutter test (root and example)
