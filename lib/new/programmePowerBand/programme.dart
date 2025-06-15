import 'package:flutter/material.dart';
import 'package:fitness_app/app/components/bouton_components.dart';
// import 'package:fitness_app/new/programme/programme_power_homme.dart';
// import 'package:fitness_app/new/programme/programme_renforcement_musculaire_homme.dart';
import 'package:fitness_app/new/programmePowerBand/programme_bbl.dart';
import 'package:fitness_app/new/programmePowerBand/programme_express.dart';
import 'package:fitness_app/new/programmePowerBand/programme_mix.dart';
import 'package:fitness_app/new/programmePowerBand/programme_power.dart';
import 'package:fitness_app/utils/colors.dart';

import '../../app/components/text_components.dart';

class Programme extends StatefulWidget {
  // const Programme({super.key});
  bool isLocked;
  Programme({super.key, required this.isLocked});
  @override
  State<Programme> createState() => _ProgrammeState();
}

class _ProgrammeState extends State<Programme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: TextComponent(
          text: "Programme",
          color: Colors.white,
          size: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20,left: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Row(
              spacing: 10,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  color: mainColor,
                  height: 35,
                  width: 100,
                  child: Center(
                    child: TextComponent(
                      text: "Programme",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextComponent(
                  text: "Homme",
                  fontWeight: FontWeight.bold,
                  size: 14,
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProgrammePower(path: "pgpower.png",isFromAccueil: widget.isLocked,),));
                      },
                      child: Box("pgpower.png", "Power")),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProgrammeExpress(path: "pgexpress.png",isFromAccueil: widget.isLocked,),));
                      },
                      child: Box("pgexpress.png", "Express")),
                ),
              ],
            ),

            Row(
              spacing: 10,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  color: mainColor,
                  height: 35,
                  width: 100,
                  child: Center(
                    child: TextComponent(
                      text: "Programme",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextComponent(
                  text: "Femme",
                  fontWeight: FontWeight.bold,
                  size: 14,
                )
              ],
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProgrammeBBL(path: "pgbbl.png",isFromAccueil: widget.isLocked,),));
                },
                child: Box("pgbbl.png", "BBL")),

            Row(
              spacing: 10,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  color: mainColor,
                  height: 35,
                  width: 100,
                  child: Center(
                    child: TextComponent(
                      text: "Programme",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextComponent(
                  text: "Mixte",
                  fontWeight: FontWeight.bold,
                  size: 14,
                )
              ],
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProgrammeMix(path: "pgdouleur.png",isFromAccueil: widget.isLocked,),));
                },
                child: Box("pgdouleur.png", "Douleurs lombaires")),
          ],
        ),
      ),
    );
  }

  Widget Box(String img, title) {
    return Container(
      height: 200,
      width: 165,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage("assets/images/$img"), fit: BoxFit.cover)),
      child: Stack(
        children: [
          Positioned(
              bottom: 0,left: 0,right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,spacing: 15,
                children: [
                  Center(child: TextComponent(text: title,color: Colors.white,size: 14,fontWeight: FontWeight.bold,)),
                  Container(
                    height: 30,width: 80,
                    child: ButtonComponent(label: "Details"),
                  ),
                  SizedBox(height: 15,)
                ],
              ))
        ],
      ),
    );
  }
}
