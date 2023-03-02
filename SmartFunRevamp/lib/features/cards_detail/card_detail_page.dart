import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/card_widget.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/cards_detail/bonus_summary_page.dart';

class CardDetailPage extends StatelessWidget {
  const CardDetailPage({Key? key, required this.cardDetails}) : super(key: key);
  final CardDetails cardDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MulishText(
          text: 'Card Details',
          fontColor: CustomColors.customBlue,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        backgroundColor: CustomColors.customLigthBlue,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: CustomColors.customBlue),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                margin: const EdgeInsets.only(bottom: 10.0),
                decoration: const BoxDecoration(
                  color: CustomColors.customLigthBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: CardWidget(cardDetails: cardDetails),
              ),
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CardDetailItem(
                    color: CustomColors.customOrange,
                    image: 'bonus_points',
                    amount: '${cardDetails.bonus?.toStringAsFixed(0)}',
                    desc: 'Bonus',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BonusSummaryPage(cardNumber: cardDetails.accountNumber ?? '', creditPlusType: 5, pageTitle: "Bonus", ),
                        ),
                      );
                    },
                  ),
                  CardDetailItem(
                    color: CustomColors.customGreen,
                    image: 'playtime',
                    amount: '${cardDetails.time?.toStringAsFixed(0)}',
                    desc: 'Time',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BonusSummaryPage(cardNumber: cardDetails.accountNumber ?? '', creditPlusType: 6, pageTitle: "Time", ),
                        ),
                      );
                    },
                  ),
                  CardDetailItem(
                    color: CustomColors.customPurple,
                    image: 'ticket_count',
                    amount: '${cardDetails.ticketCount}',
                    desc: 'Tickets',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BonusSummaryPage(cardNumber: cardDetails.accountNumber ?? '', creditPlusType: 2, pageTitle: "Tickets", ),
                        ),
                      );
                    },
                  ),
                  CardDetailItem(
                    color: CustomColors.customYellow,
                    image: 'courtesy',
                    amount: '${cardDetails.courtesy?.toStringAsFixed(0)}',
                    desc: 'Courtesy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BonusSummaryPage(cardNumber: cardDetails.accountNumber ?? '', creditPlusType: 3, pageTitle: "Courtesy", ),
                        ),
                      );
                    },
                  ),
                  CardDetailItem(
                    color: CustomColors.customPink,
                    image: 'loyalty',
                    amount: '${cardDetails.loyaltyPoints?.toStringAsFixed(0)}',
                    desc: 'Loyalty',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BonusSummaryPage(cardNumber: cardDetails.accountNumber ?? '', creditPlusType: 1, pageTitle: "Loyalty", ),
                        ),
                      );
                    },
                  ),
                  CardDetailItem(
                    color: CustomColors.customLigthBlue,
                    image: 'card_time',
                    amount: '${cardDetails.totalGamesBalance?.toStringAsFixed(0)}',
                    desc: 'Card Games',
                  ),
                ],
              ),
              CustomButton(
                onTap: () {},
                label: 'RECHARGE NOW',
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    MulishText(
                      text: 'More Actions',
                      fontWeight: FontWeight.bold,
                    ),
                    MoreActionListTile(
                      color: CustomColors.customOrange,
                      subTitle: 'Report your lost card and get replacement',
                      title: 'Lost Card',
                      svgImage: 'assets/home/lost_card.svg',
                    ),
                    MoreActionListTile(
                      color: CustomColors.customPurple,
                      subTitle: 'Transfer credits from one card to another',
                      title: 'Tranfer Credit',
                      svgImage: 'assets/home/transfer_credit.svg',
                    ),
                    MoreActionListTile(
                      color: CustomColors.customGreen,
                      subTitle: 'View all your gameplay records',
                      title: 'Game Plays',
                      svgImage: 'assets/home/gameplays.svg',
                    ),
                    MoreActionListTile(
                      color: CustomColors.customYellow,
                      subTitle: 'View Transactions, Recharges and more.',
                      title: 'Activity',
                      svgImage: 'assets/home/activities.svg',
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MoreActionListTile extends StatelessWidget {
  const MoreActionListTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.svgImage,
    required this.color,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String svgImage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: color,
              ),
              padding: const EdgeInsets.all(13.0),
              child: SvgPicture.asset(svgImage),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MulishText(
                  text: title,
                  fontWeight: FontWeight.bold,
                ),
                MulishText(
                  text: subTitle,
                  fontSize: 10.0,
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF292D32),
              ),
            )
          ],
        ),
        const Divider(
          color: CustomColors.customLigthGray,
          thickness: 1.5,
        ),
      ],
    );
  }
}

class CardDetailItem extends StatelessWidget {
  const CardDetailItem({
    Key? key,
    required this.color,
    required this.image,
    required this.amount,
    required this.desc,
    this.onTap,
  }) : super(key: key);
  final Color color;
  final String image;
  final String desc;
  final String amount;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: color,
            ),
            padding: const EdgeInsets.all(13.0),
            child: SvgPicture.asset('assets/card_details/$image.svg'),
          ),
          const SizedBox(height: 10.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MulishText(
                text: amount,
                fontWeight: FontWeight.bold,
              ),
              MulishText(
                text: desc,
                fontColor: CustomColors.customBlack,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
