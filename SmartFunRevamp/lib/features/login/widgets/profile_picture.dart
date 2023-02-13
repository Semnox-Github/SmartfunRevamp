import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
    this.profilePicture = 'https://kprofiles.com/wp-content/uploads/2016/05/TWICE-Perfect-World-Concept-Teasers-documents-10.jpeg',
  }) : super(key: key);
  final String profilePicture;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.5),
      decoration: const BoxDecoration(
        gradient: CustomGradients.goldenGradient,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.white,
        foregroundImage: NetworkImage(profilePicture),
      ),
    );
  }
}
