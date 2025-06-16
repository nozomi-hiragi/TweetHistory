import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:idb_shim/idb_shim.dart';
import 'package:tweethistory/models/tag.dart';
import 'package:tweethistory/models/tweet.dart';
import 'package:tweethistory/providers/repository_providers.dart';
import 'package:tweethistory/providers/tweet_controller.dart';
import 'package:tweethistory/repository/tweet_repository.dart';

void main() {
  group('TweetController', () {
    late ProviderContainer container;
    late TweetRepository repository;
    setUp(() async {
      final idbFactory = idbFactoryMemory;
      await idbFactory.deleteDatabase('tweet_db');
      repository = await TweetRepository.create(factory: idbFactory);
      container = ProviderContainer(overrides: [
        tweetRepositoryProvider.overrideWith((ref) async => repository),
      ]);
    });

    test('deleteTweet should remove tweet id from all tags', () async {
      await repository.saveTweets([
        Tweet(id: '1', text: 't1', createdAt: DateTime(2025, 1, 1)),
      ]);
      await repository.addTag('tag1');
      await repository.saveTag(Tag(name: 'tag1', tweetIds: {'1'}));

      final controller = container.read(tweetControllerProvider.notifier);
      await controller.deleteTweet('1');

      final tag = await repository.loadTag('tag1');
      expect(tag?.tweetIds.contains('1'), isFalse);
      final deletedIds = await repository.loadDeletedIds();
      expect(deletedIds.contains('1'), isTrue);
    });
  });
}
