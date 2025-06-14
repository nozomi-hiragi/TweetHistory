import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TagSelectDialog extends HookWidget {
  const TagSelectDialog({super.key, required this.tagStatus});

  final Map<String, bool?> tagStatus;

  @override
  Widget build(BuildContext context) {
    final selectState = useState(tagStatus);
    return AlertDialog(
      title: const Text('タグを選択'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children:
              selectState.value.entries.map((e) {
                return CheckboxListTile(
                  title: Text(e.key),
                  value: e.value,
                  tristate: e.value == null,
                  onChanged: (checked) {
                    selectState.value = {...selectState.value, e.key: checked};
                  },
                  controlAffinity: ListTileControlAffinity.platform,
                );
              }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('キャンセル'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text('適用'),
          onPressed: () {
            final result = selectState.value.map(
              (key, value) =>
                  MapEntry(key, value == tagStatus[key] ? null : value),
            );
            Navigator.of(context).pop(result);
          },
        ),
      ],
    );
  }
}
