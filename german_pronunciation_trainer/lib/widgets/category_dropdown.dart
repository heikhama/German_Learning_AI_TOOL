import 'package:flutter/material.dart';

import '../models/category_model.dart';

class CategoryDropdown extends StatelessWidget {
  final List<CategoryModel> categories;

  final int? selectedId;

  final ValueChanged<int?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: selectedId,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: "Learning Category",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.category),
      ),
      items: categories.map((category) {
        return DropdownMenuItem<int>(
          value: category.id,
          child: Text(
            category.name,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}