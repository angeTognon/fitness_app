import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import '../base/base.dart';


class AfterSplash extends StatefulWidget {
  const AfterSplash({super.key});

  @override
  State<AfterSplash> createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              // colorFilter: ColorFilter.mode(Colors.black, BlendMode.saturation),
              image: AssetImage("assets/images/man.jpg"),fit: BoxFit.cover)
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: h(0)),
            Container(
              margin: const EdgeInsets.only(left: 20,right: 30),
              child: const TextComponent(text: "fitness_app",size: 25,
                fontWeight: FontWeight.bold,color: Colors.white,),
            ),
            h(15),
            Container(
              margin: const EdgeInsets.only(left: 20,right: 30),
              child: const TextComponent(text: "Votre guide vers un bien-être total et un corps de rêve",size: 15,
              fontWeight: FontWeight.bold,color: Colors.white,),
            ),
            h(30),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Base(),));
                },
                child: ButtonComponent(label: "Commencer",size: 15,fontWeight: FontWeight.bold,)),
            h(20)
          ],
        ),
      ),
    );
  }
}
