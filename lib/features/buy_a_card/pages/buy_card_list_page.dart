import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/custom_checkbox.dart';
import 'package:semnox/features/buy_a_card/widgets/card_type.dart';

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

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 40.0),
        children: [
          SizedBox(
            height: 100.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: CustomColors.customLigthBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Filter',
                      style: GoogleFonts.mulish(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.cancel_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Membership',
              style: GoogleFonts.mulish(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: ['Silver', 'Gold', 'Platinum'].map((e) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CustomCheckBox(),
                title: Text(
                  e,
                ),
              );
            }).toList(),
          ),
          ListTile(
            title: Text(
              'Price Range',
              style: GoogleFonts.mulish(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: ['\$10 - \$50', '\$51 - \$100', '\$101 - \$200', '\$201 - \$300', '\$300+'].map((e) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CustomCheckBox(),
                title: Text(
                  e,
                ),
              );
            }).toList(),
          ),
          ListTile(
            title: Text(
              'Discount',
              style: GoogleFonts.mulish(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: ['0% - 20% Discount', '41% - 60% Discount', '61% - 80% Discount'].map((e) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CustomCheckBox(),
                title: Text(
                  e,
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomButton(
              onTap: () {},
              label: 'Apply Filters',
            ),
          ),
        ],
      ),
    );
  }
}
