import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxSetupScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? footerWidget;
  final String? applogo;
  final String? appname;
  const SemnoxSetupScaffold(
      {Key? key,
      this.body,
      this.footerWidget,
      this.applogo,
      this.appname,
      this.scaffoldKey})
      : super(key: key);
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: SemnoxConstantColor.appbarBackground(context),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Hero(
              tag: "SEMNOX_LOGO",
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.mapToIdealHeight(context),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      applogo.toString(),
                      height: 134.mapToIdealWidth(context),
                      width: 432.mapToIdealWidth(context),
                    ),
                  ),
                  SizedBox(
                    height: 30.mapToIdealHeight(context),
                  ),
                  SemnoxText.h4(
                      text: appname.toString(),
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ClipPath(
              clipper: MyClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: SemnoxConstantColor.scaffoldBackground(
                      context), //Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 550.0.mapToIdealWidth(context),
                        ),
                        child: body),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: footerWidget,
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.1320051);
    path.cubicTo(0, size.height * 0.1110993, 0, size.height * 0.1006457,
        size.width * 0.005388806, size.height * 0.09238359);
    path.cubicTo(
        size.width * 0.01013458,
        size.height * 0.08510729,
        size.width * 0.01774611,
        size.height * 0.07902817,
        size.width * 0.02725097,
        size.height * 0.07492280);
    path.cubicTo(
        size.width * 0.03804361,
        size.height * 0.07026120,
        size.width * 0.05231444,
        size.height * 0.06931662,
        size.width * 0.08085611,
        size.height * 0.06742725);
    path.lineTo(size.width * 0.9030778, size.height * 0.01300122);
    path.cubicTo(
        size.width * 0.9366958,
        size.height * 0.01077599,
        size.width * 0.9535042,
        size.height * 0.009663364,
        size.width * 0.9664819,
        size.height * 0.01375441);
    path.cubicTo(
        size.width * 0.9778833,
        size.height * 0.01734853,
        size.width * 0.9873056,
        size.height * 0.02362594,
        size.width * 0.9932417,
        size.height * 0.03158419);
    path.cubicTo(size.width, size.height * 0.04064306, size.width,
        size.height * 0.05295502, size.width, size.height * 0.07757893);
    path.lineTo(size.width, size.height * 0.9994934);
    path.lineTo(0, size.height * 0.9994934);
    path.lineTo(0, size.height * 0.1320051);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return oldClipper != this ? true : false;
  }
}
