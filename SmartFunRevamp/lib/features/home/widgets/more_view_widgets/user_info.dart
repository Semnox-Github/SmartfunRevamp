import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.user,
  });

  final CustomerDTO user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MulishText(
            text: '${user.firstName} ${user.lastName}',
            fontWeight: FontWeight.bold,
            fontColor: CustomColors.customPantone,
            fontSize: 16.0,
          ),
          MulishText(
            text: '${user.email}',
            fontColor: CustomColors.customPantone,
          ),
          MulishText(
            text: '${user.phone}',
            fontColor: CustomColors.customPantone,
          ),
        ],
      ),
    );
  }
}
