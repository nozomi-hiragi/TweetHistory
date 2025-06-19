# GitHub Copilot Custom Instructions

## @versionup - Version Update Action

**Usage:** `@versionup X.X.X`

**Description:** Automatically updates the application version across all platform-specific configuration files.

**Example:** `@versionup 0.3.0`

### Files Updated:

1. **pubspec.yaml** (line 19)
   ```yaml
   version: X.X.X+1
   ```

2. **ios/Runner.xcodeproj/project.pbxproj** (3 locations)
   ```objc
   MARKETING_VERSION = X.X.X;
   ```

3. **windows/runner/Runner.rc** (line 72)
   ```c
   #define VERSION_AS_STRING "X.X.X"
   ```

### Implementation Steps:

1. Parse the target version from the command
2. Update `pubspec.yaml` version field (maintain +1 build number)
3. Find and replace all `MARKETING_VERSION` values in iOS project file
4. Update the Windows resource file fallback version string
5. Verify all changes are consistent across platforms

### Validation:

- Ensure version follows semantic versioning (X.X.X format)
- Maintain the +1 build number suffix in pubspec.yaml
- Verify no syntax errors in modified configuration files
- Confirm all platform builds can read the version correctly

### Notes:

- Android, macOS, and web platforms automatically inherit version from pubspec.yaml
- iOS and Windows require explicit version updates due to platform-specific build configurations
- Always test builds after version changes to ensure compatibility