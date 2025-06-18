import 'package:idb_shim/idb.dart';

class Store {
  final Database _db;
  final String storeName;

  Store(this._db, this.storeName);

  Future<void> add(Object obj) async {
    final txn = _db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    await store.add(obj);
    await txn.completed;
  }

  Future<void> put(Object obj) async {
    final txn = _db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    await store.put(obj);
    await txn.completed;
  }

  Future<void> putList<T>(
    List<T> objects, {
    Object Function(T obj)? converter,
  }) async {
    final cvt = converter ?? ((obj) => obj as Object);
    final txn = _db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    for (final obj in objects) {
      await store.put(cvt(obj));
    }
    await txn.completed;
  }

  Future<Object?> get(Object key) async {
    final txn = _db.transaction(storeName, idbModeReadOnly);
    final store = txn.objectStore(storeName);
    final record = await store.getObject(key);
    await txn.completed;
    return record;
  }

  Future<List<T>> getAll<T>({
    T Function(Map<String, dynamic> obj)? converter,
  }) async {
    final cvt = converter ?? ((obj) => obj as T);
    final txn = _db.transaction(storeName, idbModeReadOnly);
    final store = txn.objectStore(storeName);
    final records = await store.getAll();
    await txn.completed;
    final List<T> results =
        records.cast<Map<String, dynamic>>().map(cvt).toList();
    return results;
  }

  Future<void> delete(Object keyOrRange) async {
    final txn = _db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    await store.delete(keyOrRange);
    await txn.completed;
  }

  Future<void> clear() async {
    final txn = _db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    await store.clear();
    await txn.completed;
  }

  Future<void> deleteTag(String name) async {
    final txn = _db.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    await store.delete(name);
    await txn.completed;
  }
}
