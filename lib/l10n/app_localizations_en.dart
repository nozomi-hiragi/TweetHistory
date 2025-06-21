// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get navTweets => 'Tweets';

  @override
  String get navBin => 'Bin';

  @override
  String get navSettings => 'Settings';

  @override
  String selectedCount(int count) {
    return '$count selected';
  }

  @override
  String get close => 'Close';

  @override
  String get delete => 'Delete';

  @override
  String get save => 'Save';

  @override
  String get apply => 'Apply';

  @override
  String get clear => 'Clear';

  @override
  String get search => 'Search';

  @override
  String get filter => 'Filter';

  @override
  String get add => 'Add';

  @override
  String get confirm => 'Confirm';

  @override
  String get done => 'Done';

  @override
  String get addTag => 'Add Tag';

  @override
  String get selectTags => 'Select Tags';

  @override
  String get tagNamePlaceholder => 'Enter tag name';

  @override
  String get upload => 'Upload';

  @override
  String get error => 'Error';

  @override
  String get loading => 'Loading...';

  @override
  String get searchTweets => 'Search Tweets';

  @override
  String get restoreFromBin => 'Restore from Bin';

  @override
  String get invalidTagName => 'Invalid tag name';

  @override
  String get addNewTag => 'Add New Tag';

  @override
  String get tweetDetails => 'Tweet Details';

  @override
  String get tweetId => 'Tweet ID';

  @override
  String get postedAt => 'Posted At';

  @override
  String get retweetCount => 'Retweets';

  @override
  String get favoriteCount => 'Likes';

  @override
  String get sortNewestFirst => 'Newest first';

  @override
  String get sortOldestFirst => 'Oldest first';

  @override
  String get applyTag => 'Apply tags';

  @override
  String copiedToClipboard(String item) {
    return 'Copied $item to clipboard';
  }

  @override
  String get mediaUrlCopied => 'Media URL copied to clipboard';

  @override
  String get type => 'Type';

  @override
  String get openInBrowser => 'Open in browser';

  @override
  String get media => 'Media';

  @override
  String get chooseAction => 'Choose an action';

  @override
  String get dataCopiedToClipboard => 'Data copied to clipboard';

  @override
  String get uploadTweetsFile => 'Upload tweets.js';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get languageJapanese => 'Japanese';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSystem => 'System';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get version => 'Version';

  @override
  String get license => 'License';

  @override
  String get userId => 'User ID';

  @override
  String get userIdPlaceholder => 'user_id';

  @override
  String get userIdSetting => 'User ID setting';

  @override
  String get userIdDescription =>
      'Please enter your X (Twitter) user ID (without @):';

  @override
  String get userIdExample =>
      'Example: For https://x.com/username, enter \"username\"';

  @override
  String get userIdCleared => 'User ID cleared';

  @override
  String get userIdSet => 'User ID set';

  @override
  String get notSet => 'Not set';

  @override
  String get importExport => 'Import & Export';

  @override
  String get importData => 'Import Data';

  @override
  String get exportData => 'Export Data';

  @override
  String get editMode => 'Edit Mode';

  @override
  String get exitEditMode => 'Exit Edit Mode';

  @override
  String get renameTag => 'Rename Tag';

  @override
  String get renameTagTitle => 'Rename Tag';

  @override
  String get newTagName => 'New tag name';

  @override
  String get confirmDeleteTag => 'Delete this tag?';

  @override
  String get deleteTagTitle => 'Delete Tag Confirmation';

  @override
  String deleteTagWarning(String tagName) {
    return 'This tag \"$tagName\" will be deleted.\\nTweets will remain even after the tag is deleted.';
  }

  @override
  String get cannotDeleteSystemTag => 'System tags cannot be deleted';

  @override
  String get confirmDeleteTweet => 'Delete this tweet?';

  @override
  String get deleteThisTweet => 'Delete this tweet';

  @override
  String get deleteTweetWarning => 'This tweet will be deleted.';

  @override
  String get period => 'Period';

  @override
  String get since => 'Since: ';

  @override
  String get until => 'Until: ';

  @override
  String get periodStart => 'start';

  @override
  String get periodEnd => 'end';

  @override
  String get selectStartDate => 'Select start date';

  @override
  String get selectEndDate => 'Select end date';

  @override
  String get tagsLabel => 'Tags';

  @override
  String get preparingFile => 'Preparing file...';

  @override
  String percentComplete(int percent) {
    return '$percent% complete';
  }

  @override
  String get loadingTweets => 'Loading tweets...';

  @override
  String get loadingComplete => 'Loading complete!';

  @override
  String get selectFileToUpload => 'Please select a file to upload.';

  @override
  String get webBrowserWarning =>
      '⚠ Warning: This app runs in a browser, so very large files (e.g. 100MB+) may not load properly.';

  @override
  String get reply => 'Reply';

  @override
  String get retweet => 'Retweet';

  @override
  String get replyTo => 'Reply to:';

  @override
  String get retweetFrom => 'Retweet from:';

  @override
  String get regularTweet => 'Regular Tweet';

  @override
  String get tweetTypeRegular => 'Regular';

  @override
  String get tweetTypeReply => 'Reply';

  @override
  String get tweetTypeRetweet => 'Retweet';

  @override
  String get appliedFilters => 'Applied Filters:';

  @override
  String get noFilters => 'No filters';

  @override
  String filterSearch(String query) {
    return 'Search: \"$query\"';
  }

  @override
  String filterTags(String tags) {
    return 'Tags: $tags';
  }

  @override
  String filterPeriod(String since, String until) {
    return 'Period: $since 〜 $until';
  }

  @override
  String filterTypes(String types) {
    return 'Types: $types';
  }

  @override
  String get llmRating => 'LLM Rating';

  @override
  String get llmRatingStart => 'Start LLM Rating';

  @override
  String get llmRatingInProgress => 'LLM Rating in Progress';

  @override
  String get llmInitializing => 'Initializing';

  @override
  String get llmWaiting => 'Waiting for LLM...';

  @override
  String get llmRatingComplete => 'LLM rating completed';

  @override
  String llmRatingError(String error) {
    return 'Error occurred: $error';
  }

  @override
  String get noTweetsToRate => 'No tweets to rate';

  @override
  String get ratingTagHighRisk => 'Delete Recommended (High Risk)';

  @override
  String get ratingTagMediumRisk => 'Delete Recommended (Medium Risk)';

  @override
  String get ratingTagLowRisk => 'Delete Recommended (Low Risk)';

  @override
  String get ratingTagKeep => 'Keep Recommended';

  @override
  String remainingTimeMinutes(int minutes, int seconds) {
    return 'About ${minutes}m ${seconds}s remaining';
  }

  @override
  String remainingTimeSeconds(int seconds) {
    return 'About ${seconds}s remaining';
  }

  @override
  String tweetsWillBeRated(int count) {
    return '$count tweets will be rated by LLM.';
  }

  @override
  String get processingWillTakeTime => 'Processing will take time. Continue?';

  @override
  String get start => 'Start';

  @override
  String get tweetsDeletedError => 'Failed to delete tweets.';

  @override
  String get tweetsRestoredError => 'Failed to restore tweets.';

  @override
  String get moveToBinError => 'Failed to move to bin.';

  @override
  String tagApplyError(String tags) {
    return 'Failed to apply tags: $tags';
  }

  @override
  String get tagRenameError => 'Failed to rename tag';

  @override
  String get tagDeleteError => 'Failed to delete tag';

  @override
  String importFailed(String error) {
    return 'Import failed: $error';
  }

  @override
  String get tweetsDeletedSuccess => 'Selected tweets deleted.';

  @override
  String get tweetsRestoredSuccess => 'Selected tweets restored.';

  @override
  String get moveToBinSuccess => 'Selected tweets moved to bin.';

  @override
  String get tagApplySuccess => 'Tags applied successfully.';

  @override
  String tagRenamedSuccess(String newName) {
    return 'Tag renamed to \"$newName\"';
  }

  @override
  String tagDeletedSuccess(String tagName) {
    return 'Tag \"$tagName\" deleted';
  }

  @override
  String get importSuccess => 'Import completed successfully';

  @override
  String get exportSuccess => 'Export completed successfully';
}
