import 'package:flutter/material.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/round_rectangle_picture.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/user_info.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class UserPresentationCard extends StatelessWidget {
  const UserPresentationCard({
    super.key,
    required this.user,
  });

  final CustomerDTO user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.kAccount),
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              RoundRectanglePicture(user: user),
              Expanded(child: UserInfo(user: user)),
              IconButton(
                onPressed: () => Navigator.pushNamed(context, Routes.kAccount),
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
