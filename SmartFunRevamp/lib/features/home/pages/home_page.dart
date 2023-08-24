import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/features/home/view/bookings_view.dart';
import 'package:semnox/features/home/view/home_view.dart';
import 'package:semnox/features/home/view/more_view.dart';
import 'package:semnox/features/home/view/play_view.dart';

import 'package:semnox/features/home/widgets/custom_bottom_bar.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentPage = 0;
  late PageController _pageController;
  late List<CMSMenuItem> items;
  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final cms = ref.watch(newHomePageCMSProvider);
    items = cms?.getFooterMenuItems() ?? [];
    items.removeWhere((element) => !element.active);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customLigthBlue,
      bottomNavigationBar: CustomBottomBar(
        onTap: (page) {
          if (items[page].itemName == 'PLAY') {
            Navigator.pushNamed(context, Routes.kPlayPage);
          } else {
            setState(() {
              _currentPage = page;
            });
            _pageController.jumpToPage(page);
          }
        },
        currentPage: _currentPage,
      ),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            if (items[index].itemName == 'PLAY') {
              Navigator.pushNamed(context, Routes.kPlayPage);
            } else {
              setState(() {
                _currentPage = index;
              });
            }
          },
          children: childrenPages(items),
        ),
      ),
    );
  }

  List<Widget> childrenPages(List<CMSMenuItem> items) {
    final List<Widget> pages = [];
    for (final item in items) {
      switch (item.itemName) {
        case "HOME":
          pages.add(const HomeView());
          break;
        case "PLAY":
          pages.add(const PlayView());
          break;
        case "BOOKINGS":
          pages.add(const BookingsView());
          break;
        case "MORE":
          pages.add(const MoreView());
          break;
        default:
          pages.add(const HomeView());
          break;
      }
    }
    return pages;
  }
}
