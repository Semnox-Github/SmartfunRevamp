import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/routes.dart';

import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    ref.read(splashScreenProvider.notifier).getBaseUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void nextPage() => Navigator.pushNamed(context, Routes.kAfterSplashScreenPage);
    ref.listen<SplashScreenState>(
      splashScreenProvider,
      (_, next) {
        next.maybeWhen(
          orElse: () {},
          success: () async {
            await Future.delayed(const Duration(seconds: 3));
            nextPage();
          },
        );
      },
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash_screen/splash_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    // return Scaffold(
    //   body: ref.watch(cmsProvider).when(
    //         error: (_, __) => const Center(
    //           child: Icon(
    //             Icons.error,
    //             color: Colors.red,
    //             size: 50.0,
    //           ),
    //         ),
    //         loading: () => const Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //         data: (data) {
    //           return CachedNetworkImage(
    //             imageUrl: data?.cmsImages.splashScreenPath ?? "",
    //             height: double.infinity,
    //             width: double.infinity,
    //             fit: BoxFit.fill,
    //             placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
    //             errorWidget: (context, url, error) {
    //               return const Center(
    //                 child: Icon(
    //                   Icons.error,
    //                   color: Colors.red,
    //                   size: 50.0,
    //                 ),
    //               );
    //             },
    //           );
    //         },
    //       ),
    // );
  }
}
