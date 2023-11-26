import 'package:flutter/material.dart';
import '../../home/widgets/link_a_card.dart';

class LinkCardPage extends StatelessWidget {
  const LinkCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link A Card'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      body: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.purple.shade500,
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: LinkACard(),
      ),
    );
  }
}
