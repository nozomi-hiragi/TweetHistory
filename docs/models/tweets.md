# Tweet モデル仕様

## 概要
TweetHistory で扱うツイートデータの基本的なモデルを定義します。

## フィールド

| フィールド名 | 型 | 必須 | 説明 |
| --- | --- | --- | --- |
| id | string | Yes | ツイート ID |
| text | string | Yes | ツイート本文 |
| createdAt | DateTime | Yes | 投稿日時 |
| media | List&lt;Media&gt; | No | 添付メディア情報 |
| favoriteCount | int | Yes | いいね数 |
| retweetCount | int | Yes | リツイート数 |

### Media
| フィールド名 | 型 | 必須 | 説明 |
| --- | --- | --- | --- |
| url | string | Yes | メディアの URL |
| type | string | Yes | `'photo'` や `'video'` など |

タグ情報は `Tag` モデルとして別途管理しています。

既存データに `favoriteCount` または `retweetCount` が含まれていない場合は、
読み込み時に自動で `0` が設定されます。
