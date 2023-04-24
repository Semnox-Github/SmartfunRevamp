import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/select_location/provider/select_location_provider.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

class SitesAppBarDropdown extends ConsumerStatefulWidget {
  const SitesAppBarDropdown({
    Key? key,
    this.onChanged,
  }) : super(key: key);
  final Function(SiteViewDTO?)? onChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SitesAppBarDropdownState();
}

class _SitesAppBarDropdownState extends ConsumerState<SitesAppBarDropdown> {
  SiteViewDTO? _selectedSite;
  late List<SiteViewDTO> sites;

  @override
  void initState() {
    super.initState();
    sites = List<SiteViewDTO>.from(ref.read(getAllSitesProvider).value ?? []);
    for (var element in sites) {
      Logger().d(element.siteId);
    }

    final userSite = ref.read(loginProvider.notifier).selectedSite?.siteId ?? 0;
    _selectedSite = sites.firstWhere(
      (element) => element.siteId == userSite,
      orElse: () => sites.first,
    );
    Logger().d(userSite);
    if (widget.onChanged != null) {
      widget.onChanged!(_selectedSite);
    }
  }

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
          DropdownButton<SiteViewDTO>(
            value: _selectedSite,
            icon: const Icon(Icons.expand_more),
            underline: const SizedBox(),
            hint: const MulishText(
              text: 'Select a site',
              textAlign: TextAlign.center,
            ),
            items: sites.map((e) {
              return DropdownMenuItem<SiteViewDTO>(
                value: e,
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
              if (widget.onChanged != null) {
                widget.onChanged!(site);
              }
              setState(() {
                _selectedSite = site!;
              });
            },
          ),
        ],
      ),
    );
  }
}
