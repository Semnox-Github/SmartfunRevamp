import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/authenticate_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_parafait_languages_use_case.dart';
import 'package:semnox/di/injection_container.dart';

import '../../../core/domain/entities/language/language_container_dto.dart';

part 'splash_screen_state.dart';
part 'splash_screen_notifier.freezed.dart';

final splashScreenProvider = StateNotifierProvider<SplashScreenNotifier, SplashScreenState>(
  (ref) {
    return SplashScreenNotifier(
      Get.find(),
      Get.find(),
    );
  },
);

class SplashScreenNotifier extends StateNotifier<SplashScreenState> {
  SplashScreenNotifier(this._getBaseURL, this._authenticateBaseURLUseCase) : super(const _Initial());

  final GetBaseURLUseCase _getBaseURL;
  final AuthenticateBaseURLUseCase _authenticateBaseURLUseCase;

  void getBaseUrl() async {
    final response = await _getBaseURL();
    response.fold(
      (l) => Logger().e(l.message),
      (r) async {
        Get.put<String>(r.gateWayURL, tag: 'baseURL');
        authenticateBaseURL(r.gateWayURL);
      },
    );
  }

  void authenticateBaseURL(String baseUrl) async {
    final response = await _authenticateBaseURLUseCase();
    response.fold(
      (l) => state = _Error(l.message),
      (r) {
        authenticateApi(r, baseUrl);
        state = const _Success();
      },
    );
  }

    static final parafaitLanguagesProvider = FutureProvider<LanguageContainerDTO>((ref) async{
    final GetParafaitLanguagesUseCase getParafaitLanguagesUseCase = Get.find<GetParafaitLanguagesUseCase>();
    final response = await getParafaitLanguagesUseCase(siteId: "1040");
    Logger().d(response);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });
}
