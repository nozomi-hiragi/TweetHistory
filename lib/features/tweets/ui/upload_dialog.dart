import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';

import '../../../l10n/app_localizations.dart';

Future<Result<Uint8List>> _pickJsFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['js'],
    withData: true,
  );
  if (result == null || result.files.isEmpty) {
    return Failure(Exception('ファイルが選択されていません'));
  }

  final bytes = result.files.single.bytes;
  if (bytes == null || bytes.isEmpty) {
    return Failure(Exception('データがNULL'));
  }
  return Success(bytes);
}

class UploadDialog extends StatelessWidget {
  const UploadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(l10n.uploadTweetsFile),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.selectFileToUpload),
          const SizedBox(height: 12),
          if (kIsWeb)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                l10n.webBrowserWarning,
                style: TextStyle(
                  color: theme.colorScheme.error,
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _pickJsFile().then((result) {
              result.fold(
                (bytes) {
                  Navigator.of(context).pop(bytes);
                },
                (failure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(failure.toString())));
                  Navigator.of(context).pop();
                },
              );
            });
          },
          child: Text(l10n.upload),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
      ],
    );
  }
}
