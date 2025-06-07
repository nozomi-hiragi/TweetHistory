import 'package:idb_shim/idb.dart';

final ddd = ((obj) => obj as Object);

abstract class StoreBase {
  final String storeName;
  final String keyPath;

  StoreBase(this.storeName, this.keyPath);

  void createObjectStore(Database db) {
    if (db.objectStoreNames.contains(storeName)) return;
    db.createObjectStore(storeName, keyPath: keyPath);
  }

  Future<void> add(Database db, Object obj) async {
    final txn = db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    await store.add(obj);
    await txn.completed;
  }

  Future<void> updateTag(Database db, Object obj) async {
    final txn = db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    await store.put(obj);
    await txn.completed;
  }

  Future<void> putList<T>(
    Database db,
    List<T> objects,
    Object Function(T obj)? converter,
  ) async {
    final cvt = converter ?? ((obj) => obj as Object);
    final txn = db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    for (final obj in objects) {
      await store.put(cvt(obj));
    }
    await txn.completed;
  }

  Future<Object?> get(Database db, Object key) async {
    final txn = db.transaction(storeName, idbModeReadOnly);
    final store = txn.objectStore(storeName);
    final record = await store.getObject(key);
    await txn.completed;
    return record;
  }

  Future<List<T>> getAll<T>(
    Database db,
    T Function(Map<String, dynamic> obj)? converter,
  ) async {
    final cvt = converter ?? ((obj) => obj as T);
    final txn = db.transaction(storeName, idbModeReadOnly);
    final store = txn.objectStore(storeName);
    final records = await store.getAll();
    await txn.completed;
    final List<T> results =
        records.cast<Map<String, dynamic>>().map(cvt).toList();
    return results;
  }

  Future<void> delete(Database db, Object keyOrRange) async {
    final txn = db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    await store.delete(keyOrRange);
    await txn.completed;
  }

  Future<void> clear(Database db) async {
    final txn = db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    await store.clear();
    await txn.completed;
  }

  Future<void> deleteTag(Database db, String name) async {
    final txn = db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    await store.delete(name);
    await txn.completed;
  }
}
