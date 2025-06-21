# CLAUDE.md
Purpose: Give Claude Code the minimum facts it needs about this repo.

## Product
**TweetHistory** – Flutter Web app that loads a `tweets.js` Twitter archive and lets users browse, tag, and soft-delete tweets. Primary UI: Japanese.

## Architecture
UI → Riverpod (Notifier / Future) → Repository → IndexedDB (`idb_shim`)  
• Models: Freezed + JSON_serializable  
• DI: `ref.read` only  
• Soft-delete via “bin” tag  
• Desktop builds expose local LLM (see below)

## Key Libraries
hooks_riverpod · flutter_hooks · freezed · build_runner  
idb_shim · shared_preferences · langchain · langchain_ollama

## Special Features
### LLM Tweet Rating  
Desktop-only. `utils/llm_rating.dart` calls Ollama; scores 0-10 and auto-tags visible tweets.

### Internationalization  
All text via `AppLocalizations`; update with `flutter gen-l10n`.

### Responsive Design
768px breakpoint: wide screens show filters (320px sidebar) + tweets side-by-side.  
Use `static const` widgets to prevent rebuilds.

## Dev Checklist
* `dart run build_runner build` after model edits  
* `flutter gen-l10n` after ARB edits  
* `flutter test && flutter analyze` before commit

## Version Bump
Change `pubspec.yaml` → mirror same number in iOS MARKETING_VERSION & Windows Runner.rc. Flutter propagates to Android/macOS/Web automatically.

## Completion Review
For "締め作業": review implementation → update docs → check quality → organize content → document patterns.
