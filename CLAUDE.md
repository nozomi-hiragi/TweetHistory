# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

TweetHistory is a Flutter web application for viewing and organizing Twitter archive data from `tweets.js` files. The project uses Japanese for UI and documentation.

## Development Commands

### Setup & Code Generation
```bash
flutter pub get
dart run build_runner build  # Generate freezed/json_serializable code
dart run build_runner watch  # Watch mode for development
dart run build_runner build --delete-conflicting-outputs  # Clean rebuild
```

### Testing & Quality
```bash
flutter test                    # Run all tests
flutter test test/repository/   # Run specific test directory
flutter analyze                 # Static analysis
dart run custom_lint           # Custom linting rules
```

### Build & Run
```bash
flutter run -d chrome --web-port 3000  # Run on web (port 3000)
flutter build web                      # Build for web deployment
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

### Data Models & Code Generation
All data models use **Freezed** for immutability and code generation:

- Domain models: `Tweet`, `Tag` with multiple constructors (e.g., `fromRawJson` for Twitter API data)
- State objects: `TweetState`, `SelectionState` for UI state management
- Automatic generation of `copyWith`, `==`, `hashCode`, and JSON serialization

### Storage Architecture
Uses **IndexedDB** via `idb_shim` for cross-platform storage:

```
tweet_db (v2)
├── tweets (id: primary key)
├── tags (name: primary key)
└── deleted (id: primary key)
```

**Repository Pattern:**
- `TweetRepository`: Core tweet operations with IndexedDB
- `PreferencesRepository`: App settings with SharedPreferences  
- `DataTransferRepository`: Import/export functionality
- Repositories handle multiple storage backends atomically

### Special Architectural Decisions

1. **Soft Delete Pattern**: Deleted tweets are moved to "bin" tag and tracked separately
2. **Tag-Based Organization**: Flexible tagging system with special handling for system tags
3. **Cross-Platform Storage**: Unified storage API using `idb_shim` for web and native
4. **Data Migration**: Built-in schema migration logic (see `_ensureCountFields`)

## Testing Patterns

- **Provider Testing**: Uses `ProviderContainer` with overrides for isolation
- **Repository Testing**: Uses `idbFactoryMemory` for in-memory IndexedDB
- **State Testing**: Tests controller behavior and state transitions
- Explicit migration testing for data schema changes

## Key Dependencies

- **State Management**: `hooks_riverpod` + `flutter_hooks`
- **Code Generation**: `freezed` + `json_serializable` + `build_runner`
- **Storage**: `idb_shim` (IndexedDB), `shared_preferences` (settings)
- **Linting**: `custom_lint` + `riverpod_lint`

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

### Language Support
- **Japanese (ja)**: Primary language for UI and documentation
- **English (en)**: Secondary language support

### Localization Guidelines

**IMPORTANT:** All user-visible text MUST be internationalized using the `AppLocalizations` system. Never use hardcoded strings in UI components.

#### Adding New Text
1. Add the key-value pair to both `lib/l10n/app_ja.arb` and `lib/l10n/app_en.arb`
2. Use descriptive keys (e.g., `version`, `license`, `settings`)
3. Include `@description` metadata in English .arb file for context

#### Using Localized Text
```dart
// ❌ Wrong - hardcoded string
Text('バージョン')

// ✅ Correct - localized
final l10n = AppLocalizations.of(context)!;
Text(l10n.version)
```

#### Code Generation
Run `flutter gen-l10n` or `flutter pub get` to regenerate localization files after adding new keys.

### Localization Files
- `lib/l10n/app_ja.arb`: Japanese translations
- `lib/l10n/app_en.arb`: English translations with descriptions
- Generated files are in `lib/l10n/` (auto-generated, do not edit)

## Development Notes

- Always run `dart run build_runner build` after modifying Freezed models
- Use `flutter run -d chrome` for web development
- IndexedDB data persists between sessions in browser dev tools
- The app handles Twitter archive JSON format with timezone conversion

## Design Philosophy Notes

### Tag Edit Mode Implementation (December 2024)

**Claude's Initial Approach vs User's Preferred Implementation:**

**Claude's Design:**
- Complex TagChip with multiple UI modes (`_buildEditModeChip` vs `_buildNormalChip`)
- Popup menus and bottom sheets for tag editing
- Separate visual styling for edit mode
- More elaborate interaction patterns

**User's Preferred Design:**
- Simple, unified TagChip using existing FilterChip component
- Elegant reuse of existing `onSelected` and `onDeleted` callbacks
- `onSelected` behavior changes contextually based on `isEditMode`
- `onDeleted` only appears in edit mode
- Clean, minimal code with maximum reuse

**Key Insights:**
1. **Simplicity over Complexity**: User prefers leveraging existing Flutter components rather than building custom UI
2. **Behavioral Polymorphism**: Same UI element (FilterChip) behaves differently based on context rather than having separate implementations
3. **Code Reuse**: Maximizing use of existing patterns and callbacks rather than introducing new interaction paradigms
4. **UI Consistency**: Maintaining visual consistency by reusing the same component with different behaviors

**Technical Implementation:**
```dart
// User's elegant approach:
onSelected: (v) => isEditMode ? onRename?.call() : onSelected?.call(v),
onDeleted: isEditMode ? onDelete : null,

// vs Claude's complex approach with separate widgets and popup menus
```

**Backward Compatibility Notes:**
- User removed the legacy `isSelectionMode` getter, simplifying the state model
- Removed legacy `toggle()` method, keeping only `toggleEditMode()`
- Cleaner state management without backward compatibility cruft

This demonstrates the principle of "simple solutions are often better solutions" and the value of understanding existing Flutter patterns before building custom ones.