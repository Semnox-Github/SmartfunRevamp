import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/custom_checkbox.dart';
import 'package:semnox/features/buy_a_card/provider/buy_card_notifier.dart';

class FilterDrawer extends ConsumerWidget {
  const FilterDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<List<int>> filters = [];
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
            children: [
              [10, 50],
              [51, 100],
              [101, 200],
              [201, 300],
              [300]
            ].map((e) {
              final text = e.length == 2 ? '\$${e[0]} - \$${e[1]}' : '\$${e[0]}+';
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CustomCheckBox(
                  onTap: (isChecked) {
                    if (isChecked) {
                      filters.add(e);
                    } else {
                      filters.remove(e);
                    }
                  },
                ),
                title: Text(
                  text,
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
            children: ['0% , 20% Discount', '41% , 60% Discount', '61% - 80% Discount'].map((e) {
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
              onTap: () => ref.read(buyCardNotifier.notifier).filter(filters),
              label: 'Apply Filters',
            ),
          ),
        ],
      ),
    );
  }
}
