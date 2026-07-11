import 'package:flutter/material.dart';

import '../models/language_model.dart';

class LanguageDropdown extends StatelessWidget {
  final List<LanguageModel> languages;

  final int? selectedId;

  final ValueChanged<int?> onChanged;

  const LanguageDropdown({
    super.key,
    required this.languages,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: selectedId,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: "Learning Language",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.language),
      ),
      items: languages.map((language) {
        return DropdownMenuItem<int>(
          value: language.id,
          child: Row(
            children: [
              Text(
                language.flag,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  language.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}