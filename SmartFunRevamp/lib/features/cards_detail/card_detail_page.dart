import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/cards_detail/bonus_summary_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/view/home_view.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class CardDetailPage extends ConsumerStatefulWidget {
  const CardDetailPage({Key? key, required this.cardDetails, this.cardIndex})
      : super(key: key);
  final CardDetails cardDetails;
  final int? cardIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardDetailPage();
}

class _CardDetailPage extends ConsumerState<CardDetailPage> {
  late CardDetails cardDetails = widget.cardDetails;
  late int _cardIndex = widget.cardIndex ?? 0;
  @override
  Widget build(BuildContext context) {
    final cms = ref.watch(newHomePageCMSProvider);
    final items = cms?.getCardDetailMenuItems() ?? [];
    final links = cms?.getCardDetailsLinks() ?? [];
    final cardsWatch = ref.watch(CardsProviders.userCardsProvider);
    return Scaffold(
      appBar: AppBar(
        title: MulishText(
          text: SplashScreenNotifier.getLanguageLabel('Card Details'),
          fontColor: CustomColors.customBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.34,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                margin: const EdgeInsets.only(bottom: 10.0),
                decoration: const BoxDecoration(
                  color: CustomColors.customLigthBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Container(
                  child: cardsWatch.when(
                    skipLoadingOnRefresh: false,
                    loading: () => const ShimmerLoading(height: 200),
                    error: (_, __) => Center(
                      child: MulishText(
                          text: SplashScreenNotifier.getLanguageLabel(
                              'No Cards found')),
                    ),
                    data: (data) {
                      return Column(
                        children: [
                          CarouselCards(
                            cards: data,
                            initialPosition: _cardIndex,
                            onCardChanged: (cardIndex) {
                              if (cardIndex != data.length) {
                                ref
                                    .read(currentCardProvider.notifier)
                                    .update((state) => data[cardIndex]);
                                setState(() {
                                  cardDetails = data[cardIndex];
                                });
                              } else {
                                ref
                                    .read(currentCardProvider.notifier)
                                    .update((state) => null);
                              }
                              _cardIndex = cardIndex;
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final cardDetailItem = items[index];
                  return CardDetailItemFromCMS(
                    cardDetails: cardDetails,
                    item: cardDetailItem,
                  );
                },
              ),
              if (!(cardDetails.isBlocked() || cardDetails.isExpired()))
                CustomButton(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.kRechargePageCard),
                  label: SplashScreenNotifier.getLanguageLabel('RECHARGE NOW'),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MulishText(
                      text:
                          SplashScreenNotifier.getLanguageLabel('More Actions'),
                      fontWeight: FontWeight.bold,
                    ),
                    ...links.map((e) {
                      return MoreActionListTile(
                        title: e.displayName,
                        subTitle: e.description ?? '',
                        svgImage: e.itemUrl,
                        color: Colors.white, //CustomColors.customOrange,
                        onPressed: () {
                          if ((cardDetails.isBlocked() ||
                                  cardDetails.isExpired()) &&
                              e.itemName == 'LOST_CARD') {
                            return;
                          }
                          e.goToTarget(context);
                        },
                      );
                    }).toList()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MoreActionListTile extends StatelessWidget {
  const MoreActionListTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.svgImage,
    required this.color,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String svgImage;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50.0,
                width: 50.0,
                margin: const EdgeInsets.only(right: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: color,
                ),
                padding: const EdgeInsets.all(13.0),
                child: CachedNetworkImage(imageUrl: svgImage),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MulishText(
                      text: title,
                      fontWeight: FontWeight.bold,
                    ),
                    MulishText(
                      text: subTitle,
                      fontSize: 10.0,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF292D32),
              ),
            ],
          ),
          const Divider(
            color: CustomColors.customLigthGray,
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}

class CardDetailItemFromCMS extends StatelessWidget {
  const CardDetailItemFromCMS({
    Key? key,
    required this.item,
    required this.cardDetails,
  }) : super(key: key);
  final CMSMenuItem item;
  final CardDetails cardDetails;

  @override
  Widget build(BuildContext context) {
    return CardDetailItem(
      item: item,
      color: Colors.white, //CustomColors.customOrange,
      image: 'bonus_points',
      amount: item.itemName == "COURTESY"
          ? cardDetails.totalCourtesyBalance?.toStringAsFixed(0) ?? ''
          : cardDetails.pointsBasedOnCreditType(item.creditType ?? 0),
      onTap: item.creditType == null
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BonusSummaryPage(
                    cardNumber: cardDetails.accountNumber ?? '',
                    creditPlusType: item.creditType,
                    pageTitle:
                        SplashScreenNotifier.getLanguageLabel(item.displayName),
                  ),
                ),
              );
            },
    );
  }
}

class CardDetailItem extends StatelessWidget {
  const CardDetailItem({
    Key? key,
    required this.color,
    required this.image,
    required this.amount,
    required this.item,
    this.onTap,
  }) : super(key: key);
  final Color color;
  final String image;
  final String amount;
  final Function()? onTap;
  final CMSMenuItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: LayoutBuilder(builder: (context, constrains) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: color,
              ),
              padding: const EdgeInsets.all(13.0),
              child: CachedNetworkImage(
                imageUrl: item.itemUrl,
                height: constrains.maxHeight * 0.3,
                width: constrains.maxHeight * 0.3,
                placeholder: (context, url) =>
                    const CircularProgressIndicator.adaptive(),
                errorWidget: (context, url, error) =>
                    SvgPicture.asset('assets/card_details/$image.svg'),
              ),
            ),
            const SizedBox(height: 10.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MulishText(
                  text: amount,
                  fontWeight: FontWeight.bold,
                ),
                MulishText(
                  text: SplashScreenNotifier.getLanguageLabel(item.displayName),
                  fontColor: CustomColors.customBlack,
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
