import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/provider/buy_card/buy_card_notifier.dart';
import 'package:semnox/features/buy_a_card/widgets/card_type.dart';
import 'package:semnox/features/buy_a_card/widgets/drawer_filter.dart';
import 'package:semnox/features/recharge_card/providers/products_price_provider.dart';
import 'package:semnox/features/recharge_card/widgets/site_dropdown.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class BuyCardListPage extends StatelessWidget {
  const BuyCardListPage({
    Key? key,
    this.filterStr,
  }) : super(key: key);

  final String? filterStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const FilterDrawer(),
      appBar: filterStr == null
          ? AppBar(
              title: Text(
                SplashScreenNotifier.getLanguageLabel('Buy a Card'),
                style: const TextStyle(
                  color: CustomColors.customBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              shape: const RoundedRectangleBorder(),
              actions: [
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            Consumer(
              builder: (_, ref, __) {
                final defaults = ref.watch(parafaitDefaultsProvider);
                final isOnlineRechargeEnabled = defaults?.getDefault(
                        ParafaitDefaultsResponse.onlineRechargeEnabledKey) ==
                    'Y';
                final virtualStoreSiteId = defaults
                    ?.getDefault(ParafaitDefaultsResponse.virtualStoreSiteId);
                return SitesAppBarDropdown(
                  isEnabled:
                      isOnlineRechargeEnabled && (virtualStoreSiteId == null),
                  onChanged: (selectedSite) {
                    ref
                        .read(selectedSiteIdProvider.notifier)
                        .update((state) => selectedSite?.siteId ?? -1);
                    ref.read(filterProvider.notifier).update((state) => []);
                  },
                );
              },
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return ref.watch(buyCardProvider).maybeWhen(
                        orElse: () => Container(),
                        loading: () => const Center(
                            child: CircularProgressIndicator.adaptive()),
                        data: (responseCards) {
                          debugPrint("card product $responseCards");
                          List<CardProduct> cards = List.from(responseCards);
                          debugPrint("card product ${cards.toString()}");
                          cards = cards
                            ..removeWhere((element) =>
                                (element.productType != "CARDSALE" &&
                                    element.productType != "NEW"));
                          if (!filterStr.isNullOrEmpty()) {
                            cards = cards
                                .where((element) => (element.productName
                                    .toLowerCase()
                                    .contains(
                                        filterStr.toString().toLowerCase())))
                                .toList();
                          }
                          if (cards.isEmpty) {
                            return Center(
                              child: Text(SplashScreenNotifier.getLanguageLabel(
                                  'No cards found')),
                            );
                          }
                          cards.sort((a, b) {
                            final sortOrderA = a.sortOrder as double?;
                            final sortOrderB = b.sortOrder as double?;

                            if (sortOrderA == null && sortOrderB == null) {
                              return 0; // If both are null, leave them unchanged relative to each other
                            } else if (sortOrderA == null) {
                              return 1; // Null values go to the end
                            } else if (sortOrderB == null) {
                              return -1; // Null values go to the end
                            } else {
                              return sortOrderA.compareTo(sortOrderB);
                            }
                          });
                          // debugPrint("sort order $cards");
                          return ListView.separated(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            itemCount: cards.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10.0),
                            itemBuilder: (context, index) {
                              return CardType(
                                card: cards[index],
                              );
                            },
                          );
                        },
                        error: (error, _) => const Center(
                          child: MulishText(
                            text: 'No response',
                            fontColor: Colors.red,
                            fontSize: 20.0,
                          ),
                        ),
                      );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
