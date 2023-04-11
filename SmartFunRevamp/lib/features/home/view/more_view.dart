import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/more_options.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/user_presentation_card.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class MoreView extends StatelessWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Get.find<CustomerDTO>();
    return SingleChildScrollView(
      child: Column(
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
          MoreOptions(
            desc: 'Since 23 Apr 2021',
            iconBgColor: CustomColors.customLigthYellow,
            iconPath: 'gold_medal',
            onTap: () => Navigator.pushNamed(context, Routes.kMembershipInfo),
            title: 'Gold Member',
          ),
          MoreOptions(
            desc: 'View the rewards you have earned',
            iconBgColor: CustomColors.customLigthGray,
            iconPath: 'membership',
            onTap: () {},
            title: 'Rewards',
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
                  onPressed: () => Navigator.popAndPushNamed(context, Routes.kLogInPage),
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
