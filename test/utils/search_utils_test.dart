import 'package:flutter_test/flutter_test.dart';
import 'package:tweethistory/utils/search_utils.dart';

void main() {
  group('QueryParser', () {
    const testText =
        'This is a Flutter web application with Dart programming language';

    test('空のクエリは常にtrueを返す', () {
      expect(QueryParser.parse('').match(testText), true);
      expect(QueryParser.parse('   ').match(testText), true);
    });

    group('基本的な単語検索', () {
      test('単一ワード検索', () {
        expect(QueryParser.parse('flutter').match(testText), true);
        expect(QueryParser.parse('Flutter').match(testText), true);
        expect(QueryParser.parse('FLUTTER').match(testText), true);
        expect(QueryParser.parse('python').match(testText), false);
      });

      test('複数ワード検索（AND）', () {
        expect(QueryParser.parse('flutter dart').match(testText), true);
        expect(QueryParser.parse('Flutter Web').match(testText), true);
        expect(QueryParser.parse('flutter python').match(testText), false);
      });
    });

    group('OR検索', () {
      test('パイプ記号を使用したOR検索', () {
        expect(QueryParser.parse('flutter|python').match(testText), true);
        expect(QueryParser.parse('java|python').match(testText), false);
        expect(QueryParser.parse('dart|kotlin').match(testText), true);
      });

      test('ORキーワードを使用したOR検索', () {
        expect(QueryParser.parse('flutter OR python').match(testText), true);
        expect(QueryParser.parse('java OR python').match(testText), false);
        expect(QueryParser.parse('dart OR kotlin').match(testText), true);
      });

      test('複雑なOR検索', () {
        // テスト用のテキスト: 'This is a Flutter web application with Dart programming language'
        // 'flutter web' は含まれている（Flutter + web）
        // 'mobile app' は含まれていない（mobile は含まれていない）
        expect(
          QueryParser.parse('flutter web|mobile app').match(testText),
          true,
        );
        expect(
          QueryParser.parse('react native|flutter dart').match(testText),
          true,
        );
      });
    });

    group('除外検索', () {
      test('単一除外ワード', () {
        expect(QueryParser.parse('flutter -python').match(testText), true);
        expect(QueryParser.parse('flutter -dart').match(testText), false);
        expect(QueryParser.parse('-python').match(testText), true);
        expect(QueryParser.parse('-flutter').match(testText), false);
      });

      test('複数除外ワード', () {
        expect(
          QueryParser.parse('application -python -java').match(testText),
          true,
        );
        expect(
          QueryParser.parse('application -dart -web').match(testText),
          false,
        );
      });

      test('検索ワードと除外ワードの組み合わせ', () {
        expect(QueryParser.parse('flutter dart -python').match(testText), true);
        expect(
          QueryParser.parse('programming -flutter').match(testText),
          false,
        );
      });
    });

    group('括弧を使用したグループ化', () {
      test('単一グループ', () {
        expect(QueryParser.parse('(flutter dart)').match(testText), true);
        expect(QueryParser.parse('(flutter python)').match(testText), false);
      });

      test('グループとOR演算子', () {
        expect(QueryParser.parse('(flutter web)|mobile').match(testText), true);
        expect(
          QueryParser.parse('(react native)|flutter').match(testText),
          true,
        );
        expect(
          QueryParser.parse('(java spring)|python').match(testText),
          false,
        );
      });

      test('複雑な括弧表現', () {
        expect(
          QueryParser.parse('(flutter|react) (web|mobile)').match(testText),
          true,
        );
        expect(
          QueryParser.parse('(java|python) (web|mobile)').match(testText),
          false,
        );
      });

      test('括弧と除外の組み合わせ', () {
        expect(
          QueryParser.parse('(flutter dart) -python').match(testText),
          true,
        );
        expect(
          QueryParser.parse('(programming language) -dart').match(testText),
          false,
        );
      });

      test('括弧内での除外検索', () {
        // -(単語|単語) パターン
        expect(
          QueryParser.parse('flutter -(python|java)').match(testText),
          true,
        );
        expect(
          QueryParser.parse('programming -(dart|flutter)').match(testText),
          false,
        );

        // 日本語での括弧内除外検索
        const snakeText = 'この動物園にはへびがいます';
        const dogText = 'この動物園には犬がいます';
        expect(QueryParser.parse('動物園 -(へび|ヘビ)').match(snakeText), false);
        expect(QueryParser.parse('動物園 -(へび|ヘビ)').match(dogText), true);

        // 複雑な括弧内除外検索
        expect(
          QueryParser.parse(
            'application -(mobile|desktop) web',
          ).match(testText),
          true,
        );
        expect(
          QueryParser.parse('flutter -(web|application)').match(testText),
          false,
        );
      });
    });

    group('エッジケース', () {
      test('特殊文字の処理', () {
        const specialText = 'This contains special chars: ()|-';
        expect(QueryParser.parse('special').match(specialText), true);
        expect(QueryParser.parse('chars').match(specialText), true);
      });

      test('空白の処理', () {
        expect(QueryParser.parse('  flutter   dart  ').match(testText), true);
        expect(QueryParser.parse('flutter    |    dart').match(testText), true);
      });

      test('大文字小文字の混在', () {
        expect(QueryParser.parse('Flutter AND dart').match(testText), true);
        expect(QueryParser.parse('FLUTTER or PYTHON').match(testText), true);
        expect(QueryParser.parse('Web -DART').match(testText), false);
      });
    });

    group('完全一致検索', () {
      test('単一引用符でのフレーズ検索', () {
        expect(QueryParser.parse("'Flutter web'").match(testText), true);
        expect(QueryParser.parse("'web application'").match(testText), true);
        expect(QueryParser.parse("'mobile app'").match(testText), false);
      });

      test('ダブルクォートでのフレーズ検索', () {
        expect(QueryParser.parse('"Flutter web"').match(testText), true);
        expect(QueryParser.parse('"web application"').match(testText), true);
        expect(QueryParser.parse('"mobile app"').match(testText), false);
      });

      test('フレーズと通常検索の組み合わせ', () {
        expect(QueryParser.parse("'Flutter web' dart").match(testText), true);
        expect(QueryParser.parse('"Flutter web" dart').match(testText), true);
        expect(QueryParser.parse("'mobile app' programming").match(testText), false);
      });

      test('フレーズでの除外検索', () {
        expect(QueryParser.parse("flutter -'mobile app'").match(testText), true);
        expect(QueryParser.parse('flutter -"mobile app"').match(testText), true);
        expect(QueryParser.parse("'web application' -flutter").match(testText), false);
      });

      test('混在したクォート記号', () {
        expect(QueryParser.parse('"Flutter web" \'programming language\'').match(testText), true);
        expect(QueryParser.parse('\'web application\' "with Dart"').match(testText), true);
      });
    });

    group('日本語テキストの検索', () {
      const japaneseText = 'これはFlutterで作られたWebアプリケーションです';

      test('日本語での基本検索', () {
        expect(QueryParser.parse('Flutter').match(japaneseText), true);
        expect(QueryParser.parse('アプリケーション').match(japaneseText), true);
        expect(QueryParser.parse('React').match(japaneseText), false);
      });

      test('日本語でのOR検索', () {
        expect(QueryParser.parse('Flutter|React').match(japaneseText), true);
        expect(QueryParser.parse('アプリ|ゲーム').match(japaneseText), true);
        expect(QueryParser.parse('Python|Java').match(japaneseText), false);
      });

      test('日本語での除外検索', () {
        expect(QueryParser.parse('Flutter -React').match(japaneseText), true);
        expect(QueryParser.parse('アプリ -Flutter').match(japaneseText), false);
      });

      test('日本語での完全一致検索', () {
        expect(QueryParser.parse("'Webアプリケーション'").match(japaneseText), true);
        expect(QueryParser.parse('"Webアプリケーション"').match(japaneseText), true);
        expect(QueryParser.parse("'モバイルアプリ'").match(japaneseText), false);
        expect(QueryParser.parse('"モバイルアプリ"').match(japaneseText), false);
      });
    });
  });
}
