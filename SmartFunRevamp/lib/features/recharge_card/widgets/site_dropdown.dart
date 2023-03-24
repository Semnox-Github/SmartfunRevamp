import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/select_location/provider/select_location_provider.dart';

class SitesAppBarDropdown extends StatefulWidget {
  const SitesAppBarDropdown({
    Key? key,
  }) : super(key: key);

  @override
  State<SitesAppBarDropdown> createState() => _SitesAppBarDropdownState();
}

class _SitesAppBarDropdownState extends State<SitesAppBarDropdown> {
  String? _selectedSite;
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
          Consumer(
            builder: (context, ref, child) {
              return ref.watch(getAllSitesProvider).maybeWhen(
                    orElse: () => Container(),
                    error: (error, stackTrace) => const MulishText(text: "We couln't retrieve the sites"),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    data: (data) {
                      return DropdownButton<String>(
                        value: _selectedSite,
                        icon: const Icon(Icons.expand_more),
                        underline: const SizedBox(),
                        hint: const MulishText(
                          text: 'Select a site',
                          textAlign: TextAlign.center,
                        ),
                        items: data.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.siteName,
                            child: Text(
                              e.siteName!,
                              style: GoogleFonts.mulish(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (site) {
                          setState(() {
                            _selectedSite = site!;
                          });
                        },
                      );
                    },
                  );
            },
          ),
        ],
      ),
    );
  }
}
