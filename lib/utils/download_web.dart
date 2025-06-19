import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

Future<void> downloadFile(String filename, Uint8List bytes) async {
  final file = web.File([bytes.toJS].toJS, filename);
  final url = web.URL.createObjectURL(file);
  final anchor =
      web.HTMLAnchorElement()
        ..href = url
        ..download = filename
        ..style.display = 'none';
  web.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
  web.URL.revokeObjectURL(url);
}
