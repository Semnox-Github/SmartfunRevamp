import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/pages/buy_card_list_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/recharge_card/pages/select_recharge_card_page.dart';
import 'package:semnox/features/select_location/pages/select_location_manually_page.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> with TickerProviderStateMixin {
  CardProduct? offerSelected;
  late CardDetails selectedCardNumber;
  late List<CardDetails> cards;
  late int userSite;
  late List<CardProduct> newCards = [];
  late List<CardProduct> recharges = [];
  late List<CardProduct> newCardsFiltered = [];
  late List<CardProduct> rechargesFiltered = [];
  late TabController tabController;
  late String filterStr = "";
  @override
  void initState() {
    super.initState();
    cards = List<CardDetails>.from(ref.read(CardsProviders.userCardsProvider).value ?? []);
    cards.removeWhere((element) => element.isBlocked() || element.isExpired());
    if (cards.isNotEmpty) {
      selectedCardNumber = cards.first;
    }
    final int masterSiteId = ref.read(masterSiteProvider)?.siteId ?? 1010;
    userSite = ref.read(loginProvider.notifier).selectedSite?.siteId ?? masterSiteId;
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                SplashScreenNotifier.getLanguageLabel('Search'),
                style: const TextStyle(
                  color: CustomColors.customBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              SearchTextField(
                onChanged: (filter) => {
                  setState(() {
                    filterStr = filter;
                  })
                },
              ),
              _tabSection(context, filterStr),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

Widget _tabSection(BuildContext context, String? filterStr) {
  return DefaultTabController(
    length: 3,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TabBar(tabs: [
          MulishText(
            text: SplashScreenNotifier.getLanguageLabel("Recharge"),
            fontSize: 14,
          ),
          MulishText(
            text: SplashScreenNotifier.getLanguageLabel("New Card"),
            fontSize: 14,
          ),
        ]),
        SizedBox(
          //Add this to give height
          height: MediaQuery.of(context).size.height * 0.8,
          child: TabBarView(children: [SelectCardRechargePage(filterStr: filterStr), BuyCardListPage(filterStr: filterStr)]),
        ),
      ],
    ),
  );
}
