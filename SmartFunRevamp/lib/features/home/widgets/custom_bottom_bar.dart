import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/features/home/widgets/custom_bottom_navigation_bar_item.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox/features/splash/splashscreen.dart';

class CustomBottomBar extends ConsumerWidget {
  const CustomBottomBar({
    Key? key,
    required this.onTap,
    required this.currentPage,
  }) : super(key: key);
  final Function(int) onTap;
  final int currentPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cms = ref.watch(cmsProvider).value;
    final items = getFooterMenuItems(cms);
    inspect(cms);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      child: BottomNavigationBar(
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        backgroundColor: CustomColors.customBlack,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: (value) => onTap(value),
        items: [
          //   for (CMSMenuItem item in items)
          //     BottomNavigationBarItem(
          //       icon: CustomBottomNavigationBarItem(
          //         key: Key(item.displayName),
          //         currentIndex: currentPage,
          //         index: items.indexOf(item),
          //         icon: 'assets/home/play-circle.svg',
          //         text: SplashScreenNotifier.getLanguageLabel(item.displayName),
          //       ),
          //       label: '',
          //     ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: currentPage,
              index: 0,
              icon: 'assets/home/home.svg',
              text: SplashScreenNotifier.getLanguageLabel('Home'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: currentPage,
              index: 1,
              icon: 'assets/home/play-circle.svg',
              text: SplashScreenNotifier.getLanguageLabel('Play'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: currentPage,
              index: 2,
              icon: 'assets/home/calendar.svg',
              text: SplashScreenNotifier.getLanguageLabel('Bookings'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: currentPage,
              index: 3,
              icon: 'assets/home/more.svg',
              text: SplashScreenNotifier.getLanguageLabel('More'),
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  List<CMSMenuItem> getFooterMenuItems(HomePageCMSResponse? cms) {
    List<CMSMenuItem> cmsMenuItems = [];
    if (cms == null) {
      return cmsMenuItems;
    }
    for (CMSModuleMenu moduleMenu in cms.cmsModuleMenu) {
      for (CMSMenu menu in moduleMenu.cmsMenus) {
        if (menu.type == 'FOOTER') {
          return menu.cmsMenuItems;
        }
      }
    }
    return cmsMenuItems;
  }
}
