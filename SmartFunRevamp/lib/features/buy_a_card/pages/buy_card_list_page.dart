import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/features/buy_a_card/provider/buy_card_notifier.dart';
import 'package:semnox/features/buy_a_card/widgets/card_type.dart';
import 'package:semnox/features/buy_a_card/widgets/drawer_filter.dart';

class BuyCardListPage extends StatelessWidget {
  const BuyCardListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const FilterDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Buy a Card',
          style: TextStyle(
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
            Container(
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
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return ref.watch(buyCardNotifier).maybeWhen(
                        orElse: () => Container(),
                        inProgress: () => const Center(child: CircularProgressIndicator()),
                        success: (cards) {
                          if (cards.isEmpty) {
                            return const Center(
                              child: Text('No cards found'),
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
                        error: (_) => Container(),
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
