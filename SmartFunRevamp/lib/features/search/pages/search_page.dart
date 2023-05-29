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
    selectedCardNumber = cards.first;
    userSite = ref.read(loginProvider.notifier).selectedSite?.siteId ?? 1010;
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFCFF8FF),
          elevation: 0.0,
          centerTitle: false,
          iconTheme: const IconThemeData(color: Colors.black),
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
        const TabBar(tabs: [
          MulishText(
            text: "Recharge",
            fontSize: 14,
          ),
          MulishText(text: "New Card", fontSize: 14),
        ]),
        SizedBox(
          //Add this to give height
          height: MediaQuery.of(context).size.height,
          child: TabBarView(children: [SelectCardRechargePage(filterStr: filterStr), BuyCardListPage(filterStr: filterStr)]),
        ),
      ],
    ),
  );
}
