# Profile Baseline

Date: 2026-04-05

## Scope

- Hot path under review: matching and style resolution in RegexPatternTextEditingController.
- Current behavior: each match resolves style by scanning configured styles and building a RegExp per style in helper lookup.

## Observations

- No benchmark harness currently exists in repository for micro-performance profiling.
- Existing package behavior is functionally correct but optimized for readability over measured throughput.
- No user-reported regression or issue in docs indicates a performance bottleneck as a release blocker.

## Baseline Decision Input

- Because no measured bottleneck is currently demonstrated and there is no profile harness, optimization work remains gated.
- Planned action: avoid speculative performance refactors in this cycle.
