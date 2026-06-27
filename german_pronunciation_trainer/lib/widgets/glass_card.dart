import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {

  final Widget child;

  const GlassCard({

    super.key,

    required this.child,

  });

  @override
  Widget build(BuildContext context) {

    return Container(

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withOpacity(.06),

            blurRadius: 18,

            offset: const Offset(0,8),

          ),

        ],

      ),

      padding: const EdgeInsets.all(18),

      child: child,

    );

  }

}