import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayView extends ConsumerStatefulWidget {
  const PlayView({Key? key}) : super(key: key);

  @override
  ConsumerState<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends ConsumerState<PlayView> {
  late WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(NavigationDelegate(
      onNavigationRequest: (request) => NavigationDecision.navigate,
      onUrlChange: (change) {
        if (change.url?.contains('exit') ?? false) {
          Navigator.pop(context);
        }
      },
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cms = ref.watch(newHomePageCMSProvider);
    final currentLang = ref.watch(currentLanguageProvider);
    final siteId = ref.watch(masterSiteProvider)?.siteId;
    final playUrl = cms!.playUrl(currentLang: currentLang, siteId: siteId.toString());
    if (playUrl != null) {
      controller.loadRequest(playUrl);
    }

    return Scaffold(
      body: SafeArea(
        child: playUrl == null
            ? const Center(
                child: Text('play url not present in CMS json file'),
              )
            : WebViewWidget(controller: controller),
      ),
    );
  }
}
