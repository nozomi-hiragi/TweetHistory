import 'package:flutter_test/flutter_test.dart';
import 'package:idb_shim/idb_shim.dart';
import 'package:tweethistory/storage/store.dart';

void main() {
  late IdbFactory idbFactory;
  late Database db;
  late Store store;

  setUp(() async {
    // メモリ内データベースを使用してテスト
    idbFactory = idbFactoryMemory;
    db = await idbFactory.open(
      'test.db',
      version: 1,
      onUpgradeNeeded: (VersionChangeEvent event) {
        // テスト用のデータベースをセットアップ
        final db = event.database;
        if (!db.objectStoreNames.contains('test_store')) {
          db.createObjectStore('test_store', keyPath: 'id');
        }
      },
    );
    store = Store(db, 'test_store');
  });

  tearDown(() async {
    db.close();
  });

  test('add - オブジェクトを追加できること', () async {
    final testObj = {'id': 1, 'name': 'test'};
    await store.add(testObj);

    final result = await store.get(1);
    expect(result, testObj);
  });

  test('put - オブジェクトを更新できること', () async {
    final testObj = {'id': 1, 'name': 'test'};
    await store.put(testObj);

    final updatedObj = {'id': 1, 'name': 'updated'};
    await store.put(updatedObj);

    final result = await store.get(1);
    expect(result, updatedObj);
  });

  test('putList - 複数のオブジェクトを追加・更新できること', () async {
    final testObjs = [
      {'id': 1, 'name': 'test1'},
      {'id': 2, 'name': 'test2'},
    ];
    await store.putList(testObjs, null);

    final results = await store.getAll((obj) => obj);
    expect(results.length, 2);
    expect(results[0]['name'], 'test1');
    expect(results[1]['name'], 'test2');
  });

  test('getAll - すべてのオブジェクトを取得できること', () async {
    final testObjs = [
      {'id': 1, 'name': 'test1'},
      {'id': 2, 'name': 'test2'},
    ];
    await store.putList(testObjs, null);

    final results = await store.getAll((obj) => obj);
    expect(results.length, 2);
    expect(results, containsAll(testObjs));
  });

  test('delete - オブジェクトを削除できること', () async {
    final testObj = {'id': 1, 'name': 'test'};
    await store.put(testObj);

    await store.delete(1);
    final result = await store.get(1);
    expect(result, null);
  });

  test('clear - すべてのオブジェクトを削除できること', () async {
    final testObjs = [
      {'id': 1, 'name': 'test1'},
      {'id': 2, 'name': 'test2'},
    ];
    await store.putList(testObjs, null);

    await store.clear();
    final results = await store.getAll((obj) => obj);
    expect(results.isEmpty, true);
  });

  test('deleteTag - タグを削除できること', () async {
    final tag = {'id': 'tag1', 'name': 'Test Tag'};
    await store.put(tag);

    await store.deleteTag('tag1');
    final result = await store.get('tag1');
    expect(result, null);
  });
}
