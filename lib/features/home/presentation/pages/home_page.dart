import 'package:flutter/material.dart';
import 'package:semnox/features/home/presentation/widgets/custom_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const CustomBottomBar(),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
