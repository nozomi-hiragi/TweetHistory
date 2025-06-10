import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'repository_provider.dart';

final initializationProvider = FutureProvider((ref) async {
  await ref.read(repositoryProvider.future);
  return true;
});
