import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'repository_providers.dart';

final initializationProvider = FutureProvider((ref) async {
  await Future.wait([
    initializeDateFormatting('ja_JP', null),
    initializeDateFormatting('en_US', null),
  ]);
  await Future.any([
    ref.read(tweetRepositoryProvider.future),
    ref.read(preferencesRepositoryProvider.future),
  ]);
  return true;
});
