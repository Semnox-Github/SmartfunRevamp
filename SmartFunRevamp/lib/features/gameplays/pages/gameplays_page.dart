import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/gameplays/provider/gameplays_provider.dart';
import 'package:semnox/features/recharge_card/widgets/user_cards.dart';

class GameplaysPage extends StatefulWidget {
  const GameplaysPage({Key? key}) : super(key: key);

@override
  State<GameplaysPage> createState() => _GameplaysPageState();
}

class _GameplaysPageState extends State<GameplaysPage> {
  String selectedCardNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Game Plays',
          style: TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserCards(
              onCardSelected: (card) {
                selectedCardNumber = card;
              },
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return ref.watch(GameplaysProvider.accountGameplaysProvider).maybeWhen(
                        orElse: () => Container(
                          height: MediaQuery.of(context).size.height * 0.70,
                          width: MediaQuery.of(context).size.width * 0.85,
                          color: Colors.red,
                        ),
                        error: (e,s) => MulishText(
                          text: 'An error has ocurred $e',
                        ),
                        loading: () => const CircularProgressIndicator(),
                        data: (data) {
                          return ListView.builder(
                          // Let the ListView know how many items it needs to build.
                          itemCount: data.length,
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          // Provide a builder function. This is where the magic happens.
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20), 
                                side: const BorderSide(color: Colors.white70)
                              ),                              
                              child: ListTile(                                
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MulishText(
                                      text: item.game,
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold
                                    ),
                                    MulishText(
                                      text: DateFormat('MMM d, yyyy, h:mm a').format(DateTime.parse(item.playDate)),
                                      fontSize: 14, 
                                      fontColor: Colors.grey,
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    MulishText(
                                      text: '\n${item.site}\nRef: ${item.gameplayId}',
                                      fontColor: Colors.black
                                    ),
                                    const Icon(Icons.arrow_forward_ios_outlined,)
                                  ]
                                ),
                                onTap: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                    title: Column(
                                      children: <Widget>[
                                        MulishText(
                                          text: item.game,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const MulishText(
                                          text: "Balance consumed during gameplay",
                                          fontSize: 12, 
                                          fontColor: Colors.grey,
                                        ),
                                      ]
                                    ),
                                    content: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.25,
                                      width:  MediaQuery.of(context).size.height * 0.30,
                                      child: GridView(
                                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: (100/70),
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 20,
                                        ),
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.0),
                                                color: CustomColors.hardOrange,
                                                gradient: CustomGradients.linearGradient
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12.0),
                                                  color: Colors.white,
                                                ),
                                                margin: const EdgeInsets.all(3),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      MulishText(
                                                        text: item.credits.toInt().toString(),
                                                        fontSize: 25, 
                                                        fontColor: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      const MulishText(
                                                        text: "Credits",
                                                        fontSize: 14, 
                                                        fontColor: Colors.grey,
                                                      ),
                                                    ]
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.0),
                                                color: CustomColors.hardOrange,
                                                gradient: CustomGradients.linearGradient
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12.0),
                                                  color: Colors.white,
                                                ),
                                                margin: const EdgeInsets.all(3),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      MulishText(
                                                        text: item.bonus.toInt().toString(),
                                                        fontSize: 25, 
                                                        fontColor: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      const MulishText(
                                                        text: "Bonus",
                                                        fontSize: 14, 
                                                        fontColor: Colors.grey,
                                                      ),
                                                    ]
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.0),
                                                color: CustomColors.hardOrange,
                                                gradient: CustomGradients.linearGradient
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12.0),
                                                  color: Colors.white,
                                                ),
                                                margin: const EdgeInsets.all(3),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      MulishText(
                                                        text: item.time.toInt().toString(),
                                                        fontSize: 25, 
                                                        fontColor: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      const MulishText(
                                                        text: "Time",
                                                        fontSize: 14, 
                                                        fontColor: Colors.grey,
                                                      ),
                                                    ]
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.0),
                                                color: CustomColors.hardOrange,
                                                gradient: CustomGradients.linearGradient
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12.0),
                                                  color: Colors.white,
                                                ),
                                                margin: const EdgeInsets.all(3),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      MulishText(
                                                        text: item.courtesy.toInt().toString(),
                                                        fontSize: 25, 
                                                        fontColor: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      const MulishText(
                                                        text: "Card Game",
                                                        fontSize: 14, 
                                                        fontColor: Colors.grey,
                                                      ),
                                                    ]
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                      ),
                                    ),
                                    actions: <Widget>[
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.80,
                                        child: ElevatedButton(
                                          onPressed: () => Navigator.pop(context, 'OK'),
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              backgroundColor: CustomColors.hardOrange,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10))),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                                color: CustomColors.hardOrange,
                                                gradient: CustomGradients.linearGradient,
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Container(
                                              height: 40,
                                              alignment: Alignment.center,
                                              child: const MulishText(
                                                text: "Done",
                                                fontColor: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ), 
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                },
              )
            ),
            const SizedBox(height: 20.0),

            
          ],
        ),
      ),
    );
  }
}
