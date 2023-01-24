import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/app_information/provider/app_Information_provider.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/semnox_core.dart';

class AppVersionTag extends ConsumerWidget {
  const AppVersionTag({
    Key? key,
    this.color,
  }) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ref.watch(appVersionProvider).when(
        data: (data) {
          return SemnoxText.button(
              text: "${data.version}+${data.buildNumber} ");
        },
        loading: () => Container(),
        error: (a, b) => Container());
  }
}

final appVersionProvider = FutureProvider<AppVersion>((ref) async {
  AppInformationDTO? packageInfo =
      await AppInformationProvider().getAppInformation();
  String? appName = packageInfo?.appName;
  String? packageName = packageInfo?.packageName;
  String? version = packageInfo?.version;
  String? buildNumber = packageInfo?.buildNumber;
  return AppVersion(
    appName: appName,
    packageName: packageName,
    version: version,
    buildNumber: buildNumber,
  );
});

class AppVersion {
  final String? appName;
  final String? packageName;
  final String? version;
  final String? buildNumber;

  AppVersion(
      {required this.appName,
      required this.packageName,
      required this.version,
      required this.buildNumber});
}
