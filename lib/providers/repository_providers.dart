import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository/tweet_repository.dart';
import '../repository/preferences_repository.dart';
import '../repository/data_transfer_repository.dart';

final tweetRepositoryProvider = FutureProvider<TweetRepository>(
  (ref) => TweetRepository.create(),
);

final preferencesRepositoryProvider = FutureProvider<PreferencesRepository>(
  (ref) => PreferencesRepository.create(),
);

final dataTransferRepositoryProvider = FutureProvider<DataTransferRepository>((
  ref,
) async {
  final tweetRepo = await ref.watch(tweetRepositoryProvider.future);
  final prefRepo = await ref.watch(preferencesRepositoryProvider.future);
  return DataTransferRepository(
    tweetRepository: tweetRepo,
    preferencesRepository: prefRepo,
  );
});
