import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/account_game_dto_list.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/cards_detail/bonus_summary_page.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class AccountGamesSummaryDetailPage extends ConsumerWidget {
  const AccountGamesSummaryDetailPage({Key? key, required this.summary})
      : super(key: key);
  final AccountGameDTOList summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final List<AccountGameExtendedDTOList>? gamesIncExcDetail =
        summary.accountGameExtendedDTOList;
    late List<AccountGameExtendedDTOList>? gamesIncluded = gamesIncExcDetail
      ?..removeWhere((element) => (!element.exclude));
    late List<AccountGameExtendedDTOList>? gamesExcluded = gamesIncExcDetail
      ?..removeWhere((element) => (element.exclude));
    final double width = MediaQuery.of(context).size.width;
    final cmsBody = ref.watch(cmsBodyStyleProvider);
    final cmsHeader = ref.watch(cmsPageHeaderProvider);
    return Scaffold(
      backgroundColor: HexColor.fromHex(cmsBody?.appBackGroundColor),
      appBar: CustomAppBarCustomWidget(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              summary.gameId.toString(),
              style: TextStyle(
                color: HexColor.fromHex(cmsHeader?.textColor),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${summary.fromDate.formatDate(DateFormat.YEAR_ABBR_MONTH_DAY)} - ${summary.fromDate.formatDate(DateFormat.HOUR_MINUTE)}',
              //  fontColor: CustomColors.customBlue,
              style: TextStyle(
                color: HexColor.fromHex(cmsHeader?.textColor),
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: CustomColors.customLigthGray,
                      ),
                    ),
                    child: Column(
                      children: [
                        const MulishText(
                          text: 'Valid From',
                          fontWeight: FontWeight.bold,
                        ),
                        MulishText(
                            text: summary.fromDate.formatDate('dd MMM yyyy')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: CustomColors.customLigthGray,
                      ),
                    ),
                    child: Column(
                      children: [
                        const MulishText(
                          text: 'Valid To',
                          fontWeight: FontWeight.bold,
                        ),
                        MulishText(
                            text: summary.expiryDate.formatDate('dd MMM yyyy')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TotalBonusBalance(
              totalBonus: summary.balanceGames.toInt(),
              pageTitle: SplashScreenNotifier.getLanguageLabel(
                  'Can be used to play below games'),
            ),
            const SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.check_circle,
                          size: 18, color: Colors.greenAccent),
                    ),
                    TextSpan(
                      text:
                          " ${SplashScreenNotifier.getLanguageLabel('Can be used to play below games')}",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: width * 0.90,
              child: DataTable(
                headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return CustomColors.customOrange; // Use the default value.
                }),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 18, 157, 249)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                columns: <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        SplashScreenNotifier.getLanguageLabel('Category'),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        SplashScreenNotifier.getLanguageLabel('Game'),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        SplashScreenNotifier.getLanguageLabel('Qty'),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  gamesIncluded!.isEmpty ? 1 : gamesIncluded.length,
                  (int index) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(gamesIncluded.isEmpty
                          ? '--'
                          : gamesIncluded[index].gameProfileId.toString())),
                      DataCell(Text(gamesIncluded.isEmpty
                          ? '--'
                          : gamesIncluded[index].gameId.toString())),
                      DataCell(Text(gamesIncluded.isEmpty
                          ? '--'
                          : gamesIncluded[index].playLimitPerGame.toString())),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.remove_circle,
                          size: 18, color: Colors.red),
                    ),
                    TextSpan(
                      text:
                          " ${SplashScreenNotifier.getLanguageLabel('Below games are excluded')}",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: width * 0.90,
              child: DataTable(
                headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return CustomColors.customOrange; // Use the default value.
                }),
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.customLigthGray),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                columns: <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        SplashScreenNotifier.getLanguageLabel('Category'),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        SplashScreenNotifier.getLanguageLabel('Game'),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        SplashScreenNotifier.getLanguageLabel('Qty'),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  gamesExcluded!.isEmpty ? 1 : gamesExcluded.length,
                  (int index) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(gamesExcluded.isEmpty
                          ? '--'
                          : gamesExcluded[index].gameProfileId.toString())),
                      DataCell(Text(gamesExcluded.isEmpty
                          ? '--'
                          : gamesExcluded[index].gameId.toString())),
                      DataCell(Text(gamesExcluded.isEmpty
                          ? '--'
                          : gamesExcluded[index].playLimitPerGame.toString())),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
