import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/features/home/widgets/home_view_widgets/notification_button.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

List<CMSMenuItem> _getMenuHeader(HomePageCMSResponse? data) {
  for (CMSModuleMenu moduleMenu in data?.cmsModuleMenu ?? []) {
    for (var element in moduleMenu.cmsMenus) {
      if (element.name == 'SMARTFUN_MENU_HEADER') {
        return element.cmsMenuItems;
      }
    }
  }
  return [];
}

class HomeTopBarIcons extends ConsumerWidget {
  const HomeTopBarIcons({
    super.key,
    required this.onSearchTap,
  });
  final Function() onSearchTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cms = ref.watch(newHomePageCMSProvider);
    final header = _getMenuHeader(cms);
    if (header.isEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            iconSize: 45,
            onPressed: onSearchTap,
            icon: const Icon(Icons.search),
          ),
          IconButton(
            iconSize: 45,
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      );
    }
    return Row(
      children: [
        InkWell(
          onTap: onSearchTap,
          child: CachedNetworkImage(
            height: 45,
            imageUrl: header.firstWhere((element) => element.displayName == 'Search').itemUrl,
            errorWidget: (context, url, error) => const Icon(Icons.search),
          ),
        ),
        const SizedBox(width: 10.0),
        NotificationsButton(
          notificationIcon: CachedNetworkImage(
            height: 45,
            imageUrl: header.firstWhere((element) => element.displayName == 'Notification').itemUrl,
            errorWidget: (context, url, error) => const Icon(Icons.notifications),
          ),
        ),
      ],
    );
  }
}
