# Tweet モデル仕様

## 概要
TweetHistory で扱うツイートデータの基本的なモデルを定義します。TwitterのAPI形式から変換される際の詳細な情報を保持します。

## フィールド

### 基本情報
| フィールド名 | 型 | 必須 | デフォルト | 説明 |
| --- | --- | --- | --- | --- |
| id | String | Yes | - | ツイートID（Twitter APIの`id_str`） |
| text | String | Yes | - | ツイート本文（Twitter APIの`full_text`） |
| createdAt | DateTime | Yes | - | 投稿日時（Twitter APIの`created_at`をパース） |
| media | List&lt;Media&gt; | No | `[]` | 添付メディア情報 |

### エンゲージメント情報
| フィールド名 | 型 | 必須 | デフォルト | 説明 |
| --- | --- | --- | --- | --- |
| favoriteCount | int | No | `0` | いいね数（Twitter APIの`favorite_count`） |
| retweetCount | int | No | `0` | リツイート数（Twitter APIの`retweet_count`） |

### リプライ情報
| フィールド名 | 型 | 必須 | デフォルト | 説明 |
| --- | --- | --- | --- | --- |
| inReplyToStatusId | String? | No | `null` | リプライ先ツイートID（Twitter APIの`in_reply_to_status_id_str`） |
| inReplyToUserId | String? | No | `null` | リプライ先ユーザーID（Twitter APIの`in_reply_to_user_id_str`） |
| inReplyToScreenName | String? | No | `null` | リプライ先ユーザー名（Twitter APIの`in_reply_to_screen_name`） |
| isReply | bool | No | `false` | リプライフラグ（`inReplyToStatusId`の有無で自動設定） |

### リツイート情報
| フィールド名 | 型 | 必須 | デフォルト | 説明 |
| --- | --- | --- | --- | --- |
| isRetweet | bool | No | `false` | リツイートフラグ（`retweeted_status`の有無またはRT@で始まるかで判定） |
| retweetedStatusId | String? | No | `null` | リツイート元ツイートID（`retweeted_status.id_str`） |
| retweetedUserScreenName | String? | No | `null` | リツイート元ユーザー名（`retweeted_status.user.screen_name`または`user_mentions`から抽出） |

## サブモデル

### Media
| フィールド名 | 型 | 必須 | 説明 |
| --- | --- | --- | --- |
| url | String | Yes | メディアURL（Twitter APIの`media_url_https`または`media_url`） |
| type | String | Yes | メディアタイプ（`'photo'`、`'video'`など、Twitter APIの`type`） |

## データ変換

### Twitter API形式からの変換
`Tweet.fromRawJson()`メソッドにより、TwitterのAPIレスポンス形式（`tweets.js`内のデータ）から本モデルに変換されます：

1. **日付変換**：`timezone_utils.dart`の`parseTwitterDate()`を使用してTwitterの日付形式をパース
2. **リツイート判定**：`retweeted_status`オブジェクトの有無または本文が`RT @`で始まるかで判定
3. **メディア抽出**：`entities.media`配列から`Media`オブジェクトのリストを生成
4. **数値変換**：`favorite_count`や`retweet_count`を安全にint型に変換

### 特殊処理
- **テキストベースRT**：`retweeted_status`がない場合でも`RT @`で始まる場合はリツイートとして扱い、`entities.user_mentions`から元ユーザー名を抽出
- **エラーハンドリング**：数値フィールドの変換に失敗した場合は0を設定

## 関連情報
- タグ情報は`Tag`モデルとして別途管理
- 削除状態は`Tag`モデルの特殊タグ「bin」で管理（ソフトデリート）
- 実装ファイル：`lib/models/tweet.dart`
