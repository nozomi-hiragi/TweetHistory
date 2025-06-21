import 'dart:core';

enum ParseNodeType { and, or, not, word, phrase }

class ParseNode {
  final ParseNodeType type;
  final String? value;
  final List<ParseNode> children;
  ParseNode(this.type, {this.value, this.children = const []});
}

class QueryParser {
  late int index;
  late ParseNode node;

  static List<String> _tokenize(String query) {
    query = query.replaceAllMapped(
      RegExp(r'\bor\b', caseSensitive: false),
      (match) => '|',
    );
    query = query.replaceAllMapped(
      RegExp(r'\band\b', caseSensitive: false),
      (match) => ' ',
    );

    final reg = RegExp(
      r'(\()|(\))|(\|)|(-)|("([^"]*)"|'
      r"'([^']*)')"
      r'|([^\s\(\)\|-]+)',
      unicode: true,
    );
    return reg.allMatches(query).map((m) => m.group(0)!).toList();
  }

  static ParseNode _combineWithAnd(List<ParseNode> nodes) {
    if (nodes.isEmpty) return ParseNode(ParseNodeType.word, value: '');
    if (nodes.length == 1) return nodes[0];

    ParseNode result = nodes[0];
    for (var i = 1; i < nodes.length; i++) {
      result = ParseNode(ParseNodeType.and, children: [result, nodes[i]]);
    }
    return result;
  }

  static QueryParser parse(String query) {
    final lowerQuery = query.toLowerCase().trim();
    final tokens = QueryParser._tokenize(lowerQuery);
    final parser = QueryParser(tokens);
    return parser;
  }

  QueryParser(List<String> tokens, {this.index = 0}) {
    final nodes = <ParseNode>[];

    while (index < tokens.length) {
      final token = tokens[index];

      if (token == '(') {
        final result = QueryParser(tokens, index: index + 1);
        nodes.add(result.node);
        index = result.index;
      } else if (token == ')') {
        index += 1;
        break;
      } else if (token == '|') {
        final left = _combineWithAnd(nodes);
        nodes.clear();

        final result = QueryParser(tokens, index: index + 1);
        nodes.add(ParseNode(ParseNodeType.or, children: [left, result.node]));
        index = result.index;
      } else if (token == '-') {
        index += 1;
        if (index < tokens.length) {
          final nextToken = tokens[index];
          if (nextToken == '(') {
            final result = QueryParser(tokens, index: index + 1);
            nodes.add(ParseNode(ParseNodeType.not, children: [result.node]));
            index = result.index;
          } else {
            nodes.add(
              ParseNode(
                ParseNodeType.not,
                children: [ParseNode(ParseNodeType.word, value: nextToken)],
              ),
            );
            index += 1;
          }
        }
      } else if ((token.startsWith("'") && token.endsWith("'")) ||
          (token.startsWith('"') && token.endsWith('"'))) {
        final phraseValue = token.substring(1, token.length - 1);
        nodes.add(ParseNode(ParseNodeType.phrase, value: phraseValue));
        index += 1;
      } else {
        nodes.add(ParseNode(ParseNodeType.word, value: token));
        index += 1;
      }
    }
    node = _combineWithAnd(nodes);
  }

  bool match(String text, {ParseNode? node}) {
    node ??= this.node;
    text = text.toLowerCase();
    switch (node.type) {
      case ParseNodeType.word:
        return text.contains(node.value!.toLowerCase());
      case ParseNodeType.phrase:
        return text.contains(node.value!.toLowerCase());
      case ParseNodeType.not:
        return !match(text, node: node.children[0]);
      case ParseNodeType.and:
        return node.children.every((child) => match(text, node: child));
      case ParseNodeType.or:
        return node.children.any((child) => match(text, node: child));
    }
  }
}
