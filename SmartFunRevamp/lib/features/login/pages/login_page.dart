import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/splash_screen/app_config_response.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_app_config_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_config_execution_context_use_case.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/login/widgets/login_container.dart';
import 'package:semnox/features/login/widgets/login_with_otp_container.dart';
import 'package:semnox/features/login/widgets/social_logins_container.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

final _executionContextProvider = FutureProvider<int>((ref) async {
  final getExecutionContext = Get.find<GetConfigExecutionContextUseCase>();
  final response = await getExecutionContext();
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});
final preConfigProvider = FutureProvider<AppConfigResponse>((ref) async {
  final getAppConfig = Get.find<GetAppConfigUseCase>();
  final siteId = ref.watch(_executionContextProvider).value;
  final response = await getAppConfig(siteId!);
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});
final loginTypeProvider = StateProvider<bool>((ref) {
  return true;
});
final isPasswordDisabledProvider = StateProvider<bool>((ref) {
  final parafaitDefault = ref.watch(parafaitDefaultsProvider).value;
  return parafaitDefault?.getDefault(ParafaitDefaultsResponse.passwordKey) == 'N';
});

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configExecutionContext = ref.watch(preConfigProvider);
    final isOTPLoginProvider = ref.watch(loginTypeProvider);
    final isPasswordDisabled = ref.watch(isPasswordDisabledProvider);
    ref.listen<LoginState>(loginProvider, (_, next) {
      next.maybeWhen(
        inProgress: () => context.loaderOverlay.show(),
        orElse: () => context.loaderOverlay.hide(),
        success: () {
          context.loaderOverlay.hide();
          Navigator.pushReplacementNamed(context, Routes.kHomePage);
        },
        selectLocationNeeded: () {
          context.loaderOverlay.hide();
          Navigator.pushReplacementNamed(context, Routes.kEnableLocation);
        },
        otpGenerated: () {
          context.loaderOverlay.hide();
          Navigator.pushNamed(context, Routes.kVerifyOTP);
        },
        error: (message) {
          context.loaderOverlay.hide();
          Dialogs.showErrorMessage(context, message);
        },
      );
    });
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              LoginContainer(
                isOTPLogin: isOTPLoginProvider && !isPasswordDisabled,
              ),
              const SizedBox(height: 20.0),
              if (!isPasswordDisabled)
                LoginWithOTPContainer(
                  isLoginWithOTP: isOTPLoginProvider,
                  onTap: () {
                    ref.read(loginTypeProvider.notifier).update((state) => !state);
                  },
                ),
              const SizedBox(height: 10.0),
              configExecutionContext.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) {
                  if (error is Failure) {
                    return const Icon(Icons.error, color: Colors.red);
                  }
                  return Container();
                },
                data: (config) {
                  if (config.socialLayout) {
                    return const SocialLoginsContainer();
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MulishText(
                    text: SplashScreenNotifier.getLanguageLabel('New to SmartFun?'),
                    fontColor: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, Routes.kSignUpPage),
                    child: MulishText(
                      text: SplashScreenNotifier.getLanguageLabel('SIGN UP'),
                      fontColor: CustomColors.hardOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
