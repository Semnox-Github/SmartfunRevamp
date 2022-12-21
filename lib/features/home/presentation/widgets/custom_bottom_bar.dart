import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/features/home/presentation/widgets/custom_bottom_navigation_bar_item.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: CustomColors.customBlack,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: _currentIndex,
              index: 0,
              icon: 'assets/home/home.svg',
              text: 'Home',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: _currentIndex,
              index: 1,
              icon: 'assets/home/play-circle.svg',
              text: 'Play',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: _currentIndex,
              index: 2,
              icon: 'assets/home/calendar.svg',
              text: 'Bookings',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavigationBarItem(
              currentIndex: _currentIndex,
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
