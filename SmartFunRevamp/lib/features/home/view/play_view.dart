import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/cms_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayView extends ConsumerStatefulWidget {
  const PlayView({Key? key}) : super(key: key);

  @override
  ConsumerState<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends ConsumerState<PlayView> {
  final controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  Widget build(BuildContext context) {
    final cms = ref.watch(cmsProvider).value;
    final currentLang = ref.watch(currentLanguageProvider);
    final playUrl = cms!.playUrl(currentLang: currentLang);

    if (playUrl != null) {
      controller.loadRequest(playUrl);
    }

    return Scaffold(
      appBar: AppBar(),
      body: playUrl == null
          ? const Center(
              child: Text('play url not present in CMS json file'),
            )
          : WebViewWidget(controller: controller),
    );
  }
}
