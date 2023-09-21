import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/membership/membership_info.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/more_options.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/user_presentation_card.dart';
import 'package:semnox/features/membership_info/provider/membership_info_provider.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class MoreView extends ConsumerWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = Get.find<CustomerDTO>();
    final localDatasource = Get.find<LocalDataSource>();
    final cms = ref.watch(newHomePageCMSProvider);
    final items = cms?.getMoreMenuItems() ?? [];
    final membershipInfo = ref.watch(membershipInfoProvider).valueOrNull;
    return Container(
      color: Colors.white,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: CustomColors.customLigthBlue,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    MulishText(
                      text: SplashScreenNotifier.getLanguageLabel('More'),
                      fontWeight: FontWeight.bold,
                      fontColor: CustomColors.customBlue,
                      fontSize: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                UserPresentationCard(user: user),
              ],
            ),
          ),
          ...items.map(
            (e) => MoreOptionItemFromCMS(
              item: e,
              membershipInfo: membershipInfo,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    localDatasource.logoutUser().then(
                          (value) => Navigator.popAndPushNamed(
                              context, Routes.kLogInPage),
                        );
                    ref.invalidate(CardsProviders.userCardsProvider);
                  },
                  child: MulishText(
                    text: SplashScreenNotifier.getLanguageLabel('Logout'),
                    fontColor: CustomColors.hardOrange,
                    fontWeight: FontWeight.bold,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    final info = snapshot.data;
                    return MulishText(
                      text: SplashScreenNotifier.getLanguageLabel(
                              'Build Version &1')
                          .replaceAll(
                        '&1',
                        info?.version ?? '',
                      ),
                      fontColor: CustomColors.couponTextColor,
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MoreOptionItemFromCMS extends StatelessWidget {
  const MoreOptionItemFromCMS(
      {Key? key, required this.item, required this.membershipInfo})
      : super(key: key);
  final CMSMenuItem item;
  final MembershipInfo? membershipInfo;

  @override
  Widget build(BuildContext context) {
    final description = item.itemName == 'BASE_MEMBERSHIP'
        ? SplashScreenNotifier.getLanguageLabel('Since &1').replaceAll(
            '&1',
            membershipInfo?.membershipValidity.formatDate('dd MMM yyyy') ?? '',
          )
        : item.description ?? 'Please add a description to the CMS';

    return MoreOptions(
      item: item,
      desc: description,
      iconBgColor: Colors.white,
      iconPath: 'gold_medal',
      onTap: () {
        if (Routes.routesMap.containsKey(item.target)) {
          Navigator.pushNamed(context, item.target ?? "");
        } else {
          Fluttertoast.showToast(msg: "URL is not configured");
        }
      },
      title: item.displayName,
    );
  }
}
