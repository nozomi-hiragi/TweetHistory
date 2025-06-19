import 'package:flutter_test/flutter_test.dart';
import 'package:idb_shim/idb_client_memory.dart';

import 'package:tweethistory/models/tag.dart';
import 'package:tweethistory/repository/tweet_repository.dart';

void main() {
  group('Tag Operations Tests', () {
    late TweetRepository repository;

    setUp(() async {
      repository = await TweetRepository.create(factory: idbFactoryMemory);
    });

    group('renameTag', () {
      test('should successfully rename a tag', () async {
        // Setup: Create a tag with some tweet IDs
        const oldName = 'test-tag';
        const newName = 'renamed-tag';
        final tag = Tag(name: oldName, tweetIds: {'tweet1', 'tweet2'});
        await repository.saveTag(tag);

        // Execute: Rename the tag
        final result = await repository.renameTag(oldName, newName);

        // Verify: Check the result and that the tag was renamed
        expect(result, isTrue);

        final oldTag = await repository.loadTag(oldName);
        final newTag = await repository.loadTag(newName);

        expect(oldTag, isNull);
        expect(newTag, isNotNull);
        expect(newTag!.name, equals(newName));
        expect(newTag.tweetIds, equals({'tweet1', 'tweet2'}));
      });

      test('should fail to rename when new name already exists', () async {
        // Setup: Create two tags
        const oldName = 'test-tag-1';
        const newName = 'test-tag-2';
        final tag1 = Tag(name: oldName, tweetIds: {'tweet1'});
        final tag2 = Tag(name: newName, tweetIds: {'tweet2'});
        await repository.saveTag(tag1);
        await repository.saveTag(tag2);

        // Execute: Try to rename to existing name
        final result = await repository.renameTag(oldName, newName);

        // Verify: Operation should fail
        expect(result, isFalse);

        final originalTag = await repository.loadTag(oldName);
        expect(originalTag, isNotNull);
        expect(originalTag!.tweetIds, equals({'tweet1'}));
      });

      test('should fail to rename bin tag', () async {
        // Setup: Create bin tag
        final binTag = Tag(name: tagNameBin, tweetIds: {'tweet1'});
        await repository.saveTag(binTag);

        // Execute: Try to rename bin tag
        final result = await repository.renameTag(tagNameBin, 'new-name');

        // Verify: Operation should fail
        expect(result, isFalse);

        final tag = await repository.loadTag(tagNameBin);
        expect(tag, isNotNull);
        expect(tag!.name, equals(tagNameBin));
      });

      test('should fail to rename non-existent tag', () async {
        // Execute: Try to rename non-existent tag
        final result = await repository.renameTag('non-existent', 'new-name');

        // Verify: Operation should fail
        expect(result, isFalse);
      });
    });

    group('deleteTag', () {
      test('should successfully delete a tag', () async {
        // Setup: Create a tag
        const tagName = 'test-tag';
        final tag = Tag(name: tagName, tweetIds: {'tweet1', 'tweet2'});
        await repository.saveTag(tag);

        // Execute: Delete the tag
        final result = await repository.deleteTag(tagName);

        // Verify: Check the result and that the tag was deleted
        expect(result, isTrue);

        final deletedTag = await repository.loadTag(tagName);
        expect(deletedTag, isNull);
      });

      test('should fail to delete bin tag', () async {
        // Setup: Create bin tag
        final binTag = Tag(name: tagNameBin, tweetIds: {'tweet1'});
        await repository.saveTag(binTag);

        // Execute: Try to delete bin tag
        final result = await repository.deleteTag(tagNameBin);

        // Verify: Operation should fail
        expect(result, isFalse);

        final tag = await repository.loadTag(tagNameBin);
        expect(tag, isNotNull);
      });

      test('should fail to delete non-existent tag', () async {
        // Execute: Try to delete non-existent tag
        final result = await repository.deleteTag('non-existent');

        // Verify: Operation should fail
        expect(result, isFalse);
      });

      test('should successfully delete tag with empty tweet IDs', () async {
        // Setup: Create a tag with no tweet IDs
        const tagName = 'empty-tag';
        final tag = Tag(name: tagName, tweetIds: <String>{});
        await repository.saveTag(tag);

        // Execute: Delete the tag
        final result = await repository.deleteTag(tagName);

        // Verify: Check the result and that the tag was deleted
        expect(result, isTrue);

        final deletedTag = await repository.loadTag(tagName);
        expect(deletedTag, isNull);
      });
    });

    group('Integration Tests', () {
      test('should handle multiple tag operations correctly', () async {
        // Setup: Create multiple tags
        final tags = [
          Tag(name: 'tag1', tweetIds: {'tweet1', 'tweet2'}),
          Tag(name: 'tag2', tweetIds: {'tweet3'}),
          Tag(name: 'tag3', tweetIds: <String>{}),
        ];

        for (final tag in tags) {
          await repository.saveTag(tag);
        }

        // Execute: Rename tag1 to tag1-renamed
        final renameResult = await repository.renameTag('tag1', 'tag1-renamed');
        expect(renameResult, isTrue);

        // Execute: Delete tag2
        final deleteResult = await repository.deleteTag('tag2');
        expect(deleteResult, isTrue);

        // Verify: Check final state
        final allTags = await repository.loadAllTags();
        final tagNames = allTags.map((tag) => tag.name).toSet();

        expect(tagNames, contains('tag1-renamed'));
        expect(tagNames, isNot(contains('tag1')));
        expect(tagNames, isNot(contains('tag2')));
        expect(tagNames, contains('tag3'));

        // Verify renamed tag preserved tweet IDs
        final renamedTag = await repository.loadTag('tag1-renamed');
        expect(renamedTag!.tweetIds, equals({'tweet1', 'tweet2'}));
      });
    });
  });
}
