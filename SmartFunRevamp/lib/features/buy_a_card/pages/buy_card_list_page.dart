import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/features/buy_a_card/provider/buy_card/buy_card_notifier.dart';
import 'package:semnox/features/buy_a_card/widgets/card_type.dart';
import 'package:semnox/features/buy_a_card/widgets/drawer_filter.dart';
import 'package:semnox/features/recharge_card/widgets/site_dropdown.dart';
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          SplashScreenNotifier.getLanguageLabel('Buy a Card'),
          style: const TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer(
              builder: (_, ref, __) {
                return SitesAppBarDropdown(
                  onChanged: (selectedSite) {
                    ref.read(buyCardNotifier.notifier).getCards(selectedSite!.siteId ?? -1);
                  },
                );
              },
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return ref.watch(buyCardNotifier).maybeWhen(
                        orElse: () => Container(),
                        inProgress: () => const Center(child: CircularProgressIndicator()),
                        success: (responseCards) {
                          List<CardProduct> cards = List.from(responseCards);
                          cards = cards..removeWhere((element) => (element.productType != "CARDSALE" && element.productType != "NEW"));
                          if (!filterStr.isNullOrEmpty()){
                            cards = cards.where((element) => (element.productName.toLowerCase().contains(filterStr.toString().toLowerCase()))).toList();
                          }
                          if (cards.isEmpty) {
                            return Center(
                              child: Text(SplashScreenNotifier.getLanguageLabel('No cards found')),
                            );
                          }
                          return ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            itemCount: cards.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                            itemBuilder: (context, index) {
                              return CardType(
                                card: cards[index],
                              );
                            },
                          );
                        },
                        error: (error) => Center(
                          child: MulishText(
                            text: error,
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
