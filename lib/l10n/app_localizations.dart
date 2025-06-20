import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Navigation label for tweets tab
  ///
  /// In en, this message translates to:
  /// **'Tweets'**
  String get navTweets;

  /// Navigation label for bin tab
  ///
  /// In en, this message translates to:
  /// **'Bin'**
  String get navBin;

  /// Navigation label for settings tab
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Shows number of selected items
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selectedCount(int count);

  /// Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Button to apply filter
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// Button to clear filter
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Search button/field text
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Filter button text
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// Add button text
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Done button text
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Button text to add a tag
  ///
  /// In en, this message translates to:
  /// **'Add Tag'**
  String get addTag;

  /// Instruction to select tags
  ///
  /// In en, this message translates to:
  /// **'Select Tags'**
  String get selectTags;

  /// Placeholder for tag name input
  ///
  /// In en, this message translates to:
  /// **'Enter tag name'**
  String get tagNamePlaceholder;

  /// Upload button text
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// Generic error label
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Loading status message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Placeholder text for tweet search
  ///
  /// In en, this message translates to:
  /// **'Search Tweets'**
  String get searchTweets;

  /// Action to restore tweet from bin
  ///
  /// In en, this message translates to:
  /// **'Restore from Bin'**
  String get restoreFromBin;

  /// Error message for invalid tag name
  ///
  /// In en, this message translates to:
  /// **'Invalid tag name'**
  String get invalidTagName;

  /// Button to add new tag
  ///
  /// In en, this message translates to:
  /// **'Add New Tag'**
  String get addNewTag;

  /// Title of tweet details dialog
  ///
  /// In en, this message translates to:
  /// **'Tweet Details'**
  String get tweetDetails;

  /// Label for tweet ID
  ///
  /// In en, this message translates to:
  /// **'Tweet ID'**
  String get tweetId;

  /// Label for tweet post date
  ///
  /// In en, this message translates to:
  /// **'Posted At'**
  String get postedAt;

  /// Label for retweet count
  ///
  /// In en, this message translates to:
  /// **'Retweets'**
  String get retweetCount;

  /// Label for favorite count
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get favoriteCount;

  /// Sort option for newest first
  ///
  /// In en, this message translates to:
  /// **'Newest first'**
  String get sortNewestFirst;

  /// Sort option for oldest first
  ///
  /// In en, this message translates to:
  /// **'Oldest first'**
  String get sortOldestFirst;

  /// Button text to apply tags
  ///
  /// In en, this message translates to:
  /// **'Apply tags'**
  String get applyTag;

  /// Message when item is copied to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copied {item} to clipboard'**
  String copiedToClipboard(String item);

  /// Message when media URL is copied
  ///
  /// In en, this message translates to:
  /// **'Media URL copied to clipboard'**
  String get mediaUrlCopied;

  /// Label for type field
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// Button to open link in browser
  ///
  /// In en, this message translates to:
  /// **'Open in browser'**
  String get openInBrowser;

  /// Label for media section
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get media;

  /// Instruction to choose an action
  ///
  /// In en, this message translates to:
  /// **'Choose an action'**
  String get chooseAction;

  /// Message when data is copied to clipboard
  ///
  /// In en, this message translates to:
  /// **'Data copied to clipboard'**
  String get dataCopiedToClipboard;

  /// Title for tweets file upload
  ///
  /// In en, this message translates to:
  /// **'Upload tweets.js'**
  String get uploadTweetsFile;

  /// Title of settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Settings option for language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Japanese language option
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get languageJapanese;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// System language option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// Settings option for theme
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Label for version information
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Label for license information
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get license;

  /// Label for user ID
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userId;

  /// Placeholder text for user ID field
  ///
  /// In en, this message translates to:
  /// **'user_id'**
  String get userIdPlaceholder;

  /// Alert dialog title
  ///
  /// In en, this message translates to:
  /// **'User ID setting'**
  String get userIdSetting;

  /// Description shown in user ID input dialog
  ///
  /// In en, this message translates to:
  /// **'Please enter your X (Twitter) user ID (without @):'**
  String get userIdDescription;

  /// Example text showing how to extract username from URL
  ///
  /// In en, this message translates to:
  /// **'Example: For https://x.com/username, enter \"username\"'**
  String get userIdExample;

  /// Success message when user ID is cleared
  ///
  /// In en, this message translates to:
  /// **'User ID cleared'**
  String get userIdCleared;

  /// Success message when user ID is set
  ///
  /// In en, this message translates to:
  /// **'User ID set'**
  String get userIdSet;

  /// Status text when a value is not set
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// Settings section for import/export
  ///
  /// In en, this message translates to:
  /// **'Import & Export'**
  String get importExport;

  /// Button to import data
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get importData;

  /// Button to export data
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// Label for edit mode
  ///
  /// In en, this message translates to:
  /// **'Edit Mode'**
  String get editMode;

  /// Button text to exit edit mode
  ///
  /// In en, this message translates to:
  /// **'Exit Edit Mode'**
  String get exitEditMode;

  /// Button text to rename a tag
  ///
  /// In en, this message translates to:
  /// **'Rename Tag'**
  String get renameTag;

  /// Title of rename tag dialog
  ///
  /// In en, this message translates to:
  /// **'Rename Tag'**
  String get renameTagTitle;

  /// Label for new tag name input
  ///
  /// In en, this message translates to:
  /// **'New tag name'**
  String get newTagName;

  /// Confirmation message for deleting a tag
  ///
  /// In en, this message translates to:
  /// **'Delete this tag?'**
  String get confirmDeleteTag;

  /// Title of delete tag confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Tag Confirmation'**
  String get deleteTagTitle;

  /// Warning message when deleting a tag
  ///
  /// In en, this message translates to:
  /// **'This tag \"{tagName}\" will be deleted.\\nTweets will remain even after the tag is deleted.'**
  String deleteTagWarning(String tagName);

  /// Error message when trying to delete system tags
  ///
  /// In en, this message translates to:
  /// **'System tags cannot be deleted'**
  String get cannotDeleteSystemTag;

  /// Confirmation message for deleting a tweet
  ///
  /// In en, this message translates to:
  /// **'Delete this tweet?'**
  String get confirmDeleteTweet;

  /// Button text to delete a tweet
  ///
  /// In en, this message translates to:
  /// **'Delete this tweet'**
  String get deleteThisTweet;

  /// Warning message when deleting a tweet
  ///
  /// In en, this message translates to:
  /// **'This tweet will be deleted.'**
  String get deleteTweetWarning;

  /// Label for period filter section
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// Label prefix for start date
  ///
  /// In en, this message translates to:
  /// **'Since: '**
  String get since;

  /// Label prefix for end date
  ///
  /// In en, this message translates to:
  /// **'Until: '**
  String get until;

  /// Label for period start when date is null
  ///
  /// In en, this message translates to:
  /// **'start'**
  String get periodStart;

  /// Label for period end when date is null
  ///
  /// In en, this message translates to:
  /// **'end'**
  String get periodEnd;

  /// Placeholder for start date selection
  ///
  /// In en, this message translates to:
  /// **'Select start date'**
  String get selectStartDate;

  /// Placeholder for end date selection
  ///
  /// In en, this message translates to:
  /// **'Select end date'**
  String get selectEndDate;

  /// Label for tags filter section
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tagsLabel;

  /// Status message while preparing file
  ///
  /// In en, this message translates to:
  /// **'Preparing file...'**
  String get preparingFile;

  /// Progress percentage
  ///
  /// In en, this message translates to:
  /// **'{percent}% complete'**
  String percentComplete(int percent);

  /// Status message while loading tweets
  ///
  /// In en, this message translates to:
  /// **'Loading tweets...'**
  String get loadingTweets;

  /// Message when loading is finished
  ///
  /// In en, this message translates to:
  /// **'Loading complete!'**
  String get loadingComplete;

  /// Instruction to select file for upload
  ///
  /// In en, this message translates to:
  /// **'Please select a file to upload.'**
  String get selectFileToUpload;

  /// Warning about file size limitations in browser
  ///
  /// In en, this message translates to:
  /// **'⚠ Warning: This app runs in a browser, so very large files (e.g. 100MB+) may not load properly.'**
  String get webBrowserWarning;

  /// Label for reply tweet type
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// Label for retweet tweet type
  ///
  /// In en, this message translates to:
  /// **'Retweet'**
  String get retweet;

  /// Label prefix for reply target
  ///
  /// In en, this message translates to:
  /// **'Reply to:'**
  String get replyTo;

  /// Label prefix for retweet source
  ///
  /// In en, this message translates to:
  /// **'Retweet from:'**
  String get retweetFrom;

  /// Label for regular tweet type
  ///
  /// In en, this message translates to:
  /// **'Regular Tweet'**
  String get regularTweet;

  /// Tweet type filter label for regular tweets
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get tweetTypeRegular;

  /// Tweet type filter label for replies
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get tweetTypeReply;

  /// Tweet type filter label for retweets
  ///
  /// In en, this message translates to:
  /// **'Retweet'**
  String get tweetTypeRetweet;

  /// Label for showing current filters
  ///
  /// In en, this message translates to:
  /// **'Applied Filters:'**
  String get appliedFilters;

  /// Text when no filters are applied
  ///
  /// In en, this message translates to:
  /// **'No filters'**
  String get noFilters;

  /// Filter description for search query
  ///
  /// In en, this message translates to:
  /// **'Search: \"{query}\"'**
  String filterSearch(String query);

  /// Filter description for selected tags
  ///
  /// In en, this message translates to:
  /// **'Tags: {tags}'**
  String filterTags(String tags);

  /// Filter description for date period
  ///
  /// In en, this message translates to:
  /// **'Period: {since} 〜 {until}'**
  String filterPeriod(String since, String until);

  /// Filter description for tweet types
  ///
  /// In en, this message translates to:
  /// **'Types: {types}'**
  String filterTypes(String types);

  /// Label for LLM rating feature
  ///
  /// In en, this message translates to:
  /// **'LLM Rating'**
  String get llmRating;

  /// Title for LLM rating confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Start LLM Rating'**
  String get llmRatingStart;

  /// Title for LLM rating progress dialog
  ///
  /// In en, this message translates to:
  /// **'LLM Rating in Progress'**
  String get llmRatingInProgress;

  /// Title when LLM is initializing
  ///
  /// In en, this message translates to:
  /// **'Initializing'**
  String get llmInitializing;

  /// Status message while waiting for LLM initialization
  ///
  /// In en, this message translates to:
  /// **'Waiting for LLM...'**
  String get llmWaiting;

  /// Success message when LLM rating is complete
  ///
  /// In en, this message translates to:
  /// **'LLM rating completed'**
  String get llmRatingComplete;

  /// Error message when LLM rating fails
  ///
  /// In en, this message translates to:
  /// **'Error occurred: {error}'**
  String llmRatingError(String error);

  /// Message when no tweets are available for rating
  ///
  /// In en, this message translates to:
  /// **'No tweets to rate'**
  String get noTweetsToRate;

  /// Tag name for high risk tweets
  ///
  /// In en, this message translates to:
  /// **'Delete Recommended (High Risk)'**
  String get ratingTagHighRisk;

  /// Tag name for medium risk tweets
  ///
  /// In en, this message translates to:
  /// **'Delete Recommended (Medium Risk)'**
  String get ratingTagMediumRisk;

  /// Tag name for low risk tweets
  ///
  /// In en, this message translates to:
  /// **'Delete Recommended (Low Risk)'**
  String get ratingTagLowRisk;

  /// Tag name for tweets recommended to keep
  ///
  /// In en, this message translates to:
  /// **'Keep Recommended'**
  String get ratingTagKeep;

  /// Remaining time display with minutes and seconds
  ///
  /// In en, this message translates to:
  /// **'About {minutes}m {seconds}s remaining'**
  String remainingTimeMinutes(int minutes, int seconds);

  /// Remaining time display with seconds only
  ///
  /// In en, this message translates to:
  /// **'About {seconds}s remaining'**
  String remainingTimeSeconds(int seconds);

  /// Message showing number of tweets to be rated
  ///
  /// In en, this message translates to:
  /// **'{count} tweets will be rated by LLM.'**
  String tweetsWillBeRated(int count);

  /// Warning message about processing time
  ///
  /// In en, this message translates to:
  /// **'Processing will take time. Continue?'**
  String get processingWillTakeTime;

  /// Start button text
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// Error message when tweet deletion fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete tweets.'**
  String get tweetsDeletedError;

  /// Error message when tweet restoration fails
  ///
  /// In en, this message translates to:
  /// **'Failed to restore tweets.'**
  String get tweetsRestoredError;

  /// Error message when moving to bin fails
  ///
  /// In en, this message translates to:
  /// **'Failed to move to bin.'**
  String get moveToBinError;

  /// Error message when tag application fails
  ///
  /// In en, this message translates to:
  /// **'Failed to apply tags: {tags}'**
  String tagApplyError(String tags);

  /// Error message when tag renaming fails
  ///
  /// In en, this message translates to:
  /// **'Failed to rename tag'**
  String get tagRenameError;

  /// Error message when tag deletion fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete tag'**
  String get tagDeleteError;

  /// Error message when import fails
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String importFailed(String error);

  /// Success message when tweets are deleted
  ///
  /// In en, this message translates to:
  /// **'Selected tweets deleted.'**
  String get tweetsDeletedSuccess;

  /// Success message when tweets are restored
  ///
  /// In en, this message translates to:
  /// **'Selected tweets restored.'**
  String get tweetsRestoredSuccess;

  /// Success message when tweets are moved to bin
  ///
  /// In en, this message translates to:
  /// **'Selected tweets moved to bin.'**
  String get moveToBinSuccess;

  /// Success message when tags are applied
  ///
  /// In en, this message translates to:
  /// **'Tags applied successfully.'**
  String get tagApplySuccess;

  /// Success message when tag is renamed
  ///
  /// In en, this message translates to:
  /// **'Tag renamed to \"{newName}\"'**
  String tagRenamedSuccess(String newName);

  /// Success message when tag is deleted
  ///
  /// In en, this message translates to:
  /// **'Tag \"{tagName}\" deleted'**
  String tagDeletedSuccess(String tagName);

  /// Success message for import
  ///
  /// In en, this message translates to:
  /// **'Import completed successfully'**
  String get importSuccess;

  /// Success message for export
  ///
  /// In en, this message translates to:
  /// **'Export completed successfully'**
  String get exportSuccess;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
