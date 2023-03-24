import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity.dart';
import 'package:semnox/core/domain/use_cases/cards/get_card_activity_log_use_case.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/activity/card_activity_details_page.dart';
import 'package:semnox/features/cards_detail/bonus_summary_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';

final _getActivityLog = FutureProvider.autoDispose.family<List<CardActivity>, String>((ref, cardId) async {
  final GetCardActivityLogUseCase getCardActivityLogUseCase = Get.find<GetCardActivityLogUseCase>();
  final response = await getCardActivityLogUseCase(cardId);
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});

class CardActivityLogPage extends StatefulWidget {
  const CardActivityLogPage({super.key});

  @override
  State<CardActivityLogPage> createState() => _CardActivityLogPageState();
}

class _CardActivityLogPageState extends State<CardActivityLogPage> {
  String? _cardId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: MulishText(
          text: 'Activity',
          fontColor: CustomColors.customBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            return Container(
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
                              CarouselCards(
                                cards: data,
                                showLinkCard: false,
                                onCardChanged: (cardIndex) {
                                  setState(() {
                                    _cardId = data[cardIndex].accountId.toString();
                                  });
                                },
                              ),
                              Expanded(
                                child: ref.watch(_getActivityLog(_cardId ?? data.first.accountId.toString())).maybeWhen(
                                      orElse: () => Container(),
                                      error: (error, stackTrace) {
                                        return const Center(
                                          child: MulishText(
                                            text: 'No activities on this Card',
                                            fontSize: 20.0,
                                          ),
                                        );
                                      },
                                      loading: () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      data: (data) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const MulishText(
                                                    text: 'Card Activities',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                  ),
                                                  ListView.builder(
                                                    itemCount: data.length,
                                                    shrinkWrap: true,
                                                    physics: const ClampingScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      final activity = data[index];
                                                      return Container(
                                                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                                                        decoration: BoxDecoration(border: Border.all(color: CustomColors.customLigthBlue), borderRadius: BorderRadius.circular(20.0)),
                                                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                MulishText(
                                                                  text: '${activity.activityType}',
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                                MulishText(text: '${activity.site}'),
                                                                MulishText(text: 'Ref: ${activity.refId}'),
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                MulishText(
                                                                  text: '${activity.date?.formatDate(DateFormat.YEAR_ABBR_MONTH_DAY)}, ${activity.date?.formatDate(DateFormat.HOUR_MINUTE)}',
                                                                ),
                                                                IconButton(
                                                                  onPressed: () {
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => CardActivityDetailPage(transactionId: activity.refId.toString()),
                                                                      ),
                                                                    );
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons.arrow_forward_ios_outlined,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                              ),
                            ],
                          );
                        },
                      );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
