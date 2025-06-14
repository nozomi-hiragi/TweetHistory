import 'dart:async';
import 'package:idb_shim/idb.dart';

import 'store_params.dart';

Future<Database> createDatabase(
  IdbFactory factory,
  String dbName, {
  int? version,
  required FutureOr<void> Function(
    VersionChangeEvent event,
    void Function(List<StoreParams>) createObjectStore,
  )
  onUpgradeNeeded,
  OnBlockedFunction? onBlocked,
}) async {
  return factory.open(
    dbName,
    version: version,
    onUpgradeNeeded:
        (e) => onUpgradeNeeded(e, (values) {
          final db = e.database;
          for (var store in values) {
            if (!db.objectStoreNames.contains(store.name)) {
              db.createObjectStore(store.name, keyPath: store.keyPath);
            }
          }
        }),
    onBlocked: onBlocked,
  );
}
