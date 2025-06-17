import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/repository_providers.dart';
import '../../utils/download.dart';

class ImportExportDialog extends ConsumerWidget {
  const ImportExportDialog({super.key});

  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    final repo = await ref.read(dataTransferRepositoryProvider.future);
    final data = await repo.exportAll();
    final jsonStr = repo.exportJson(data);
    final bytes = utf8.encode(jsonStr);
    if (kIsWeb) {
      downloadFile('tweethistory_export.json', bytes);
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Exported')));
      }
    } else {
      await Clipboard.setData(ClipboardData(text: jsonStr));
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data copied to clipboard')),
        );
      }
    }
  }

  Future<void> _importData(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final bytes = result.files.single.bytes;
    if (bytes == null) return;
    final jsonStr = utf8.decode(bytes);
    final data = jsonDecode(jsonStr) as Map<String, dynamic>;
    final repo = await ref.read(dataTransferRepositoryProvider.future);
    await repo.importAll(data);
    if (context.mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Imported')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Import / Export'),
      content: const Text('Choose an action'),
      actions: [
        TextButton(
          onPressed: () => _importData(context, ref),
          child: const Text('Import'),
        ),
        TextButton(
          onPressed: () => _exportData(context, ref),
          child: const Text('Export'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
