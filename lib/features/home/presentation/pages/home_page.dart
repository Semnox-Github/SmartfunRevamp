import 'package:flutter/material.dart';
import 'package:semnox/features/home/presentation/view/bookings_view.dart';
import 'package:semnox/features/home/presentation/view/home_view.dart';
import 'package:semnox/features/home/presentation/view/more_view.dart';
import 'package:semnox/features/home/presentation/view/play_view.dart';
import 'package:semnox/features/home/presentation/widgets/custom_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      appBar: AppBar(),
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
          children: const [
            HomeView(),
            PlayView(),
            BookingsView(),
            MoreView(),
          ],
        ),
      ),
    );
  }
}
