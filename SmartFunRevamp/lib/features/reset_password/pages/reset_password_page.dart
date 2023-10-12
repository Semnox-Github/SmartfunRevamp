import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/image_handler.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/view/home_view.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePath = ref.watch(newHomePageCMSProvider)?.cmsImages.resetPasswordImagePath;
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Spacer(),
            CachedNetworkImage(
              imageUrl: imagePath ?? '',
              placeholder: (context, url) => ShimmerLoading(height: MediaQuery.of(context).size.height * 0.3),
              height: MediaQuery.of(context).size.height * 0.3,
              errorWidget: (context, url, error) {
                Logger().d(error);
                return ImageHandler(
                  height: MediaQuery.of(context).size.height * 0.3,
                  imageKey: "reset_password_success_image_path",
                );
              },
            ),
            const SizedBox(height: 20.0),
            MulishText(
              text: SplashScreenNotifier.getLanguageLabel('Reset Password link is sent to your registered email.'),
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            CustomButton(
              onTap: () => Navigator.pop(context),
              label: SplashScreenNotifier.getLanguageLabel('BACK TO LOGIN'),
            )
          ],
        ),
      ),
    );
  }
}
