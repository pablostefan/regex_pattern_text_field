# Decision Record

Date: 2026-04-05
Status: Approved

## 1) Minimum Baseline Lock

- Dart SDK constraint target: >=3.8.0 <4.0.0
- Flutter constraint target: >=3.35.0

Rationale:
- Aligns package with modern stable Flutter/Dart while keeping broad compatibility across recent stable releases.

## 2) Release Strategy

- Release type: minor release with deprecations and migration notes.
- Policy: preserve source compatibility when possible; if behavior/API needs modernization, keep legacy entry points as deprecated compatibility shims.

## 3) Typed API Policy

- Replace public dynamic model fields with generic/Object?-typed contracts.
- Keep default generic behavior so existing call sites continue compiling without mandatory migration.

## 4) Performance Track Criteria

- Go condition for optimization in this cycle:
  - Measurable bottleneck evidence in repository-owned profile/benchmark data, and
  - Clear minimal-risk change with regression tests proving no behavior drift.
- Current cycle decision: no-op (go condition not met).
