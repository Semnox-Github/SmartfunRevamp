import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_home_page_cms_use_case.dart';

final cmsProvider = FutureProvider<HomePageCMSResponse?>((ref) async {
  try {
    final getHomePageCms = Get.find<GetHomePageCMSUseCase>();
    final apiResponse = await getHomePageCms();
    return apiResponse.fold(
      (l) => throw l,
      (r) => r,
    );
  } catch (e) {
    Logger().e(e);
    return null;
  }
});
