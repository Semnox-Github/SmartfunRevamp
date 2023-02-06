import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/select_location/provider/select_location_provider.dart';

class SelectLocationManuallyPage extends StatelessWidget {
  const SelectLocationManuallyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: CustomButton(
            onTap: () {},
            label: 'CONFIRM LOCATION',
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchTextField(),
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
              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(sitesProvider).maybeWhen(
                        orElse: () => Container(),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        data: (data) {
                          return ListView.separated(
                            separatorBuilder: (context, index) => const Divider(color: Colors.white),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: CustomGradients.linearGradient,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  title: MulishText(
                                    text: data[index].siteName ?? '',
                                    fontColor: Colors.white,
                                  ),
                                  trailing: const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
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
