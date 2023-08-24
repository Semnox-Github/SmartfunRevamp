
// final cmsProvider = FutureProvider<HomePageCMSResponse?>((ref) async {
//   try {
//     final getHomePageCms = Get.find<GetHomePageCMSUseCase>();
//     final apiResponse = await getHomePageCms();
//     return apiResponse.fold(
//       (l) => throw l,
//       (r) => r,
//     );
//   } catch (e) {
//     Logger().e(e);
//     return null;
//   }
// });
