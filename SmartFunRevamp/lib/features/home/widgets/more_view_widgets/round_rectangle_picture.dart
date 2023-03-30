import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class RoundRectanglePicture extends StatelessWidget {
  const RoundRectanglePicture({
    super.key,
    required this.user,
  });
  final CustomerDTO user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        gradient: CustomGradients.goldenGradient,
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
                  child: MulishText(
                    text: '${user.firstName![0]}${user.lastName![0]}',
                    fontSize: 25.0,
                  ),
                ),
        ),
      ),
    );
  }
}
