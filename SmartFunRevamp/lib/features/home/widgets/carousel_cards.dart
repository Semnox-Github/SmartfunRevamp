import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';

import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/background_card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/widgets/link_a_card.dart';
import 'package:semnox/features/home/widgets/update_nickname_card.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselCards extends StatefulWidget {
  const CarouselCards({
    Key? key,
    required this.cards,
    required this.onCardChanged,
    this.showLinkCard = true,
  }) : super(key: key);
  final Function(int) onCardChanged;
  final List<CardDetails> cards;
  final bool showLinkCard;

  @override
  State<CarouselCards> createState() => _CarouselCardsState();
}

class _CarouselCardsState extends State<CarouselCards> {
  int currentPosition = 0;
  late List<CardDetails> _cards;

  @override
  void initState() {
    _cards = List<CardDetails>.from(widget.cards);
    Logger().d(_cards.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_cards.isEmpty) {
      return const Center(
        child: MulishText(
          text: "You don't have any card",
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            enableInfiniteScroll: false,
            height: MediaQuery.of(context).size.height * 0.25,
            viewportFraction: 1,
            onPageChanged: (index, _) {
              widget.onCardChanged(index);
              if (index < _cards.length) {
                setState(() {
                  currentPosition = index;
                });
              }
            },
          ),
          itemCount: _cards.length + (widget.showLinkCard ? 1 : 0),
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            if (itemIndex == _cards.length && widget.showLinkCard) {
              return LinkACard();
            }
            final card = _cards[itemIndex];
            return CarouselCardItem(
              card: card,
            );
          },
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: AnimatedSmoothIndicator(
            activeIndex: currentPosition,
            count: _cards.length,
            effect: const ScrollingDotsEffect(
              activeDotColor: CustomColors.hardOrange,
            ),
          ),
        )
      ],
    );
  }
}

class CarouselCardItem extends StatefulWidget {
  const CarouselCardItem({super.key, required this.card});
  final CardDetails card;

  @override
  State<CarouselCardItem> createState() => CarouselCardItemState();
}

class CarouselCardItemState extends State<CarouselCardItem> {
  late CardDetails card;
  late String cardNickname;
  final int userId = Get.find<CustomerDTO>().id ?? 0;
  @override
  void initState() {
    super.initState();
    card = widget.card;
    cardNickname = widget.card.accountIdentifier.isNullOrEmpty() ? widget.card.customerName! : widget.card.accountIdentifier!.characters.take(15).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BackgroundCard(
          isVirtual: card.isBlocked(),
          isExpired: card.isExpired(),
          cardNumber: card.accountNumber!,
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
                        '${card.accountNumber}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: UpdateNicknameCard(
                                  cardDetails: card,
                                  onUpdate: (newNickname) {
                                    setState(() {
                                      cardNickname = newNickname;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              cardNickname,
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            const Icon(Icons.edit, color: Colors.white, size: 15.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Dialogs.showBarcodeTempCard(context, card.accountNumber!),
                    child: Image.asset(
                      'assets/home/QR.png',
                      height: 42.0,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              // OutlinedButton(
              //   onPressed: () {},
              //   style: OutlinedButton.styleFrom(
              //     side: const BorderSide(width: 1.0, color: Colors.white),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12.0),
              //     ),
              //   ),
              //   child: Text(
              //     SplashScreenNotifier.getLanguageLabel('Get Balance'),
              //     style: const TextStyle(
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 10.0),
              Text(
                '${card.issueDate != null ? DateFormat('dd  MMM yyyy').format(card.issueDate as DateTime) : ''} ${card.expiryDate != null ? DateFormat('- dd  MMM yyyy').format(DateTime.parse(card.expiryDate.toString())) : ''}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (card.customerId != userId && card.customerId != -1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.link,
                      color: Colors.white,
                      size: 30.0,
                    )
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }
}
