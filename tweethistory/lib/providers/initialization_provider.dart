import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repository_provider.dart';

final initializationProvider = FutureProvider((ref) async {
  await ref.read(repositoryProvider.future);
  return true;
});
