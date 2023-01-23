import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/features/buy_a_card/widgets/card_type.dart';

class BuyCardListPage extends StatelessWidget {
  const BuyCardListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        title: const Text(
          'Buy a Card',
          style: TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
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
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemCount: 7,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const Text(
                      'Recommended For You',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  if (index == 4) {
                    return const Text(
                      'Exclusive Offers on Cards',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return const CardType();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
