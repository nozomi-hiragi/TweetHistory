# AGENTS Instructions

This file provides guidelines for working with the TweetHistory repository.

## Development

- Format Dart and Flutter code before committing:
  ```sh
  dart format .
  ```
- Analyze for static issues:
  ```sh
  flutter analyze
  ```
- Run the test suite:
  ```sh
  flutter test
  ```
- Generate `*.freezed.dart` and `*.g.dart` files:
  ```sh
  flutter pub run build_runner build --delete-conflicting-outputs
  ```

## Version Updates

To update the application version (e.g., from 0.2.0 to 0.2.1):

1. **Main version file:**
   ```yaml
   # pubspec.yaml (line 19)
   version: 0.2.1+1
   ```

2. **iOS platform-specific version:**
   ```bash
   # ios/Runner.xcodeproj/project.pbxproj (3 locations)
   # Replace all instances of:
   MARKETING_VERSION = 0.2.0;
   # With:
   MARKETING_VERSION = 0.2.1;
   ```

3. **Windows fallback version:**
   ```c
   // windows/runner/Runner.rc (line 72)
   #define VERSION_AS_STRING "0.2.1"
   ```

**Automation:** Use `@versionup X.X.X` with GitHub Copilot to automatically update all version references.

## Contribution Guidelines

- Keep commit messages concise and descriptive.
- Document new features or changes in `docs/` when relevant.
- Ensure CI workflows pass before submitting a pull request.

