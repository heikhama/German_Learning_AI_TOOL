import 'package:flutter/material.dart';

import '../core/app_text.dart';

class SectionTitle extends StatelessWidget {

  final String title;

  const SectionTitle({

    super.key,

    required this.title,

  });

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.symmetric(

        vertical: 10,

      ),

      child: Text(

        title,

        style: AppText.title,

      ),

    );

  }

}