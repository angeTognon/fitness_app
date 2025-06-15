import 'package:flutter/material.dart';

import '../../../app/components/text_components.dart';
import '../../../utils/colors.dart';
import '../controller/splashController.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    time(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(child: Center(
        child: Container(
          height: 350,
          width: 350,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/lo.png"))),
        ),
      )),
    );
  }
}
