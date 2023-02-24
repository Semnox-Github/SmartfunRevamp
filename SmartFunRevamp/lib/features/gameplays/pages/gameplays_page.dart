import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/gameplays/provider/gameplays_provider.dart';

class GameplaysPage extends StatelessWidget {
  const GameplaysPage({Key? key}) : super(key: key);

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
        minimum: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return ref.watch(GameplaysProvider.accountGameplaysProvider).maybeWhen(
                        orElse: () => Container(
                          height: MediaQuery.of(context).size.height * 0.50,
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
                          separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          // Provide a builder function. This is where the magic happens.
                          // Convert each item into a widget based on the type of item it is.
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
                                                      item.credits.toString(),
                                                      style: const TextStyle(fontSize: 20, color: Colors.black)
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
                                                      item.bonus.toString(),
                                                      style: const TextStyle(fontSize: 20, color: Colors.black)
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
                                                      item.time.toString(),
                                                      style: const TextStyle(fontSize: 20, color: Colors.black)
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
                                                      item.courtesy.toString(),
                                                      style: const TextStyle(fontSize: 20, color: Colors.black)
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
