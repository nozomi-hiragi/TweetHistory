import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tweet.dart';
import '../state/tweet_loader_state.dart';

class StreamTweetLoaderNotifier extends StreamNotifier<TweetLoaderState> {
  Uint8List? _bytes;

  void load(Uint8List bytes) {
    _bytes = bytes;
    ref.invalidateSelf();
  }

  String? _extractJsonArray(String rawJsContent) {
    const prefix = 'window.YTD.tweets.part0 = ';
    final startIndex = rawJsContent.indexOf(prefix);
    if (startIndex == -1) return null;

    final jsonStart = startIndex + prefix.length;
    final trimmed = rawJsContent.substring(jsonStart).trim();

    return trimmed.endsWith(';')
        ? trimmed.substring(0, trimmed.length - 1)
        : trimmed;
  }

  Future<List<T>> _decodeJsonArray<T>(
    String source, {
    FutureOr<T> Function(Map<String, dynamic>)? converter,
    Future<void> Function(double)? onProgress,
  }) async {
    final List<T> results = [];
    final buffer = StringBuffer();
    int bracketCount = 0;
    bool insideString = false;

    source = source.trim();
    if (source.startsWith('[') && source.endsWith(']')) {
      source = source.substring(1, source.length - 1);
    }

    double lastProgress = 0;
    for (int i = 0; i < source.length; i++) {
      final char = source[i];
      buffer.write(char);

      if (char == '"') {
        final prev = i > 0 ? source[i - 1] : '';
        if (prev != r'\') insideString = !insideString;
      }

      if (!insideString) {
        if (char == '{') {
          bracketCount++;
        } else if (char == '}') {
          bracketCount--;
        }
      }

      if (bracketCount == 0 && buffer.isNotEmpty) {
        final jsonStr = buffer.toString().trim();
        if (jsonStr.isNotEmpty && jsonStr != ',') {
          try {
            final obj = json.decode(jsonStr);
            if (obj is Map<String, dynamic>) {
              final res = converter != null ? await converter(obj) : obj as T;
              results.add(res);
            }
          } catch (e) {
            throw Exception('❌ JSON decode error: $e\n/$jsonStr/');
          }
        }
        buffer.clear();
      }
      if (onProgress != null) {
        final progress = i / source.length;
        if (progress - lastProgress > 0.02) {
          lastProgress = progress;
          await onProgress(lastProgress);
        }
      }
    }
    return results;
  }

  @override
  Stream<TweetLoaderState> build() {
    final controller = StreamController<TweetLoaderState>();

    Future<void> run() async {
      await Future.delayed(Duration.zero);
      double lastProgress = 0.0;
      final bytes = _bytes;
      if (bytes == null) return controller.add(const TweetLoaderState());

      try {
        const chunkSize = 1024 * 1024;
        final contentBuilder = StringBuffer();
        final totalChunks = (bytes.length / chunkSize).ceil();
        var currentChunk = 0;

        for (var i = 0; i < bytes.length; i += chunkSize) {
          final end =
              (i + chunkSize < bytes.length) ? i + chunkSize : bytes.length;
          final chunk = bytes.sublist(i, end);
          contentBuilder.write(utf8.decode(chunk, allowMalformed: true));

          currentChunk++;
          final progress = (currentChunk / totalChunks) * 0.5;
          lastProgress = progress;
          controller.add(TweetLoaderState(progress: lastProgress));
          await Future.delayed(Duration.zero);
        }
        final content = contentBuilder.toString();

        final jsonStr = _extractJsonArray(content);
        if (jsonStr == null) {
          final message = '無効なファイル形式です';
          controller.add(TweetLoaderState(error: message));
          return;
        }

        lastProgress = 0;
        final tweets = await _decodeJsonArray(
          jsonStr,
          converter: (json) => Tweet.fromRawJson(json),
          onProgress: (progress) async {
            progress = 0.5 + (progress * 0.5);
            lastProgress = progress;
            controller.add(TweetLoaderState(progress: lastProgress));
            await Future.delayed(Duration.zero);
          },
        );

        controller.add(TweetLoaderState(progress: 1.0, tweets: tweets));
        await Future.delayed(Duration.zero);
      } catch (e) {
        state = AsyncError(e.toString(), StackTrace.current);
        controller.add(TweetLoaderState(error: e.toString()));
      } finally {
        _bytes = null;
      }
    }

    run();
    return controller.stream;
  }
}

final streamTweetLoaderProvider =
    StreamNotifierProvider<StreamTweetLoaderNotifier, TweetLoaderState>(
      () => StreamTweetLoaderNotifier(),
    );
