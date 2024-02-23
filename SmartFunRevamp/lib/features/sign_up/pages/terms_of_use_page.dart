import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/widgets/custom_app_bar.dart';
import '../../splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

class TermsOfUsePage extends ConsumerStatefulWidget {
  const TermsOfUsePage({Key? key}) : super(key: key);

  @override
  ConsumerState<TermsOfUsePage> createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends ConsumerState<TermsOfUsePage> {
  final webviewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(SplashScreenNotifier.getLookupValue("Terms")));

  @override
  Widget build(BuildContext context) {
    final cmsBody = ref.watch(cmsBodyStyleProvider);

    return Scaffold(
      backgroundColor: HexColor.fromHex(cmsBody?.appBackGroundColor),
      appBar: CustomAppBar(
          title: SplashScreenNotifier.getLanguageLabel('Terms of Service')),
      // AppBar(
      //   title: Text(
      //     SplashScreenNotifier.getLanguageLabel('Terms of Service'),
      //     style: const TextStyle(
      //       color: CustomColors.customBlue,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.80,
              child: WebViewWidget(controller: webviewController),
            ),
            const SizedBox(height: 10.0),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
