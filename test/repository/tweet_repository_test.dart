import 'package:flutter_test/flutter_test.dart';
import 'package:idb_shim/idb_shim.dart';
import 'package:tweethistory/models/tag.dart';
import 'package:tweethistory/models/tweet.dart';
import 'package:tweethistory/repository/tweet_repository.dart';

void main() {
  group('TweetRepository', () {
    late TweetRepository repository;
    late IdbFactory idbFactory;

    setUp(() async {
      idbFactory = idbFactoryMemory;
      await idbFactory.deleteDatabase('tweet_db');
      repository = await TweetRepository.create(factory: idbFactory);
    });

    group('tweets', () {
      test(
        'saveTweets should store tweets and loadAllTweets should retrieve them',
        () async {
          final tweets = [
            Tweet(
              id: '1',
              text: 'Test tweet 1',
              createdAt: DateTime(2025, 1, 1),
            ),
            Tweet(
              id: '2',
              text: 'Test tweet 2',
              createdAt: DateTime(2025, 1, 2),
            ),
          ];

          await repository.saveTweets(tweets);
          final loadedTweets = await repository.loadAllTweets();

          expect(loadedTweets.length, equals(2));
          expect(loadedTweets[0].id, equals('1'));
          expect(loadedTweets[0].text, equals('Test tweet 1'));
          expect(loadedTweets[1].id, equals('2'));
          expect(loadedTweets[1].text, equals('Test tweet 2'));
        },
      );
    });

    group('tags', () {
      test('addTag should create a new tag', () async {
        const tagName = 'testTag';
        await repository.addTag(tagName);

        final loadedTag = await repository.loadTag(tagName);
        expect(loadedTag, isNotNull);
        expect(loadedTag?.name, equals(tagName));
        expect(loadedTag?.tweetIds, isEmpty);
      });

      test('saveTag should update existing tag', () async {
        final tag = Tag(name: 'testTag', tweetIds: {'1', '2'});

        final savedIds = await repository.saveTag(tag);
        expect(savedIds, equals({'1', '2'}));

        final loadedTag = await repository.loadTag(tag.name);
        expect(loadedTag?.tweetIds, equals({'1', '2'}));
      });

      test(
        'removeIdsFromTag should remove specified tweet IDs from tag',
        () async {
          final tag = Tag(name: 'testTag', tweetIds: {'1', '2', '3'});
          await repository.saveTag(tag);

          final updatedIds = await repository.removeIdsFromTag(tag, {'2', '3'});
          expect(updatedIds, equals({'1'}));

          final loadedTag = await repository.loadTag(tag.name);
          expect(loadedTag?.tweetIds, equals({'1'}));
        },
      );

      test('loadTags should return all tags except bin', () async {
        await repository.addTag('tag1');
        await repository.addTag('tag2');
        await repository.addTag(tagNameBin);

        final tags = await repository.loadTags();

        expect(tags.length, equals(2));
        expect(tags.every((tag) => tag.name != tagNameBin), isTrue);
      });

      test('loadAllTags should return all tags including bin', () async {
        await repository.addTag('tag1');
        await repository.addTag('tag2');
        await repository.addTag(tagNameBin);

        final tags = await repository.loadAllTags();

        expect(tags.length, equals(3));
        expect(tags.any((tag) => tag.name == tagNameBin), isTrue);
      });

      group('bin tag special behavior', () {
        test(
          'binTag should be preserved and accessible through loadAllTags',
          () async {
            await repository.addTag(tagNameBin);
            await repository.saveTag(
              Tag(name: tagNameBin, tweetIds: {'1', '2'}),
            );

            final allTags = await repository.loadAllTags();
            final regularTags = await repository.loadTags();

            expect(allTags.any((tag) => tag.name == tagNameBin), isTrue);
            expect(regularTags.any((tag) => tag.name == tagNameBin), isFalse);
          },
        );
      });

      group('deleteTweets', () {
        test('delete tweets from db and record ids', () async {
          final tweet1 = Tweet(
            id: '1',
            text: 't1',
            createdAt: DateTime(2025, 1, 1),
          );
          final tweet2 = Tweet(
            id: '2',
            text: 't2',
            createdAt: DateTime(2025, 1, 2),
          );
          await repository.saveTweets([tweet1, tweet2]);
          await repository.addTag(tagNameBin);
          await repository.saveTag(Tag(name: tagNameBin, tweetIds: {'1', '2'}));
          await repository.addTag('tag1');
          await repository.saveTag(Tag(name: 'tag1', tweetIds: {'1'}));

          await repository.deleteTweets({'1'});

          final tweets = await repository.loadAllTweets();
          expect(tweets.any((t) => t.id == '1'), isFalse);
          final binTag = await repository.loadTag(tagNameBin);
          expect(binTag?.tweetIds.contains('1'), isFalse);
          final tag1 = await repository.loadTag('tag1');
          expect(tag1?.tweetIds.contains('1'), isFalse);
          final deletedIds = await repository.loadDeletedIds();
          expect(deletedIds.contains('1'), isTrue);
        });
      });

      group('restoreTweets', () {
        test('remove ids from bin tag', () async {
          final tweet1 = Tweet(
            id: '1',
            text: 't1',
            createdAt: DateTime(2025, 1, 1),
          );
          final tweet2 = Tweet(
            id: '2',
            text: 't2',
            createdAt: DateTime(2025, 1, 2),
          );
          await repository.saveTweets([tweet1, tweet2]);
          await repository.addTag(tagNameBin);
          await repository.saveTag(Tag(name: tagNameBin, tweetIds: {'1', '2'}));

          await repository.restoreTweets({'1'});

          final binTag = await repository.loadTag(tagNameBin);
          expect(binTag?.tweetIds.contains('1'), isFalse);
          expect(binTag?.tweetIds.contains('2'), isTrue);
        });
      });
    });
  });
}
