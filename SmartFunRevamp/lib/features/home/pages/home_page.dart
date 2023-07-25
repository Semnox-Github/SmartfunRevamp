import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/features/home/view/bookings_view.dart';
import 'package:semnox/features/home/view/home_view.dart';
import 'package:semnox/features/home/view/more_view.dart';
import 'package:semnox/features/home/view/play_view.dart';

import 'package:semnox/features/home/widgets/custom_bottom_bar.dart';
import 'package:semnox/features/splash/cms_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cms = ref.watch(cmsProvider).value;
    final items = cms?.getFooterMenuItems() ?? [];

    return Scaffold(
      backgroundColor: CustomColors.customLigthBlue,
      bottomNavigationBar: CustomBottomBar(
        onTap: (page) {
          setState(() {
            _currentPage = page;
          });
          _pageController.jumpToPage(page);
        },
        currentPage: _currentPage,
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: childrenPages(items),
        ),
      ),
    );
  }

  List<Widget> childrenPages(List<CMSMenuItem> items) {
    final List<Widget> pages = [];
    for (final item in items) {
      if (item.active) {
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
    }
    return pages;
  }
}
