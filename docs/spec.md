# TweetHistory 仕様書（全体概要）

## 1. 概要

**TweetHistory**は、エクスポートしたTwitter（現X）の過去ツイート（tweets.js形式）をローカル環境で読み込み、整理・タグ付け・ゴミ箱管理できるFlutter Webアプリです。
**APIや外部サービス連携はなく、完全ローカル動作**でプライバシーも安心です。

## 2. 目的・ユースケース

* 自分の過去ツイートを**検索・整理**したい
* テーマごとに**タグ付け**して管理したい
* 不要なツイートを**削除/ゴミ箱送り**にしたい
* サービス終了やAPI制限があっても**ローカルでツイート資産を守りたい**

## 3. 主な機能

### 3.1 データ管理
* **インポート**：tweets.js（公式エクスポートファイル）を読み込み、ローカルDBに保存
* **エクスポート/インポート**：整理・タグ付け後のデータをJSON形式でエクスポート・インポート（実装済み）
* **ローカルストレージ**：IndexedDBを使用したブラウザ内データ保存

### 3.2 ツイート表示・管理
* **ツイート一覧表示**：テキスト・日付・メディア（画像/動画）・エンゲージメント数を表示
* **詳細表示ダイアログ**：個別ツイートの詳細情報とタグ編集機能
* **削除/ゴミ箱管理**：削除したツイートはゴミ箱状態で保持し、元に戻すことも可能

### 3.3 タグ・分類システム
* **柔軟なタグ付けシステム**：ツイートごとに任意のタグを追加
* **一括タグ操作**：複数ツイートに対する同時タグ付け・削除
* **タグ管理**：タグの作成・編集・削除・統計表示

### 3.4 検索・フィルタリング
* **全文検索**：ツイート内容をリアルタイム検索
* **高度なフィルタリング機能**：
  - タグフィルタ（複数選択可能）
  - 期間フィルタ（開始日・終了日指定）
  - ツイートタイプフィルタ（オリジナル・リツイート・リプライ）
  - ユーザーフィルタ（特定ユーザーのみ表示）
* **ソート機能**：日付順（昇順・降順）での並び替え

### 3.5 ユーザーインターフェース
* **多言語対応**：日本語・英語の動的切り替え
* **ダークモード**：テーマの切り替え機能
* **レスポンシブデザイン**：Web・デスクトップ対応

## 4. 画面構成

### 4.1 メイン画面
* **ツイート一覧**：フィルタリング・検索結果に基づいたツイート表示
* **アプリバー**：検索バー、フィルタ切り替え、選択モード切り替え
* **フィルタセクション**：タグ・期間・ツイートタイプ・ユーザーフィルタ
* **操作バー**：選択モード時のタグ付け・削除操作

### 4.2 ダイアログ・モーダル
* **ツイート詳細ダイアログ**：個別ツイートの詳細表示とタグ編集
* **インポート・エクスポートダイアログ**：データの入出力機能
* **タグ管理ダイアログ**：タグの作成・編集・削除
* **設定ダイアログ**：テーマ切り替え・言語設定・データ管理

### 4.3 専用画面
* **ゴミ箱画面**：削除されたツイートの一覧と復元機能

## 5. データ構造

### 5.1 Tweetモデル
```dart
class Tweet {
  final String id;                          // ツイートID
  final String text;                        // ツイート本文
  final DateTime createdAt;                 // 投稿日時
  final List<Media> media;                  // 添付メディア
  final int favoriteCount;                  // いいね数
  final int retweetCount;                   // リツイート数
  final String? inReplyToStatusId;          // リプライ先ツイートID
  final String? inReplyToUserId;            // リプライ先ユーザーID
  final String? inReplyToScreenName;        // リプライ先ユーザー名
  final bool isRetweet;                     // リツイートフラグ
  final String? retweetedStatusId;          // リツイート元ツイートID
  final String? retweetedUserScreenName;    // リツイート元ユーザー名
  final bool isReply;                       // リプライフラグ
}
```

### 5.2 Tagモデル
```dart
class Tag {
  final String name;                        // タグ名
  final Set<String> tweetIds;               // 関連ツイートIDセット
}
```

### 5.3 Mediaモデル
```dart
class Media {
  final String url;                         // メディアURL
  final String type;                        // メディアタイプ (photo, video, etc.)
}
```

### 5.4 保存先
* **IndexedDB**：`idb_shim`ライブラリを使用したブラウザ内ストレージ
* **SharedPreferences**：ユーザー設定（テーマ、言語など）の保存

## 6. 使用技術・ライブラリ

### 6.1 フレームワーク・コア
* **Flutter 3.x**：Webおよびデスクトップアプリケーションフレームワーク
* **Dart**：プログラミング言語

### 6.2 状態管理
* **Riverpod + Flutter Hooks**：リアクティブ状態管理
* **Freezed**：イミュータブルなデータクラス生成
* **JSON Serializable**：JSONシリアライゼーション

### 6.3 データ永続化
* **idb_shim**：IndexedDBアクセスライブラリ
* **shared_preferences**：ユーザー設定保存

### 6.4 国際化・テーマ
* **Flutter Intl**：多言語対応（日本語・英語）
* **Material Design 3**：UIデザインシステム

### 6.5 開発・テスト
* **build_runner**：コード生成ツール
* **custom_lint**：カスタムLintルール
* **flutter_test**：テストフレームワーク

### 6.6 プラットフォーム対応
* **file_picker**：ファイル選択機能
* **url_launcher**：外部URL・ファイル起動
* **package_info_plus**：アプリ情報取得

## 7. アーキテクチャ概要

### 7.1 状態管理パターン
```
UI Widget → ref.watch(provider) → Controller → Repository → Storage Layer
```

### 7.2 レイヤー構成
* **UI Layer**：Widgets, Screens, Dialogs
* **State Layer**：Providers, Controllers, State Objects
* **Domain Layer**：Models, Business Logic
* **Data Layer**：Repositories, Storage Interfaces
* **Storage Layer**：IndexedDB, SharedPreferences

## 8. 開発・運用

### 8.1 開発コマンド
```bash
flutter pub get                              # 依存関係取得
dart run build_runner build                  # コード生成
flutter run -d web-server --web-port 3000    # 開発サーバー起動
flutter test                                 # テスト実行
flutter analyze                              # 静的解析
```

### 8.2 ビルド・デプロイ
```bash
flutter build web                            # Webビルド
flutter build macos                          # macOSビルド
flutter build windows                        # Windowsビルド
```

## 9. ライセンス・注意事項

* このアプリは個人利用を前提
* Twitter/Xの利用規約に反しない形で運用
* API/外部通信なし、**全てローカル動作**

## 10. ドキュメント構成

詳細な設計資料は以下に分割して記載：

* **`docs/features/`**：機能別詳細仕様
  - `tweets/`：ツイート表示・管理機能
  - `bin/`：ゴミ箱機能
  - `settings/`：設定機能
* **`docs/models/`**：データモデル詳細
* **`docs/architecture/`**：アーキテクチャ設計
* **`docs/providers/`**：状態管理詳細
* **`docs/development/`**：開発者向け情報
