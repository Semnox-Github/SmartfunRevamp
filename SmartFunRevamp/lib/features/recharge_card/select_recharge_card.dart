import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/recharge_card/providers/products_price_provider.dart';

class SelectCardRecharge extends StatefulWidget {
  const SelectCardRecharge({Key? key}) : super(key: key);

  @override
  State<SelectCardRecharge> createState() => _SelectCardRechargeState();
}

class _SelectCardRechargeState extends State<SelectCardRecharge> {
  double cardToRecharge = 0;
  String selectedCardNumber = '';
  CardProduct? offerSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Recharge a Card',
          style: TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomSheet: BottomSheetButton(
        label: 'RECHARGE NOW',
        onTap: () {
          if (offerSelected != null) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EstimatedTransactionPage(cardProduct: offerSelected!, cardNumber: selectedCardNumber),
              ),
            );
          }
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SitesAppBarDropdown(),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(HomeProviders.userCardsProvider).maybeWhen(
                      orElse: () => Container(),
                      loading: () => const CircularProgressIndicator(),
                      data: (data) {
                        selectedCardNumber = data[0].accountNumber ?? '';
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: InfiniteCarousel.builder(
                                itemCount: data.length,
                                itemExtent: MediaQuery.of(context).size.width,
                                center: true,
                                anchor: 0.5,
                                velocityFactor: 0.2,
                                onIndexChanged: (index) {
                                  selectedCardNumber = data[index].accountNumber ?? '';
                                  setState(() {
                                    cardToRecharge = index.toDouble();
                                  });
                                },
                                axisDirection: Axis.horizontal,
                                loop: false,
                                itemBuilder: (context, itemIndex, realIndex) {
                                  final card = data[itemIndex];
                                  final formatter = DateFormat('dd MMM yyyy');
                                  return Container(
                                    margin: const EdgeInsets.all(20.0),
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      gradient: CustomGradients.linearGradient,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MulishText(
                                                  text: card.accountNumber ?? '',
                                                  fontColor: Colors.white,
                                                ),
                                                !card.accountIdentifier.isNullOrEmpty()
                                                    ? MulishText(
                                                        text: card.accountIdentifier ?? '',
                                                        fontColor: Colors.white,
                                                      )
                                                    : const MulishText(
                                                        text: '+Add Nickname',
                                                        textDecoration: TextDecoration.underline,
                                                        fontColor: Colors.white,
                                                      ),
                                              ],
                                            ),
                                            Image.asset(
                                              'assets/home/QR.png',
                                              height: 42,
                                            )
                                          ],
                                        ),
                                        OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            side: const BorderSide(
                                              width: 1.5,
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: const MulishText(
                                            text: 'Get Balance',
                                            fontColor: Colors.white,
                                          ),
                                        ),
                                        MulishText(
                                          text: '${formatter.format(card.issueDate ?? DateTime.now())} -${formatter.format(card.expiryDate ?? DateTime.now())}',
                                          fontColor: Colors.white,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            DotsIndicator(
                              dotsCount: data.length,
                              position: cardToRecharge,
                              decorator: const DotsDecorator(
                                activeColor: CustomColors.hardOrange,
                              ),
                            ),
                          ],
                        );
                      },
                    );
              },
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 100.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(rechargeProductsProvider).maybeWhen(
                          orElse: () => Container(),
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (error, stackTrace) => const MulishText(text: 'Error'),
                          data: (offers) {
                            return RechargeCardOffers(
                              offers: offers,
                              onOfferSelected: (offer) {
                                offerSelected = offer;
                              },
                            );
                          },
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RechargeCardOffers extends StatefulWidget {
  const RechargeCardOffers({Key? key, required this.offers, required this.onOfferSelected}) : super(key: key);
  final List<CardProduct> offers;
  final Function(CardProduct) onOfferSelected;
  @override
  State<RechargeCardOffers> createState() => _RechargeCardOffersState();
}

class _RechargeCardOffersState extends State<RechargeCardOffers> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: widget.offers.length,
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: 10.0),
      itemBuilder: (context, index) {
        final offer = widget.offers[index];
        return RechargeCardOffer(
          offer: offer,
          isSelected: selectedIndex == index,
          onTap: () {
            widget.onOfferSelected(offer);
            setState(() {
              selectedIndex = index;
            });
          },
        );
      },
    );
  }
}

class RechargeCardOffer extends StatelessWidget {
  const RechargeCardOffer({
    Key? key,
    required this.offer,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final CardProduct offer;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.customLigthBlue,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            //RIGTH
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const MulishText(
                    text: 'PLAY CREDIT',
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/buy_card/coin.svg'),
                      const SizedBox(width: 5.0),
                      Text(
                        offer.credits.toString(),
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ), //LEFT
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  border: Border.all(
                    width: 2,
                    color: isSelected ? Colors.green : CustomColors.customLigthGray,
                  ),
                ),
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.all(1.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$${offer.basePrice}',
                              style: GoogleFonts.mulish(
                                color: CustomColors.discountColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '10% OFF',
                              style: GoogleFonts.mulish(
                                color: CustomColors.discountPercentColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$${offer.finalPrice}',
                          style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20.0,
      child: Container(
        padding: const EdgeInsets.all(25.0),
        child: Consumer(
          builder: (context, ref, child) {
            return CustomButton(
              onTap: onTap,
              label: label,
            );
          },
        ),
      ),
    );
  }
}

class SitesAppBarDropdown extends StatelessWidget {
  const SitesAppBarDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: const BoxDecoration(
        color: Color(0xFFCFF8FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on_outlined,
          ),
          DropdownButton<String>(
            value: 'One Mall',
            icon: const Icon(Icons.expand_more),
            underline: const SizedBox(),
            items: ['One Mall', 'Two Mall'].map((e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: GoogleFonts.mulish(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              );
            }).toList(),
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}
