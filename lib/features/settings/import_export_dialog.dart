import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tweethistory/providers/tweet_controller.dart';

import '../../providers/data_transfer_controller.dart';
import '../../utils/download.dart';

class ImportExportDialog extends ConsumerWidget {
  const ImportExportDialog({super.key});

  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final repo = await ref.read(dataTransferControllerProvider.future);
    final data = await repo.exportAll();
    final jsonStr = repo.exportJson(data);
    final bytes = utf8.encode(jsonStr);
    await downloadFile('tweethistory_export.json', bytes);
    if (context.mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.exportSuccess)));
    }
  }

  Future<void> _importData(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    try {
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
      final repo = await ref.read(dataTransferControllerProvider.future);
      await repo.importAll(data);
      ref.read(tweetControllerProvider.notifier).refresh();

      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.importSuccess)));
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.importFailed(e.toString())),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.importExport),
      content: Text(l10n.chooseAction),
      actions: [
        TextButton(
          onPressed: () => _importData(context, ref),
          child: Text(l10n.importData),
        ),
        TextButton(
          onPressed: () => _exportData(context, ref),
          child: Text(l10n.exportData),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
      ],
    );
  }
}
