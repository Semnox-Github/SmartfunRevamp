import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
    required this.customerDTO,
  }) : super(key: key);

  final CustomerDTO customerDTO;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.5),
      decoration: const BoxDecoration(
        gradient: CustomGradients.goldenGradient,
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
                  text: '${customerDTO.firstName![0]}${customerDTO.lastName![0]}',
                ),
              ),
            ),
    );
  }
}
