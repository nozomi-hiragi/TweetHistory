# Tweetsモデル仕様

## 概要
Tweetsモデルは、ユーザーが投稿したツイート情報を管理します。

## フィールド

| フィールド名   | 型       | 必須 | 説明                     |
| -------------- | -------- | ---- | ------------------------ |
| id             | integer  | Yes  | ツイートの一意なID       |
| user_id        | integer  | Yes  | 投稿ユーザーのID         |
| content        | string   | Yes  | ツイート本文             |
| created_at     | datetime | Yes  | ツイート作成日時         |
| updated_at     | datetime | Yes  | ツイート更新日時         |
| in_reply_to_id | integer  | No   | 返信先ツイートのID       |
| retweet_id     | integer  | No   | リツイート元ツイートのID |
| like_count     | integer  | No   | いいね数                 |
| retweet_count  | integer  | No   | リツイート数             |

## 補足
- `content`は最大280文字まで。
- `in_reply_to_id`や`retweet_id`は該当しない場合はnull。
- 各ツイートは必ず1人のユーザーに紐づきます。
- 日時はISO 8601形式で保存します。
