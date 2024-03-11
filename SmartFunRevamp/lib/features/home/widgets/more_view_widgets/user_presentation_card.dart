import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/round_rectangle_picture.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/user_info.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class UserPresentationCard extends ConsumerWidget {
  const UserPresentationCard({
    super.key,
    required this.user,
  });

  final CustomerDTO user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmsHeader = ref.watch(cmsPageHeaderProvider);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.kAccount),
      child: Card(
        //elevation: 15.0,
        color: HexColor.fromHex(cmsHeader?.backgroundColor).withOpacity(0.8),

        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          children: [
            RoundRectanglePicture(user: user),
            Expanded(child: UserInfo(user: user)),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, Routes.kAccount),
              icon: Icon(
                Icons.arrow_forward_ios,
                color: HexColor.fromHex(cmsHeader?.textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
