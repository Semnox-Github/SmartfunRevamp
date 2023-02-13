import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/core/utils/extensions.dart';

class UserCards extends StatefulWidget {
  const UserCards({Key? key, required this.onCardSelected}) : super(key: key);
  final Function(String) onCardSelected;

  @override
  State<UserCards> createState() => _UserCardsState();
}

class _UserCardsState extends State<UserCards> {
  double cardToRecharge = 0;
  String selectedCardNumber = '';
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref.watch(HomeProviders.userCardsProvider).maybeWhen(
              orElse: () => Container(),
              loading: () => const CircularProgressIndicator(),
              data: (data) {
                if (selectedCardNumber.isEmpty) {
                  selectedCardNumber = data[0].accountNumber ?? '';
                  widget.onCardSelected(selectedCardNumber);
                }
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
                          widget.onCardSelected(data[index].accountNumber ?? '');
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
    );
  }
}
