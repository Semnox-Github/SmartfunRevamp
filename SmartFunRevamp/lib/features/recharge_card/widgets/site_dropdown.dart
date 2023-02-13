import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
