import 'package:cached_network_image/cached_network_image.dart';
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
    final items = cms?.getFooterMenuItems() ?? [];
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
          for (CMSMenuItem item in items)
            if (item.active)
              BottomNavigationBarItem(
                icon: CustomBottomNavigationBarItem(
                  key: Key(item.displayName),
                  currentIndex: currentPage,
                  index: items.indexOf(item),
                  icon: CachedNetworkImage(
                    imageUrl: item.itemUrl,
                    placeholder: (context, url) => const SizedBox.shrink(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
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
