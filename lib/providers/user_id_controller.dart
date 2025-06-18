import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'repository_providers.dart';

class UserIdController extends Notifier<String?> {
  @override
  String? build() {
    ref
        .watch(preferencesRepositoryProvider.future)
        .then((repo) => state = repo.userId);
    return null;
  }

  Future<void> setUserId(String? userId) async {
    final repo = await ref.watch(preferencesRepositoryProvider.future);
    repo.userId = userId;
    state = userId;
  }
}

final userIdControllerProvider = NotifierProvider<UserIdController, String?>(
  UserIdController.new,
);
