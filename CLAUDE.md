# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

TweetHistory is a Flutter web application for viewing and organizing Twitter archive data from `tweets.js` files. The project uses Japanese for UI and documentation.

## Development Commands

```bash
# Essential commands
flutter pub get
dart run build_runner build
flutter test
flutter analyze
flutter run -d web-server --web-port 3000
```

## Architecture

### State Management Flow
The application follows a layered architecture with **Riverpod** for state management:

```
UI Widget → ref.watch(provider) → Controller → Repository → Storage Layer
```

**Key Patterns:**
- `FutureProvider` for async repositories and initialization
- `NotifierProvider` for state controllers that extend `Notifier<State>`
- Dependency injection through `ref.read()` in provider constructors
- Centralized initialization via `initializationProvider`

### Key Architecture
- **Data Models**: Freezed for immutability (`Tweet`, `Tag`, state objects)
- **Storage**: IndexedDB via `idb_shim` with repository pattern
- **Special Patterns**: Soft delete ("bin" tag), tag-based organization

## Key Dependencies
- **State Management**: `hooks_riverpod` + `flutter_hooks`
- **Code Generation**: `freezed` + `json_serializable` + `build_runner`
- **Storage**: `idb_shim` (IndexedDB), `shared_preferences`
- **LLM Integration**: `langchain` + `langchain_ollama` for AI-powered tweet rating
- **Testing**: `ProviderContainer` overrides, `idbFactoryMemory`

## Version Management

When updating the application version, the following files must be modified:

1. **pubspec.yaml** (line 19): `version: X.X.X+1`
2. **ios/Runner.xcodeproj/project.pbxproj**: All instances of `MARKETING_VERSION = X.X.X;`
3. **windows/runner/Runner.rc** (line 72): `#define VERSION_AS_STRING "X.X.X"`

**Example for version 0.2.1:**
```yaml
# pubspec.yaml
version: 0.2.1+1
```

```objc
// iOS project.pbxproj (3 locations)
MARKETING_VERSION = 0.2.1;
```

```c
// Windows Runner.rc
#define VERSION_AS_STRING "0.2.1"
```

**Note:** Android, macOS, and web builds automatically use the version from `pubspec.yaml` via Flutter's build system.

## Internationalization (i18n)

This project supports multiple languages through Flutter's internationalization framework:

### Localization
**CRITICAL:** All user text MUST use `AppLocalizations.of(context)!` - never hardcode strings.

```dart
// ✅ Correct
final l10n = AppLocalizations.of(context)!;
Text(l10n.version)
```

Files: `lib/l10n/app_ja.arb` (primary), `lib/l10n/app_en.arb`

Generate localization: `flutter gen-l10n`

## LLM Tweet Rating System

### Overview
AI-powered tweet evaluation system using Ollama LLM for content risk assessment and automatic tagging.

**Platform Support**: Desktop-only feature (hidden on web builds via `!kIsWeb` condition).

### Key Components
- **Rating Function**: `lib/utils/llm_rating.dart` - Core LLM interaction
- **Dialogs**: `lib/common/dialogs/llm_rating_*.dart` - User interface components
- **Integration**: App bar button triggers evaluation of filtered tweets

### Implementation Features
- **Initialization Optimization**: Dummy request ("1+1=") prevents first-request delays
- **Progress Tracking**: Real-time progress with moving average time estimation
- **Filter Awareness**: Evaluates only currently visible/filtered tweets
- **Multilingual Support**: Tag names and UI adapt to language settings
- **Risk Categories**: Automatic tagging based on 0-10 risk scores:
  - 8-10: High Risk (Delete Recommended)
  - 5-7: Medium Risk (Delete Recommended)
  - 3-4: Low Risk (Delete Recommended)
  - 0-2: Keep Recommended

### Architecture Patterns
- **Dialog Separation**: Confirmation and progress dialogs in separate files
- **StatefulWidget → HookWidget**: Consistent with codebase patterns
- **Parameterized Localization**: Tag names passed from l10n context to avoid async access issues

## Development Notes
- Run `dart run build_runner build` after Freezed model changes
- IndexedDB data persists in browser dev tools
- Use `flutter gen-l10n` after ARB file changes

## Design Philosophy

**Core Principles:**
1. **Simplicity over Complexity**: Prefer existing Flutter components over custom implementations
2. **Component Extraction**: Create reusable widgets in separate files rather than private methods
3. **Behavioral Polymorphism**: Same UI elements behave differently based on context
4. **Essential Error Handling**: Focus on critical cases, avoid verbose try-catch blocks

**Key Patterns:**
- Reuse existing callbacks (`onSelected`, `onDeleted`) with contextual behavior
- Extract reusable UI components (e.g., `TagStateChip`) to separate files
- Keep simple logic inline, extract complex reusable UI
- Maintain visual consistency while varying behavior