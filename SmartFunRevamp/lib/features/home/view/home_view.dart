import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final user = Get.find<CustomerDTO>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade200,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const ImageAvatar(),
                    const SizedBox(width: 10.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.profileDto?.firstName} ${user.profileDto?.lastName}',
                          style: const TextStyle(
                            color: CustomColors.customBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: CustomColors.customBlue),
                            children: [
                              WidgetSpan(
                                child: Image.asset(
                                  'assets/home/gold_medal.png',
                                  height: 20.0,
                                ),
                              ),
                              const TextSpan(
                                text: 'Gold Member',
                                style: TextStyle(
                                  color: CustomColors.customLigthBlack,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    SvgPicture.asset('assets/home/search-normal.svg'),
                    const SizedBox(width: 10.0),
                    SvgPicture.asset('assets/home/notification.svg')
                  ],
                ),
                const SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade400,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                '8723 46 89 6768',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                '+Add Nickname',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/home/QR.png',
                            height: 42.0,
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(
                                width: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Get Balance',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        '01 Jan 2021 - 01 Jan 2023',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: CustomGradients.linearGradient,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            gradient: CustomGradients.linearGradient,
                          ),
                          margin: const EdgeInsets.all(3),
                          child: TextButton(
                            onPressed: () => Navigator.pushNamed(context, Routes.kBuyACard),
                            child: const Text(
                              'RECHARGE NOW',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: CustomGradients.linearGradient,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.all(3),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'CARD DETAILS',
                              style: TextStyle(
                                color: CustomColors.hardOrange,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Quick Links',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              QuickLinkItem(
                color: CustomColors.customYellow,
                image: 'recharge',
                text: 'Recharge',
                onTap: () => Navigator.pushNamed(context, Routes.kBuyACard),
              ),
              const QuickLinkItem(
                color: CustomColors.customPink,
                image: 'new_card',
                text: 'New Card',
              ),
              const QuickLinkItem(
                color: CustomColors.customLigthBlue,
                image: 'activities',
                text: 'Activities',
              ),
              const QuickLinkItem(
                color: CustomColors.customOrange,
                image: 'lost_card',
                text: 'Lost Card',
              ),
              const QuickLinkItem(
                color: CustomColors.customGreen,
                image: 'gameplays',
                text: 'Game Plays',
              ),
              const QuickLinkItem(
                color: CustomColors.customPurple,
                image: 'transfer_credit',
                text: 'Transfer Credit',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Today's Offers",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              gradient: CustomGradients.myFirstCircularGradient,
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
            child: CarouselSlider(
              options: CarouselOptions(height: 150.0),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset('assets/home/carousel_test.png');
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'More Actions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              QuickLinkItem(
                color: CustomColors.customYellow,
                image: 'tickets',
                text: 'Tickets',
              ),
              QuickLinkItem(
                color: CustomColors.customOrange,
                image: 'coupons',
                text: 'Coupons',
              ),
              QuickLinkItem(
                color: CustomColors.customGreen,
                image: 'events',
                text: 'Events',
              ),
            ],
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class QuickLinkItem extends StatelessWidget {
  const QuickLinkItem({
    Key? key,
    required this.color,
    required this.image,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final Color color;
  final String image;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: color,
            ),
            padding: const EdgeInsets.all(13.0),
            child: SvgPicture.asset('assets/home/$image.svg'),
          ),
          const SizedBox(height: 10.0),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.5),
      decoration: const BoxDecoration(
        gradient: CustomGradients.goldenGradient,
        shape: BoxShape.circle,
      ),
      child: const CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.white,
        foregroundImage: NetworkImage('https://kprofiles.com/wp-content/uploads/2016/05/TWICE-Perfect-World-Concept-Teasers-documents-10.jpeg'),
      ),
    );
  }
}
