import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository/tweet_repository.dart';
import '../repository/preferences_repository.dart';

final tweetRepositoryProvider = FutureProvider<TweetRepository>(
  (ref) => TweetRepository.create(),
);

final preferencesRepositoryProvider = FutureProvider<PreferencesRepository>(
  (ref) => PreferencesRepository.create(),
);
