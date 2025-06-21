# 検索機能改善候補

## 現在の実装状況
- ✅ スペース区切り複数ワード検索（AND検索）
- ✅ OR検索対応（パイプ記号 `|` または `OR` キーワード）
- ✅ 除外検索（マイナス記号 `-` プレフィックス）
- ✅ 完全一致検索（シングル/ダブルクォート）
- ✅ 括弧を使ったグループ化
- ✅ 大文字小文字を区別しない検索
- ✅ 部分一致検索
- ✅ 検索クエリの永続化

## 改善候補

### 優先度中：UI改善

#### 1. 検索履歴機能
**実装場所**: 
- `lib/providers/search_query_provider.dart` - 履歴状態管理
- `lib/common/my_search_bar.dart` - 履歴UI追加
- `lib/repository/preferences_repository.dart` - 履歴永続化

**機能詳細**:
- 最新10件の検索履歴を保存
- 検索バーのドロップダウンで履歴表示
- 履歴クリックで再検索

#### 2. 検索結果数表示
**実装場所**: `lib/features/tweets/ui/tweets_list.dart`
```dart
// 例: "123件のツイートが見つかりました"
// 検索結果の件数をUI上部に表示
```

#### 3. 検索ワードハイライト
**実装場所**: `lib/common/tweet_tile.dart`
```dart
// ツイート本文内の検索ワードを色付きでハイライト表示
// RichText ウィジェットを使用
```

### 優先度低：高度な機能

#### 1. 日付範囲検索
**実装場所**: `lib/features/tweets/ui/tweets_list.dart:_matchesSearchQuery`
```dart
// 例: "after:2023-01-01 before:2023-12-31 flutter"
// 特定期間内のツイートのみ検索
```

#### 2. メタデータ検索
**実装場所**: `lib/features/tweets/ui/tweets_list.dart:_matchesSearchQuery`
```dart
// 例: "likes:>10" - いいね数10以上
// 例: "retweets:>5" - リツイート数5以上
// 数値フィールドでの条件検索
```

#### 3. 正規表現検索
**実装場所**: `lib/features/tweets/ui/tweets_list.dart:_matchesSearchQuery`
```dart
// 例: "/flutter.*dart/" - 正規表現パターン
// 高度なパターンマッチング
```

## 実装時の考慮事項

### パフォーマンス
- 大量のツイートでの検索速度
- 複雑な検索クエリの処理時間
- メモリ使用量

### ユーザビリティ
- 検索構文の学習コスト
- エラーハンドリング（無効な構文など）
- モバイルデバイスでの入力しやすさ

### 国際化
- 日本語・英語の検索ヘルプテキスト
- 検索演算子の多言語対応

## 推奨実装順序

1. **検索結果数表示** - UX向上、実装簡単
2. **検索履歴** - 利便性大幅向上
3. **検索ワードハイライト** - 視覚的な改善

## 技術的詳細

### 検索クエリパース処理
現在の実装では高度な再帰下降パーサーを使用：

```dart
class QueryParser {
  // ✅ 実装済み
  // - トークン化
  // - 再帰的パース
  // - AST構築
  // - マッチング処理
}
```

### 検索インデックス
将来的に大量データ対応が必要な場合：
- 全文検索インデックスの構築
- Web Worker での検索処理
- 検索結果のキャッシュ

---

**最終更新**: 2025-06-21
**関連ファイル**: 
- `lib/features/tweets/ui/tweets_list.dart`
- `lib/providers/search_query_provider.dart`
- `lib/common/my_search_bar.dart`