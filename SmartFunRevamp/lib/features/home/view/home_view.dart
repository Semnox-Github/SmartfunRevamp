import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/home/card_details.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/widgets/background_card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/home/widgets/link_a_card.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:intl/intl.dart';

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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(HomeProviders.userCardsProvider).maybeWhen(
                            orElse: () => Container(
                              height: 20.0,
                              width: 20.0,
                              color: Colors.red,
                            ),
                            loading: () => const CircularProgressIndicator(),
                            data: (data) {
                              return Column(
                                children: [
                                  data.isNotEmpty ? CarouselCards(cards: data) : const LinkACard(),
                                  const SizedBox(height: 10.0),
                                  if (data.isNotEmpty) const RechargeCardDetailsButton() else const BuyNewCardButton(),
                                ],
                              );
                            },
                          );
                    },
                  ),
                ),
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

class BuyNewCardButton extends StatelessWidget {
  const BuyNewCardButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: CustomGradients.linearGradient,
      ),
      margin: const EdgeInsets.all(3),
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/home/card_add.svg'),
            const SizedBox(width: 5.0),
            const MulishText(
              text: 'BUY A NEW CARD',
              fontColor: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

class RechargeCardDetailsButton extends StatelessWidget {
  const RechargeCardDetailsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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

class ListOfCard extends StatelessWidget {
  const ListOfCard({Key? key, required this.data}) : super(key: key);

  final List<CardDetails> data;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 200.0),
      items: data.map((i) {
        return Builder(
          builder: (BuildContext context) {
            // return Image.asset('assets/home/carousel_test.png');
            return BackgroundCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${i.accountNumber}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 7.0),
                          Text(
                            '${i.accountIdentifier == '' ? '+ Add nickname' : i.accountIdentifier?.substring(0, 15)}',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontSize: 18,
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
                  Text(
                    '${i.issueDate != null ? DateFormat('dd  MMM yyyy').format(i.issueDate as DateTime) : ''} ${i.expiryDate != null ? DateFormat('- dd  MMM yyyy').format(i.expiryDate as DateTime) : ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
