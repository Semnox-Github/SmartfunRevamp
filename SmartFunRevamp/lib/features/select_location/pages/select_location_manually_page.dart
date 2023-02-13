import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/select_location/provider/select_location_provider.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

class SelectLocationManuallyPage extends StatelessWidget {
  const SelectLocationManuallyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late SiteViewDTO selectedSite;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: CustomColors.customLigthBlue,
        centerTitle: false,
        iconTheme: const IconThemeData(color: CustomColors.customBlue),
        title: const MulishText(
          text: 'Select Location',
          fontWeight: FontWeight.bold,
          fontColor: CustomColors.customBlue,
        ),
      ),
      bottomSheet: Material(
        elevation: 20.0,
        child: Container(
          padding: const EdgeInsets.all(25.0),
          child: Consumer(
            builder: (context, ref, child) {
              return CustomButton(
                onTap: () {
                  (ref.read(selectLocationStateProvider.notifier).saveSite(selectedSite)).then(
                    (_) => Navigator.pushReplacementNamed(context, Routes.kHomePage),
                  );
                },
                label: 'CONFIRM LOCATION',
              );
            },
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return SearchTextField(
                    onChanged: (filter) => ref.read(selectLocationStateProvider.notifier).filterSites(filter),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.customOrange),
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    MulishText(
                      text: 'Locate nearest store using GPS',
                      fontColor: CustomColors.hardOrange,
                      textDecoration: TextDecoration.underline,
                    ),
                    Icon(
                      Icons.gps_fixed_rounded,
                      color: CustomColors.hardOrange,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              LocationListView(
                onSelected: (site) => selectedSite = site,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LocationListView extends StatefulWidget {
  const LocationListView({
    Key? key,
    required this.onSelected,
  }) : super(key: key);
  final Function(SiteViewDTO) onSelected;
  @override
  State<LocationListView> createState() => _LocationListViewState();
}

class _LocationListViewState extends State<LocationListView> {
  int? locationSelected;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref.watch(selectLocationStateProvider).maybeWhen(
              orElse: () => Container(),
              inProgress: () => const Center(
                child: CircularProgressIndicator(),
              ),
              success: (data) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(color: Colors.white),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: locationSelected == index ? CustomGradients.linearGradient : null,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: MulishText(
                          text: data[index].siteName ?? '',
                          fontColor: locationSelected == index ? Colors.white : Colors.black,
                        ),
                        onTap: () {
                          setState(() {
                            locationSelected = index;
                            widget.onSelected(data[index]);
                          });
                        },
                        trailing: locationSelected == index
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    );
                  },
                );
              },
            );
      },
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        suffixIcon: Container(
          margin: const EdgeInsets.all(5.0),
          decoration: const BoxDecoration(
            color: CustomColors.customLigthBlue,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.search,
            size: 25.0,
            color: CustomColors.customBlue,
          ),
        ),
      ),
    );
  }
}
