import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_execution_context_use_case.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/image_handler.dart';
import 'package:semnox/di/injection_container.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

Future<void> registerLoggedUserWithSite(CustomerDTO customerDTO, SiteViewDTO? selectedSite) async {
  final getExecutionContextUseCase = Get.find<GetExecutionContextUseCase>();
  registerUser(customerDTO);
  final executionContextResponse = await getExecutionContextUseCase(selectedSite!.siteId!);
  executionContextResponse.fold(
    (l) {},
    (r) {
      Get.replace<SmartFunApi>(SmartFunApi('', r));
    },
  );
}

class EnableLocationPage extends StatelessWidget {
  const EnableLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            const Spacer(),
            const ImageHandler(
              imageKey: "select_location_image_path",
            ),
            Text(
              SplashScreenNotifier.getLanguageLabel('Access Location'),
              style: GoogleFonts.mulish(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Text(
              SplashScreenNotifier.getLanguageLabel(
                  'If you enable location services we can show you the nearest Store and Store specific offers, deals and prices for you'),
              style: GoogleFonts.mulish(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  onTap: () async {
                    // if (await PermissionServices.getLocationPermision()) {
                    Navigator.pushNamed(context, Routes.kMap);
                    // }
                  },
                  label: SplashScreenNotifier.getLanguageLabel('ENABLE LOCATION SERVICES'),
                ),
                const SizedBox(height: 10.0),
                CustomWhiteButton(
                  onPresssed: () => Navigator.pushNamed(context, Routes.kSelectLocationManually),
                  label: SplashScreenNotifier.getLanguageLabel("I'LL LOCATE THE STORE MANUALLY"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomWhiteButton extends StatelessWidget {
  const CustomWhiteButton({
    Key? key,
    required this.label,
    required this.onPresssed,
  }) : super(key: key);
  final String label;
  final Function() onPresssed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: CustomGradients.linearGradient,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(3),
        child: TextButton(
          onPressed: onPresssed,
          child: Text(
            label,
            style: const TextStyle(
              color: CustomColors.hardOrange,
            ),
          ),
        ),
      ),
    );
  }
}
