import 'package:flutter/material.dart';

import '../models/difficulty_model.dart';

class DifficultyDropdown extends StatelessWidget {
  final List<DifficultyModel> levels;

  final int? selectedId;

  final ValueChanged<int?> onChanged;

  const DifficultyDropdown({
    super.key,
    required this.levels,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: selectedId,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: "Difficulty Level",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.school),
      ),
      items: levels.map((level) {
        return DropdownMenuItem<int>(
          value: level.id,
          child: Text(level.level),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}