import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/more_options.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/user_presentation_card.dart';
import 'package:semnox/features/membership_info/provider/membership_info_provider.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class MoreView extends ConsumerWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = Get.find<CustomerDTO>();
    final localDatasource = Get.find<LocalDataSource>();
    final InAppReview inAppReview = InAppReview.instance;

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
                  children: const [
                    MulishText(
                      text: 'More',
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
          Consumer(
            builder: (context, ref, child) {
              return ref.watch(membershipInfoProvider).when(
                    data: (data) {
                      if (data.membershipId == -1) {
                        return Container();
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MoreOptions(
                            desc: 'Since ${data.membershipValidity.formatDate('dd MMM yyyy')}',
                            iconBgColor: CustomColors.customLigthYellow,
                            iconPath: 'gold_medal',
                            onTap: () => Navigator.pushNamed(context, Routes.kMembershipInfo),
                            title: '${data.memberShipName}',
                          ),
                          MoreOptions(
                            desc: 'View the rewards you have earned',
                            iconBgColor: CustomColors.customLigthGray,
                            iconPath: 'membership',

                            // onTap: () async {
                            //   Logger().d(await inAppReview.isAvailable());
                            //   if (await inAppReview.isAvailable()) {
                            //     inAppReview.requestReview();
                            //   }
                            // },
                            onTap: () => Dialogs.showTransactionFeedbackDialog(context, () {}),
                            title: 'Rewards',
                          ),
                        ],
                      );
                    },
                    error: (_, __) => Container(),
                    loading: () => const CircularProgressIndicator(),
                  );
            },
          ),
          MoreOptions(
            desc: 'Manage your notifications settings',
            iconBgColor: CustomColors.customLigthGreen,
            iconPath: 'notification',
            onTap: () => Navigator.pushNamed(context, Routes.kNotificationsSettings),
            title: 'Notifications',
          ),
          MoreOptions(
            desc: 'Read FAQs or Get in touch',
            iconBgColor: const Color(0xFFE0F0D3),
            iconPath: 'help',
            onTap: () {},
            title: 'Help',
          ),
          MoreOptions(
            desc: 'Term of use and Privacy Policy',
            iconBgColor: CustomColors.customOrange,
            iconPath: 'note',
            onTap: () {},
            title: 'Legal',
          ),
          MoreOptions(
            desc: 'Rate us in the App Store',
            iconBgColor: const Color(0xFFFCD3DF),
            iconPath: 'like',
            onTap: () {},
            title: 'Like the App?',
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    localDatasource.deleteValue(LocalDataSource.kUserId).then(
                          (value) => Navigator.popAndPushNamed(context, Routes.kLogInPage),
                        );
                  },
                  child: const MulishText(
                    text: 'Logout',
                    fontColor: CustomColors.hardOrange,
                    fontWeight: FontWeight.bold,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    final info = snapshot.data;
                    return MulishText(
                      text: 'Build Version ${info?.version ?? ''}',
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
