import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class RoundRectanglePicture extends ConsumerWidget {
  const RoundRectanglePicture({
    super.key,
    required this.user,
  });
  final CustomerDTO user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fInitial = user.firstName?.isNotEmpty ?? false ? '${user.firstName?[0]}' : '';
    final lInitial = user.lastName?.isNotEmpty ?? false ? '${user.lastName?[0]}' : '';
    final noImageGradient =
        ref.watch(newHomePageCMSProvider)?.cmsModuleColorsHome?.profilePictureGradient.getColorList() ??
            [CustomColors.hardOrange, CustomColors.customOrange];
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: noImageGradient),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        width: 64,
        height: 64,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: !user.photoUrl.isNullOrEmpty()
              ? Image.network(user.photoUrl!)
              : Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: noImageGradient,
                    ),
                  ),
                  child: MulishText(
                    text: '$fInitial$lInitial',
                    fontSize: 25.0,
                  ),
                ),
        ),
      ),
    );
  }
}
