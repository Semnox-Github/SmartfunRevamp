import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/cms_provider.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class ProfilePicture extends ConsumerWidget {
  const ProfilePicture({
    Key? key,
    required this.customerDTO,
  }) : super(key: key);

  final CustomerDTO customerDTO;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fInitial = customerDTO.firstName!.isNotEmpty ? '${customerDTO.firstName?[0]}' : '';
    final lInitial = customerDTO.lastName!.isNotEmpty ? '${customerDTO.lastName?[0]}' : '';
    final noImageColor = ref.watch(cmsProvider).value?.cmsModuleColorsHome.profilePictureGradient;

    return InkWell(
      onTap: () async {},
      child: Container(
        padding: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          // gradient: CustomGradients.goldenGradient,
          gradient: LinearGradient(
            colors: [
              HexColor.fromHex(noImageColor?[0]) ?? const Color(0xFFFFF2AD),
              HexColor.fromHex(noImageColor?[1]) ?? const Color(0xFFFFA322),
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: !customerDTO.photoUrl.isNullOrEmpty()
            ? CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                foregroundImage: NetworkImage(customerDTO.photoUrl!),
              )
            : SizedBox(
                height: 40.0,
                width: 40.0,
                child: Center(
                  child: MulishText(
                    text: '$fInitial$lInitial',
                  ),
                ),
              ),
      ),
    );
  }
}
