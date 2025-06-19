import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

Future<void> downloadFile(String filename, Uint8List bytes) async {
  final path = await FilePicker.platform.saveFile(
    dialogTitle: 'ファイルを保存',
    fileName: filename,
  );
  
  if (path != null) {
    final file = File(path);
    await file.writeAsBytes(bytes);
  }
}