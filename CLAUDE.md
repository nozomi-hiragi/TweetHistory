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

## Development Notes

- Always run `dart run build_runner build` after modifying Freezed models
- Use `flutter run -d chrome` for web development
- IndexedDB data persists between sessions in browser dev tools
- The app handles Twitter archive JSON format with timezone conversion