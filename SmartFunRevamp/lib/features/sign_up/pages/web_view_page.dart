import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/widgets/custom_app_bar.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key, required this.url, required this.title});
  final String url;
  final String title;
  @override
  Widget build(BuildContext context) {
    final webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: CustomAppBar(title: SplashScreenNotifier.getLanguageLabel(title)),
      //  AppBar(
      //   title: Text(
      //     SplashScreenNotifier.getLanguageLabel(title),
      //     style: const TextStyle(
      //       color: CustomColors.customBlue,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.80,
              child: WebViewWidget(controller: webviewController),
            ),
          ],
        ),
      ),
    );
  }
}
