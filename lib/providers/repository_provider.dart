import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository/tweet_repository.dart';

class RepositoryNotifier extends AsyncNotifier<TweetRepository> {
  @override
  Future<TweetRepository> build() async {
    final repository = TweetRepository();
    await repository.init();
    return repository;
  }
}

final repositoryProvider =
    AsyncNotifierProvider<RepositoryNotifier, TweetRepository>(
      () => RepositoryNotifier(),
    );
