import 'package:idb_shim/idb.dart';

import 'store.dart';

class StoreParams {
  final String name;
  final Object? keyPath;
  final bool? autoIncrement;

  const StoreParams(this.name, [this.keyPath, this.autoIncrement]);

  static Map<T, Store> createStores<T extends StoreParams>(
    Database db,
    List<T> values,
  ) => Map.fromEntries(
    values.map((value) => MapEntry(value, Store(db, value.name))),
  );
}
