import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/gameplays/account_gameplays.dart';
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
                                children: [
                                  Column(
                                    children: [
                                      Text(item.game)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(item.playDate)
                                    ],
                                  )
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text('${item.site}\nRef: ${item.gameplayId}'),
                                ]
                              ),
                              onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text(item.game),
                                  content: Container(
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    child: GridView(
                                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                      ),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: [
                                        InkWell(
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  color: Colors.grey,
                                                ),
                                                padding: const EdgeInsets.all(13.0)
                                              ),
                                              const SizedBox(height: 10.0),
                                              Text(
                                                'Credits ${item.credits}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(),
                                        Container(),
                                        Container(),
                                      ]
                                    ),
                                    // child: 
                                    // Column(
                                    //   children: [
                                    //     Row(
                                    //       children: [
                                    //         Column(
                                    //           children: [
                                    //             Text('Credits ${item.credits}')
                                    //           ],
                                    //         ),
                                    //         Column(
                                    //           children: [
                                    //             Text('Bonus ${item.bonus}')
                                    //           ],
                                    //         )
                                    //       ],
                                    //     ),
                                    //     Row(
                                    //       children: [
                                    //         Column(
                                    //           children: [
                                    //             Text('Time ${item.time}')
                                    //           ],
                                    //         ),
                                    //         Column(
                                    //           children: [
                                    //             Text('Card Game ${item.courtesy}')
                                    //           ],
                                    //         )
                                    //       ],
                                    //       )
                                    //   ],
                                    // ),
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
