import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'repository_providers.dart';

final initializationProvider = FutureProvider((ref) async {
  await Future.any([
    ref.read(tweetRepositoryProvider.future),
    ref.read(preferencesRepositoryProvider.future),
  ]);
  return true;
});
