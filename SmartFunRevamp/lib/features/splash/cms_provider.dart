import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';

final cmsProvider = FutureProvider<HomePageCMSResponse?>((ref) async {
  try {
    final String response = await rootBundle.loadString('assets/json/example_cms.json');
    final data = await json.decode(response) as Map<String, dynamic>;
    return HomePageCMSResponse.fromJson(data);
    // final getHomePageCms = Get.find<GetHomePageCMSUseCase>();
    // final apiResponse = await getHomePageCms();
    // return apiResponse.fold(
    //   (l) => throw l,
    //   (r) {
    //     return r;
    //   },
    // );
  } catch (e) {
    Logger().e(e);
    return null;
  }
  return null;
});
