import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/widgets/buy_new_card_button.dart';
import 'package:semnox/features/home/widgets/recharge_card_details_button.dart';
import 'package:semnox/features/login/widgets/profile_picture.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/home/widgets/link_a_card.dart';
import 'package:semnox/features/login/widgets/quick_link_item.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final user = Get.find<CustomerDTO>();
  CardDetails? cardDetails;
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
                    const ProfilePicture(),
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
                      return ref.watch(CardsProviders.userCardsProvider).maybeWhen(
                            orElse: () => Container(
                              height: 20.0,
                              width: 20.0,
                              color: Colors.red,
                            ),
                            loading: () => const CircularProgressIndicator(),
                            data: (data) {
                              return Column(
                                children: [
                                  data.isNotEmpty
                                      ? CarouselCards(
                                          cards: data,
                                          onCardChanged: (details) {
                                            Logger().d('Card Changed ${details.toJson()}');
                                            setState(() {
                                              cardDetails = details;
                                            });
                                          },
                                        )
                                      : const LinkACard(),
                                  const SizedBox(height: 10.0),
                                  if (data.isNotEmpty)
                                    RechargeCardDetailsButton(
                                      cardDetails: cardDetails ?? data.first,
                                    )
                                  else
                                    const BuyNewCardButton(),
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
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ref.watch(CardsProviders.userCardsProvider).maybeWhen(
                    orElse: () => Container(
                      height: 20.0,
                      width: 20.0,
                      color: Colors.red,
                    ),
                    loading: () => const CircularProgressIndicator(),
                    data: (data) {
                      bool hasCard = data.isNotEmpty ? true : false;
                      return GridView(
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
                            onTap: () => hasCard ? Navigator.pushNamed(context, Routes.kRechargePageCard) : () {},
                          ),
                          QuickLinkItem(
                            color: CustomColors.customPink,
                            image: 'new_card',
                            text: 'New Card',
                            onTap: () => Navigator.pushNamed(context, Routes.kBuyACard),
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
                      );
                    },
                  );
            },
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
