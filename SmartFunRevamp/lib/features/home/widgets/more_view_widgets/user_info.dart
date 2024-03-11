import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class UserInfo extends ConsumerWidget {
  const UserInfo({
    super.key,
    required this.user,
  });

  final CustomerDTO user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmsHeader = ref.watch(cmsPageHeaderProvider);
    return Container(
      //  color: HexColor.fromHex(cmsHeader?.backgroundColor).withOpacity(.8),
      margin: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${user.firstName} ${user.lastName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: HexColor.fromHex(cmsHeader?.textColor),
                fontSize: 16.0,
              )),
          Text('${user.email}',
              style: TextStyle(
                color: HexColor.fromHex(cmsHeader?.textColor),
              )),
          Text('${user.phone}',
              style: TextStyle(
                color: HexColor.fromHex(cmsHeader?.textColor),
              )
              //fontColor: CustomColors.customPantone,
              ),
        ],
      ),
    );
  }
}
