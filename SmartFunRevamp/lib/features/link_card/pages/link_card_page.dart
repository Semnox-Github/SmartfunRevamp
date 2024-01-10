import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../home/widgets/link_a_card.dart';
import '../../splash/provider/splash_screen_notifier.dart';

class LinkCardPage extends StatelessWidget {
  const LinkCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(
          title: SplashScreenNotifier.getLanguageLabel("Link A Card"),
        ),
      //  AppBar(
      //   title: const Text('Link A Card'),
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.zero,
      //   ),
      // ),
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
