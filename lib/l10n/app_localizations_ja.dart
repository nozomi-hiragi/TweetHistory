// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get cancel => 'キャンセル';

  @override
  String get navTweets => 'ツイート';

  @override
  String get navBin => 'ごみ箱';

  @override
  String get navSettings => '設定';

  @override
  String selectedCount(int count) {
    return '$count件選択中';
  }

  @override
  String get close => '閉じる';

  @override
  String get delete => '削除';

  @override
  String get save => '保存';

  @override
  String get apply => '適用';

  @override
  String get clear => 'クリア';

  @override
  String get search => '検索';

  @override
  String get filter => 'フィルター';

  @override
  String get add => '追加';

  @override
  String get confirm => '確認';

  @override
  String get done => '完了';

  @override
  String get addTag => 'タグを追加';

  @override
  String get selectTags => 'タグを選択';

  @override
  String get tagNamePlaceholder => 'タグ名を入力';

  @override
  String get upload => 'アップロード';

  @override
  String get error => 'エラー';

  @override
  String get loading => '読み込み中...';

  @override
  String get searchTweets => 'ツイートを検索';

  @override
  String get restoreFromBin => 'ごみ箱から復元';

  @override
  String get invalidTagName => '無効なタグ名です';

  @override
  String get addNewTag => '新しいタグを追加';

  @override
  String get tweetDetails => 'ツイート詳細';

  @override
  String get tweetId => 'ツイートID';

  @override
  String get postedAt => '投稿日時';

  @override
  String get retweetCount => 'リツイート数';

  @override
  String get favoriteCount => 'いいね数';

  @override
  String get sortNewestFirst => '新しい順';

  @override
  String get sortOldestFirst => '古い順';

  @override
  String get applyTag => '振り分け';

  @override
  String copiedToClipboard(String item) {
    return '$itemをコピーしました';
  }

  @override
  String get mediaUrlCopied => 'メディアURLをコピーしました';

  @override
  String get type => 'タイプ';

  @override
  String get openInBrowser => 'ブラウザで開く';

  @override
  String get media => 'メディア';

  @override
  String get chooseAction => 'アクションを選択';

  @override
  String get dataCopiedToClipboard => 'データをクリップボードにコピーしました';

  @override
  String get uploadTweetsFile => 'tweets.jsをアップロード';

  @override
  String get settingsTitle => '設定';

  @override
  String get language => '言語';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageEnglish => '英語';

  @override
  String get languageSystem => 'システム';

  @override
  String get theme => 'テーマ';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeSystem => 'システム';

  @override
  String get version => 'バージョン';

  @override
  String get license => 'ライセンス';

  @override
  String get userId => 'ユーザーID';

  @override
  String get userIdPlaceholder => 'user_id';

  @override
  String get userIdSetting => 'ユーザーID設定';

  @override
  String get userIdDescription => 'X(Twitter)のユーザーID（@なし）を入力してください：';

  @override
  String get userIdExample => '例: https://x.com/username の場合は \"username\" を入力';

  @override
  String get userIdCleared => 'ユーザーIDをクリアしました';

  @override
  String get userIdSet => 'ユーザーIDを設定しました';

  @override
  String get notSet => '未設定';

  @override
  String get importExport => 'インポート・エクスポート';

  @override
  String get importData => 'データをインポート';

  @override
  String get exportData => 'データをエクスポート';

  @override
  String get editMode => '編集モード';

  @override
  String get exitEditMode => '編集モード終了';

  @override
  String get renameTag => 'タグ名を変更';

  @override
  String get renameTagTitle => 'タグ名変更';

  @override
  String get newTagName => '新しいタグ名';

  @override
  String get confirmDeleteTag => 'タグを削除しますか？';

  @override
  String get deleteTagTitle => 'タグ削除確認';

  @override
  String deleteTagWarning(String tagName) {
    return 'このタグ「$tagName」を削除します。\nタグが削除されても、ツイートは残ります。';
  }

  @override
  String get cannotDeleteSystemTag => 'システムタグは削除できません';

  @override
  String get confirmDeleteTweet => 'ツイートを削除しますか？';

  @override
  String get deleteThisTweet => 'このツイートを削除';

  @override
  String get deleteTweetWarning => 'このツイートを削除します。';

  @override
  String get period => '期間';

  @override
  String get since => '開始: ';

  @override
  String get until => '終了: ';

  @override
  String get periodStart => '開始';

  @override
  String get periodEnd => '終了';

  @override
  String get selectStartDate => '開始日を選択';

  @override
  String get selectEndDate => '終了日を選択';

  @override
  String get tagsLabel => 'タグ';

  @override
  String get preparingFile => 'ファイルを準備しています...';

  @override
  String percentComplete(int percent) {
    return '$percent% 完了';
  }

  @override
  String get loadingTweets => 'ツイートを読み込んでいます...';

  @override
  String get loadingComplete => '読み込みが完了しました！';

  @override
  String get selectFileToUpload => 'ファイルを選択してアップロードしてください。';

  @override
  String get webBrowserWarning =>
      '⚠ 注意：このアプリはブラウザ上で動作しているため、非常に大きなファイル（例：100MB以上）は読み込めない場合があります。';

  @override
  String get reply => '返信';

  @override
  String get retweet => 'リツイート';

  @override
  String get replyTo => '返信先:';

  @override
  String get retweetFrom => 'リツイート元:';

  @override
  String get regularTweet => '通常ツイート';

  @override
  String get tweetTypeRegular => '通常';

  @override
  String get tweetTypeReply => 'リプライ';

  @override
  String get tweetTypeRetweet => 'リツイート';

  @override
  String get appliedFilters => '適用フィルター:';

  @override
  String get noFilters => 'フィルターなし';

  @override
  String filterSearch(String query) {
    return '検索: \"$query\"';
  }

  @override
  String filterTags(String tags) {
    return 'タグ: $tags';
  }

  @override
  String filterPeriod(String since, String until) {
    return '期間: $since 〜 $until';
  }

  @override
  String filterTypes(String types) {
    return '種類: $types';
  }

  @override
  String get llmRating => 'LLM評価';

  @override
  String get llmRatingStart => 'LLM評価開始';

  @override
  String get llmRatingInProgress => 'LLM評価中';

  @override
  String get llmInitializing => '初期化中';

  @override
  String get llmWaiting => 'LLMを待機しています...';

  @override
  String get llmRatingComplete => 'LLM評価が完了しました';

  @override
  String llmRatingError(String error) {
    return 'エラーが発生しました: $error';
  }

  @override
  String get noTweetsToRate => '評価するツイートがありません';

  @override
  String get ratingTagHighRisk => '削除推奨（高リスク）';

  @override
  String get ratingTagMediumRisk => '削除推奨（中リスク）';

  @override
  String get ratingTagLowRisk => '削除推奨（低リスク）';

  @override
  String get ratingTagKeep => '保持推奨';

  @override
  String remainingTimeMinutes(int minutes, int seconds) {
    return '残り約$minutes分$seconds秒';
  }

  @override
  String remainingTimeSeconds(int seconds) {
    return '残り約$seconds秒';
  }

  @override
  String tweetsWillBeRated(int count) {
    return '$count件のツイートをLLMで評価します。';
  }

  @override
  String get processingWillTakeTime => '処理には時間がかかります。続行しますか？';

  @override
  String get start => '開始';

  @override
  String get tweetsDeletedError => 'ツイートを削除できませんでした。';

  @override
  String get tweetsRestoredError => 'ツイートを戻せませんでした。';

  @override
  String get moveToBinError => 'ゴミ箱に移動できませんでした。';

  @override
  String tagApplyError(String tags) {
    return 'タグ付与に失敗しました: $tags';
  }

  @override
  String get tagRenameError => 'タグ名の変更に失敗しました';

  @override
  String get tagDeleteError => 'タグの削除に失敗しました';

  @override
  String importFailed(String error) {
    return 'インポートに失敗しました: $error';
  }

  @override
  String get tweetsDeletedSuccess => '選択されたツイートを削除しました。';

  @override
  String get tweetsRestoredSuccess => '選択されたツイートを戻しました。';

  @override
  String get moveToBinSuccess => '選択されたツイートをゴミ箱に移動しました。';

  @override
  String get tagApplySuccess => 'タグ付与が完了しました。';

  @override
  String tagRenamedSuccess(String newName) {
    return 'タグ名を「$newName」に変更しました';
  }

  @override
  String tagDeletedSuccess(String tagName) {
    return 'タグ「$tagName」を削除しました';
  }

  @override
  String get importSuccess => 'インポートが完了しました';

  @override
  String get exportSuccess => 'エクスポートが完了しました';
}
