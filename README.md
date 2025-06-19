# TweetHistory

Twitterからダウンロードしたアーカイブの`tweets.js`を読み込み、高機能なタグ付けや検索ができるWebアプリです。

**🌐 [TweetHistory を試す](https://nozomi-hiragi.github.io/TweetHistory/)**

## ✨ 主な機能

### 📂 データ管理
- **tweets.js のインポート** - Twitterアーカイブから簡単にデータを読み込み
- **データのエクスポート/インポート** - バックアップや他端末との同期に対応
- **ローカルストレージ** - ブラウザ内でデータを安全に保存

### 🏷️ 整理・分類
- **柔軟なタグ付けシステム** - 複数タグの同時適用、一括タグ操作
- **高度なフィルタリング** - タグ、キーワード、期間での絞り込み
- **期間指定検索** - 開始日・終了日を指定した詳細な期間フィルタ
- **ソート機能** - 日付順での並び替え

### 🔍 検索・表示
- **全文検索** - ツイート内容をリアルタイム検索
- **詳細表示** - リツイート数、いいね数を含む詳細情報
- **複数選択** - 複数ツイートの一括操作
- **ゴミ箱機能** - 不要なツイートの一時削除と復元

### 🌐 ユーザー体験
- **多言語対応** - 日本語・英語インターフェース
- **ダークモード** - 目に優しいテーマ切り替え
- **マルチプラットフォーム** - Web・デスクトップアプリ対応（Mac動作確認済、Windows動作未確認）

## 🚀 開発セットアップ

### 必要な環境
- Flutter SDK ^3.7.2
- Dart SDK

### セットアップ手順

```bash
# 依存関係のインストール
flutter pub get

# コード生成（Freezed/JSON）
dart run build_runner build

# 開発サーバー起動（Web）
flutter run -d chrome --web-port 3000

# デスクトップアプリ起動（Mac）
flutter run -d macos

# デスクトップアプリ起動（Windows、動作未確認）
flutter run -d windows
```

### 開発コマンド

```bash
# コード生成（ウォッチモード）
dart run build_runner watch

# テスト実行
flutter test

# 静的解析
flutter analyze
dart run custom_lint

# プロダクションビルド（Web）
flutter build web

# プロダクションビルド（デスクトップ）
flutter build macos           # Mac
flutter build windows         # Windows（動作未確認）
```

## 🏗️ アーキテクチャ

- **フレームワーク**: Flutter（Web・デスクトップ）
- **状態管理**: Riverpod + Flutter Hooks
- **データ永続化**: IndexedDB (idb_shim)
- **設定管理**: SharedPreferences
- **コード生成**: Freezed + JSON Serializable
- **国際化**: Flutter Intl

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。
