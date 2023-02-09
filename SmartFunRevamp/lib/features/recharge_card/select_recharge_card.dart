import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';

class SelectCardRecharge extends StatelessWidget {
  const SelectCardRecharge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SitesAppBarDropdown(),
            Consumer(
              builder: (context, ref, child) {
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SitesAppBarDropdown extends StatelessWidget {
  const SitesAppBarDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
