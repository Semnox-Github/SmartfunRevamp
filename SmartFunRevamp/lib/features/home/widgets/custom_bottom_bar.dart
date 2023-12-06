import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/home/widgets/custom_bottom_navigation_bar_item.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class CustomBottomBar extends ConsumerWidget {
  final bool? handleRoute;
  const CustomBottomBar({
    this.handleRoute,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cms = ref.watch(newHomePageCMSProvider);
    final items = cms?.getFooterMenuItems() ?? [];
    final barColor = cms?.cmsModuleColorsHome?.bottomHalf;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: HexColor.fromHex(barColor),
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: (index) {
          final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
          final itemRoute = items[index].target?.replaceAll('sf:/', '') ?? '';
          if (currentRoute == itemRoute && !handleRoute!) {
            return;
          }
          items[index].goToTarget(context);
        },
        items: [
          for (CMSMenuItem item in items)
            if (item.active)
              BottomNavigationBarItem(
                icon: CustomBottomNavigationBarItem(
                  key: Key(item.displayName),
                  currentIndex: 0,
                  index: items.indexOf(item),
                  icon: Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: 45,
                    width: 45,
                    child: CachedNetworkImage(
                      imageUrl: item.itemUrl,
                      placeholder: (context, url) => const SizedBox.shrink(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  text: SplashScreenNotifier.getLanguageLabel(item.displayName),
                ),
                label: '',
              ),
        ],
      ),
    );
  }
}
