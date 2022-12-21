import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/features/home/presentation/widgets/custom_bottom_navigation_bar_item.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    Key? key,
    required this.onTap,
    required this.currentPage,
  }) : super(key: key);
  final Function(int) onTap;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
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
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: currentPage,
              index: 0,
              icon: 'assets/home/home.svg',
              text: 'Home',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: currentPage,
              index: 1,
              icon: 'assets/home/play-circle.svg',
              text: 'Play',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: currentPage,
              index: 2,
              icon: 'assets/home/calendar.svg',
              text: 'Bookings',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: currentPage,
              index: 3,
              icon: 'assets/home/more.svg',
              text: 'More',
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
