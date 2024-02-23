import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/use_cases/cards/get_card_activity_log_use_case.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/activity/card_activity_details_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/view/home_view.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

final _getActivityLog = FutureProvider.autoDispose
    .family<List<CardActivity>, String>((ref, cardId) async {
  final GetCardActivityLogUseCase getCardActivityLogUseCase =
      Get.find<GetCardActivityLogUseCase>();
  final response = await getCardActivityLogUseCase(cardId);
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});

class CardActivityLogPage extends ConsumerStatefulWidget {
  const CardActivityLogPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CardActivityLogPageState();
}

class _CardActivityLogPageState extends ConsumerState<CardActivityLogPage> {
  late CardDetails selectedCard;
  late List<CardDetails> cards;
  late CardDetails? cardDetails;
  late int _cardIndex;
  @override
  void initState() {
    super.initState();
    _cardIndex = 0;
    cards = List<CardDetails>.from(
        ref.read(CardsProviders.userCardsProvider).value ?? []);
    cardDetails = ref.read(currentCardProvider);
    // cards.removeWhere((element) => element.isBlocked() || element.isExpired());
    if (cardDetails != null) {
      cards.forEachIndexed((index, element) {
        if (element.accountNumber == cardDetails!.accountNumber) {
          _cardIndex = index;
        }
      });
    }
    selectedCard = cards[_cardIndex];
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final cmsBody = ref.watch(cmsBodyStyleProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: SplashScreenNotifier.getLanguageLabel('Activity'),
      ),
      backgroundColor: HexColor.fromHex(cmsBody?.appBackGroundColor),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselCards(
              initialPosition: _cardIndex,
              cards: cards,
              showLinkCard: false,
              onCardChanged: (index) {
                setState(() {
                  _cardIndex = index;
                  selectedCard = cards[index];
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MulishText(
                text: SplashScreenNotifier.getLanguageLabel('Card Activities'),
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Expanded(
              child: ref
                  .watch(_getActivityLog(selectedCard.accountId.toString()))
                  .maybeWhen(
                    orElse: () => Container(),
                    error: (error, stackTrace) {
                      return Center(
                        child: MulishText(
                          text: SplashScreenNotifier.getLanguageLabel(
                              'No activities on this Card'),
                          fontSize: 20.0,
                        ),
                      );
                    },
                    loading: () => const Center(
                        child: CircularProgressIndicator.adaptive()),
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final activity = data[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: CustomColors.customLigthBlue),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CardActivityDetailPage(
                                            transactionId:
                                                activity.refId.toString()),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MulishText(
                                        text: '${activity.activityType}',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      MulishText(text: '${activity.site}'),
                                      MulishText(
                                          text: 'Ref: ${activity.refId}'),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      MulishText(
                                        text:
                                            '${activity.date?.formatDate(DateFormat.YEAR_ABBR_MONTH_DAY)}, ${activity.date?.formatDate(DateFormat.HOUR_MINUTE)}',
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
