import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
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
                          return ListView.separated(
                          // Let the ListView know how many items it needs to build.
                          itemCount: data.length,
                          separatorBuilder: (_, __) => const Divider(height: 0),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          // Provide a builder function. This is where the magic happens.
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item.game,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  Text(DateFormat('MMM d, yyyy, h:mm a').format(DateTime.parse(item.playDate)),
                                  style: const TextStyle(fontSize: 12, color: Colors.grey))
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${item.site}\nRef: ${item.gameplayId}'),
                                  const Icon(Icons.arrow_forward_ios_outlined)
                                ]
                              ),
                              onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Column(
                                    children: <Widget>[
                                      Text(item.game),
                                      const Text(
                                        "Balance consumed during gameplay",
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    ]
                                  ),
                                  content: SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.30,
                                    width:  MediaQuery.of(context).size.height * 0.30,
                                    child: GridView(
                                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                      ),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.0),
                                                color: Colors.lightBlue,
                                              ),
                                              margin: const EdgeInsets.all(3),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      item.credits.toInt().toString(),
                                                      style: const TextStyle(fontSize: 25, color: Colors.white70)
                                                      ),
                                                    const Text(
                                                      "Credits",
                                                      style: TextStyle(fontSize: 14, color: Colors.white),
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
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.0),
                                                color: Colors.lightBlue,
                                              ),
                                              margin: const EdgeInsets.all(3),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      item.bonus.toInt().toString(),
                                                      style: const TextStyle(fontSize: 25, color: Colors.white70)
                                                      ),
                                                    const Text(
                                                      "Bonus",
                                                      style: TextStyle(fontSize: 14, color: Colors.white),
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
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.0),
                                                color: Colors.lightBlue,
                                              ),
                                              margin: const EdgeInsets.all(3),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      item.time.toInt().toString(),
                                                      style: const TextStyle(fontSize: 25, color: Colors.white70)
                                                      ),
                                                    const Text(
                                                      "Time",
                                                      style: TextStyle(fontSize: 14, color: Colors.white),
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
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.0),
                                                color: Colors.lightBlue,
                                              ),
                                              margin: const EdgeInsets.all(3),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      item.courtesy.toInt().toString(),
                                                      style: const TextStyle(fontSize: 25, color: Colors.white70)
                                                      ),
                                                    const Text(
                                                      "Card Game",
                                                      style: TextStyle(fontSize: 14, color: Colors.white),
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
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('Done'),
                                    ),
                                  ],
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
            const SizedBox(height: 10.0),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
