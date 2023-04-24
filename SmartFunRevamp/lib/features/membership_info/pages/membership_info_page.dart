import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

enum MembershipTier { bronze, gold, diamond, platinum }

class MembershipInfoPage extends StatelessWidget {
  const MembershipInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Membership'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const OtherTiers(
                tier: MembershipTier.bronze,
                title: 'Became a Bronze Member',
                subtitle: 'On 23 Apr 2021',
              ),
              Container(
                margin: const EdgeInsets.only(top: 75, bottom: 10.0, right: 10.0, left: 10.0),
                height: MediaQuery.of(context).size.height * 0.55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: const GradientBoxBorder(
                    gradient: CustomGradients.verticalGoldenGradient,
                    width: 1,
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: CustomGradients.verticalGoldenGradient,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const MulishText(
                            text: 'Gold Member',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              MulishText(
                                text: 'Since 23 Apr 2021',
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(width: 10.0),
                              MulishText(
                                text: 'More >>',
                                fontWeight: FontWeight.bold,
                                fontColor: CustomColors.hardOrange,
                                textDecoration: TextDecoration.underline,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: -75,
                      height: 150,
                      child: Image.asset(
                        'assets/membership/gold.png',
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 125,
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                    border: const GradientBoxBorder(
                                      gradient: CustomGradients.goldenGradient,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      MulishText(
                                        text: 'Loyalty Points Earned',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      MulishText(
                                        text: '2109',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                    border: const GradientBoxBorder(
                                      gradient: CustomGradients.goldenGradient,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      MulishText(
                                        text: 'Balance',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      MulishText(
                                        text: '120',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                            ],
                          ),
                          MembershipOptions(
                            color: const Color(0xFFD0D5FF),
                            title: 'Loyalty Points Details',
                            svgImage: 'assets/membership/loyalty_points.svg',
                            onTap: () {},
                          ),
                          MembershipOptions(
                            color: const Color(0xFFCFF8FF),
                            title: 'Membership Rewards',
                            svgImage: 'assets/membership/membership_rewards.svg',
                            onTap: () {},
                          ),
                          MembershipOptions(
                            color: const Color(0xFFD1FFD0),
                            title: 'Membership F&Q',
                            svgImage: 'assets/membership/faq.svg',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
                child: DottedLine(
                  direction: Axis.vertical,
                  dashColor: Colors.black,
                ),
              ),
              const OtherTiers(
                tier: MembershipTier.diamond,
                title: 'Diamond',
                subtitle: 'Earn 300 LP.',
              ),
              const OtherTiers(
                tier: MembershipTier.platinum,
                title: 'Platinum',
                subtitle: 'Earn 2500 LP.',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OtherTiers extends StatelessWidget {
  const OtherTiers({
    super.key,
    required this.tier,
    required this.title,
    required this.subtitle,
  });

  final MembershipTier tier;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    Logger().d(tier.name);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/membership/${tier.name}.png',
          height: 100,
        ),
        MulishText(
          text: title,
          fontWeight: FontWeight.bold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MulishText(
              text: subtitle,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
            const SizedBox(width: 10.0),
            const MulishText(
              text: 'More >>',
              fontWeight: FontWeight.bold,
              fontColor: CustomColors.hardOrange,
              textDecoration: TextDecoration.underline,
              fontSize: 12.0,
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        if (tier != MembershipTier.platinum)
          const SizedBox(
            height: 50,
            child: DottedLine(
              direction: Axis.vertical,
              dashColor: Colors.black,
            ),
          ),
      ],
    );
  }
}

class MembershipOptions extends StatelessWidget {
  const MembershipOptions({
    Key? key,
    required this.title,
    required this.svgImage,
    required this.color,
    this.onTap,
  }) : super(key: key);
  final String title;

  final String svgImage;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: CustomColors.customLigthBlue,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50.0,
              width: 50.0,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: color,
              ),
              padding: const EdgeInsets.all(13.0),
              child: SvgPicture.asset(svgImage),
            ),
            MulishText(
              text: title,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
