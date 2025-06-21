import 'package:langchain/langchain.dart';
import 'package:langchain_ollama/langchain_ollama.dart';

Future<int?> rateTweetText(String text) async {
  final llm = ChatOllama(
    defaultOptions: ChatOllamaOptions(model: 'gemma3:12b'),
  );
  final res = await llm.invoke(
    PromptValue.string(
      'You are a tweet compliance reviewer.\n'
      "Rate the tweet's compliance risk from 0 to 10, outputting only the number.\n"
      'No explanation or comments.\n'
      '\n'
      'Example:\n'
      'Value: 0\n'
      'Value: 10\n'
      'Value: 2\n'
      '\n'
      '$text\n'
      'Value:\n',
    ),
  );
  final match = RegExp(r'\d+').firstMatch(res.output.content);
  return match != null ? int.parse(match.group(0)!) : null;
}
