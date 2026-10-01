import 'package:flutter/material.dart';

import '../../../domain/models/transaction.dart';
import '../formatters.dart';

/// Asks for a category. Resolves to the chosen value, or null if dismissed.
Future<String?> showCategoryPicker(
  BuildContext context, {
  required String selected,
}) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => _CategoryPickerDialog(selected: selected),
  );
}

class _CategoryPickerDialog extends StatefulWidget {
  const _CategoryPickerDialog({required this.selected});

  final String selected;

  @override
  State<_CategoryPickerDialog> createState() => _CategoryPickerDialogState();
}

class _CategoryPickerDialogState extends State<_CategoryPickerDialog> {
  late final TextEditingController _customController = TextEditingController();

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  void _submitCustom() {
    final String custom = _customController.text.trim().toLowerCase();
    if (custom.isEmpty) return;
    Navigator.of(context).pop(custom);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Category'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RadioGroup<String>(
              groupValue: widget.selected,
              onChanged: (String? value) => Navigator.of(context).pop(value),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (final String category in kKnownCategories)
                    RadioListTile<String>(
                      value: category,
                      title: Text(categoryLabel(category)),
                      contentPadding: EdgeInsets.zero,
                    ),
                ],
              ),
            ),
            const Divider(),
            TextField(
              controller: _customController,
              textCapitalization: TextCapitalization.none,
              decoration: const InputDecoration(
                labelText: 'Other',
                hintText: 'e.g. health',
              ),
              onSubmitted: (_) => _submitCustom(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: _submitCustom, child: const Text('Use other')),
      ],
    );
  }
}
