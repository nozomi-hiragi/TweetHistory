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

## Development Notes
- Run `dart run build_runner build` after Freezed model changes
- IndexedDB data persists in browser dev tools

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

### Tweet Detail Tag Integration Implementation (January 2025)

**Claude's Initial Approach vs User's Preferred Implementation:**

**Claude's Design:**
- Complex helper function `_getTagStatusForTweet()` separated from usage
- Inline `_buildTagChip()` method within dialog class
- Verbose try-catch blocks with detailed error handling
- Multiple levels of nesting and function separation

**User's Preferred Design:**
- Direct tag status logic inline where needed
- Extracted `TagStateChip` as standalone reusable widget
- Streamlined error handling focused on essential cases
- Cleaner separation: UI components as separate files, logic inline

**Key Insights:**
1. **Component Extraction over Method Inlining**: User prefers creating reusable widgets in separate files rather than private methods within classes
2. **Logic Positioning**: Simple logic should be inline where used, complex reusable UI should be extracted
3. **Code Organization**: Separate files for reusable components vs helper methods within classes
4. **Error Handling**: Focus on essential error cases rather than comprehensive try-catch blocks

**Technical Implementation:**
```dart
// User's approach: Reusable component
// lib/common/tag_state_chip.dart
class TagStateChip extends StatelessWidget { ... }

// Claude's approach: Private method
Widget _buildTagChip(BuildContext context, String tag) { ... }
```

This demonstrates preference for widget extraction over method extraction, and inline logic over helper functions when the logic is straightforward.