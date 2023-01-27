import 'package:flutter/material.dart';

class SemnoxSplashScreen extends StatelessWidget {
  const SemnoxSplashScreen({Key? key, this.message}) : super(key: key);
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: "SEMNOX_LOGO",
              child: Image.asset(
                "assets/images/semnox_logo.png",
                width: 200,
              ),
            ),
          ),
          if (message != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
