import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExoFromProgramme.dart';
import 'package:fitness_app/new/instruction/presentationPowerBandPgPower.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/components/text_components.dart';
import '../../modules/monCompte/controller/controller.dart';
import '../../utils/colors.dart';
import '../LectureVideoExo/lectureVideosExo.dart';
import '../instruction/presentationPowerBand.dart';

class ProgrammePower extends StatefulWidget {
  bool isFromAccueil;
  String path;

  ProgrammePower({required this.path,required this.isFromAccueil});

  @override
  State<ProgrammePower> createState() => _ProgrammePowerState();
}

class _ProgrammePowerState extends State<ProgrammePower> {

  late SharedPreferences _prefs;
  final Set<String> _completedSessions = {};

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadCompletedSessions();
  }

  void _loadCompletedSessions() {
    Set<String> completedSessions = _prefs.getStringList('completedSessions_pgpower_powerband')?.toSet() ?? {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList('completedSessions_pgpower_powerband', _completedSessions.toList());
    });
  }


  bool _isSessionCompleted(String sessionName) {
    return _completedSessions.contains(sessionName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Screen.height(context) / 2,
              child: Stack(
                children: [
                  Container(
                    height: 420,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF333333),
                          Color(0xFF0A0D15),
                          Color(0xFF434040),
                        ],
                        stops: [0.0, 0.8, 10],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 50,
                    child: Column(
                      spacing: 10,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {Navigator.pop(context);},
                                  child: Icon(Icons.arrow_back_ios,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        Container(
                          height: 200,width: Screen.width(context),
                          margin: EdgeInsets.only(left: 20,right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(image: AssetImage("assets/images/${widget.path}"),fit: BoxFit.cover,alignment: Alignment.center)
                          ),
                        )

                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10000, sigmaY: 10000),
                          child: Container(
                            width: Screen.width(context) / 1.05,
                            padding: EdgeInsets.only(top: 15,bottom: 15,right: 10,left: 10),
                            height: 175,
                            decoration: BoxDecoration(
                              color: Colors.white12.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              spacing: 5,
                              children: [
                                Container(
                                  color: mainColor,
                                  width: 5,
                                  height: 250,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: Screen.width(context) / 1.3,
                                      child: TextComponent(
                                        textAlign: TextAlign.start,
                                        text: "Power",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),

                                    Container(
                                      width: Screen.width(context) / 1.18,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        spacing: 20,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 60,width: 60,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: AssetImage("assets/images/objectifs.png"))
                                                ),
                                              ),
                                              // Icon(Icons.flag_circle_rounded, color: mainColor, size: 35),
                                              TextComponent(text: "Objectif", color: Colors.white70, fontWeight: FontWeight.bold),
                                              TextComponent(text: "Développement\nmusculaire", color: Colors.white.withOpacity(0.7),textAlign: TextAlign.center,size: 13,)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 60,width: 60,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: AssetImage("assets/images/level.png"))
                                                ),
                                              ),
                                              // Icon(Icons.flag_circle_rounded, color: mainColor, size: 35),
                                              TextComponent(text: "Niveau", color: Colors.white70, fontWeight: FontWeight.bold),
                                              TextComponent(text: "Intermédiaire", color: Colors.white.withOpacity(0.7))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 60,width: 60,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: AssetImage("assets/images/duree.png"))
                                                ),
                                              ),
                                              // Icon(Icons.flag_circle_rounded, color: mainColor, size: 35),
                                              TextComponent(text: "Durée", color: Colors.white70, fontWeight: FontWeight.bold),
                                              TextComponent(text: "8 semaines", color: Colors.white.withOpacity(0.7))
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: 12,
                children: [
                  TextComponent(text: "Contenu",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap : (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InstructionPowerBandPgPower(producName: "Power", path: "power1.png")));
                    },
                    child: Card(
                      color: Colors.white,
                      child: Container(
                        height: 80,
                        width: Screen.width(context),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          spacing: 20,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(image: AssetImage("assets/images/s1.png"),fit: BoxFit.cover)
                              ),
                            ),
                            Expanded(
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 3,
                                children: [
                                  TextComponent(text: "Instruction complète",fontWeight: FontWeight.bold,),
                                ],
                              ),
                            ),
                            Icon( Icons.play_circle_sharp, color: mainColor, size: 35),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextComponent(text: "Semaine 1",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance1'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Developpé Debout à la Poulie",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 140),
                              SerieConfig(repetitions: 8, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=31&pp=iAQB",
                          ),
                          Exercice(
                            titre: "OVERHEAD PRESS",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90, // 1mn30 = 90 secondes
                            linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB", // Ajoutez le lien vidéo si disponible
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=28&pp=iAQB", // Ajoutez le lien vidéo si disponible
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB", // Ajoutez le lien vidéo si disponible
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60, // 1mn = 60 secondes
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv", // Ajoutez le lien vidéo si disponible
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s1.png", 1, "PuSh 1 Pectoraux et Deltoides Lateraux",false),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance2'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 6, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Oiseau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s2.png", 2, "PULL 1 Epaisseur Du Dos",false),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance3'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 8, charge: 120),
                              SerieConfig(repetitions: 6, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Extension Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 8, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s3.png", 3, "Legs 1 Quadriceps",false),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance4'),
                        path: widget.path, pg : "powerband_pgpower",

                        exercice: [
                          Exercice(
                            titre: "Développé Incliné",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 120),
                              SerieConfig(repetitions: 8, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Développé Militaire Assis",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 20, charge: 30),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s1.png", 4, "Push 2 Haut des Pectoraux + Deltoides",false),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance5'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Pull Over",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Prise Large",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 12, charge: 100),
                              SerieConfig(repetitions: 10, charge: 110),
                              SerieConfig(repetitions: 8, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Face Pull au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s2.png", 5, "Pull 2 Largeur du Dos",false),
                  ),

                  TextComponent(text: "Semaine 2",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance1'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Debout à la Poulie",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 140),
                              SerieConfig(repetitions: 8, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
                          ),
                          Exercice(
                            titre: "OVERHEAD PRESS",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,"s1.png", 1, "Push 1 Pectoraux et Deltoides Lateraux",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance2'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 6, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Oiseau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,"s2.png", 2, "PULL 1 Epaisseur Du Dos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance3'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 8, charge: 120),
                              SerieConfig(repetitions: 6, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Extension Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 8, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,"s3.png", 3, "Legs 1 Quadriceps",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance4'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Pull Over",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Prise Large",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 12, charge: 100),
                              SerieConfig(repetitions: 10, charge: 110),
                              SerieConfig(repetitions: 8, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Face Pull au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,"s1.png", 4, "Pull 2 Largeur du Dos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance5'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Rebonds",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 6, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulevé de terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 6, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Hip Thrust",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 12, charge: 240),
                              SerieConfig(repetitions: 12, charge: 240),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 100, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,"s2.png", 5, "Leg 2 Ischios & Fessiers",true),
                  )

                  ,TextComponent(text: "Semaine 3",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance1'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Debout à la Poulie",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 140),
                              SerieConfig(repetitions: 8, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
                          ),
                          Exercice(
                            titre: "OVERHEAD PRESS",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,"s1.png", 1, "Push 1 Pectoraux et Deltoides Lateraux",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance2'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 6, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Oiseau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,"s2.png", 2, "PULL 1 Epaisseur Du Dos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance3'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 8, charge: 120),
                              SerieConfig(repetitions: 6, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Extension Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 8, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,"s3.png", 3, "Legs 1 Quadriceps",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance4'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Incliné",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 120),
                              SerieConfig(repetitions: 8, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Développé Militaire Assis",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 20, charge: 30),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,"s1.png", 4, "Push 2 Haut des Pectoraux + Deltoides",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance5'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Rebonds",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 6, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulevé de terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 6, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Hip Thrust",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 12, charge: 240),
                              SerieConfig(repetitions: 12, charge: 240),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 100, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,"s2.png", 5, "Leg 2 Ischios & Fessiers",true),
                  ),

                  TextComponent(text: "Semaine 4",fontWeight: FontWeight.bold,color: mainColor,size: 14,),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance1'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Incliné",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 120),
                              SerieConfig(repetitions: 8, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Développé Militaire Assis",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 20, charge: 30),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,"s1.png", 1, "Push 2 Haut des Pectoraux + Deltoides",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance2'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Pull Over",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Prise Large",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 12, charge: 100),
                              SerieConfig(repetitions: 10, charge: 110),
                              SerieConfig(repetitions: 8, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Face Pull au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,"s2.png", 2, "Pull 2 Largeur du Dos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance3'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Rebonds",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 6, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulevé de terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 6, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Hip Thrust",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 12, charge: 240),
                              SerieConfig(repetitions: 12, charge: 240),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 100, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,"s3.png", 3, "Leg 2 Ischios & Fessiers",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance4'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Debout à la Poulie",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 140),
                              SerieConfig(repetitions: 8, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
                          ),
                          Exercice(
                            titre: "OVERHEAD PRESS",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,"s1.png", 4, "Push 1 Pectoraux et Deltoides Lateraux",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance5'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 6, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Oiseau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,"s2.png", 5, "PULL 1 Epaisseur Du Dos",true),
                  ),

                  TextComponent(text: "Semaine 5",fontWeight: FontWeight.bold,color: mainColor,size: 14,),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance1'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Incliné",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 120),
                              SerieConfig(repetitions: 8, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Développé Militaire Assis",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 20, charge: 30),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,"s1.png", 1, "Push 2 Haut des Pectoraux + Deltoides",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance2'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Pull Over",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Prise Large",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 12, charge: 100),
                              SerieConfig(repetitions: 10, charge: 110),
                              SerieConfig(repetitions: 8, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Face Pull au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,"s2.png", 2, "Pull 2 Largeur du Dos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance3'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Rebonds",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 6, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulevé de terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 6, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Hip Thrust",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 12, charge: 240),
                              SerieConfig(repetitions: 12, charge: 240),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 100, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,"s3.png", 3, "Leg 2 Ischios & Fessiers",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance4'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 6, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Oiseau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,"s1.png", 4, "PULL 1 Epaisseur Du Dos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance5'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 8, charge: 120),
                              SerieConfig(repetitions: 6, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Extension Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 8, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,"s2.png", 5, "Legs 1 Quadriceps",true),
                  ),

                  TextComponent(text: "Semaine 6",fontWeight: FontWeight.bold,color: mainColor,size: 14,),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance1'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Incliné",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 120),
                              SerieConfig(repetitions: 8, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Développé Militaire Assis",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 20, charge: 30),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,"s1.png", 1, "Push 2 Haut des Pectoraux + Deltoides",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance2'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Pull Over",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Prise Large",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 12, charge: 100),
                              SerieConfig(repetitions: 10, charge: 110),
                              SerieConfig(repetitions: 8, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Face Pull au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,"s2.png", 2, "Pull 2 Largeur du Dos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance3'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Rebonds",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 6, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulevé de terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 6, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Hip Thrust",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 12, charge: 240),
                              SerieConfig(repetitions: 12, charge: 240),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 100, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,"s3.png", 3, "Leg 2 Ischios & Fessiers",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance4'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Debout à la Poulie",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 140),
                              SerieConfig(repetitions: 8, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
                          ),
                          Exercice(
                            titre: "OVERHEAD PRESS",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,"s1.png", 4, "Push 1 Pectoraux et Deltoides Lateraux",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance5'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 8, charge: 120),
                              SerieConfig(repetitions: 6, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Extension Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 8, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,"s2.png", 5, "Legs 1 Quadriceps",true),
                  ),

                  TextComponent(text: "Semaine 7",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance1'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Debout à la Poulie",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 140),
                              SerieConfig(repetitions: 8, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
                          ),
                          Exercice(
                            titre: "OVERHEAD PRESS",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,"s1.png", 1, "Push 1 Pectoraux et Deltoides Lateraux",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance2'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 6, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Oiseau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,"s2.png", 2, "PULL 1 Epaisseur Du Dos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance3'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 8, charge: 120),
                              SerieConfig(repetitions: 6, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Extension Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 8, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,"s3.png", 3, "Legs 1 Quadriceps",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance4'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Incliné",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 120),
                              SerieConfig(repetitions: 8, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Développé Militaire Assis",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevations Laterales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 20, charge: 30),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,"s1.png", 4, "Push 2 Haut des Pectoraux + Deltoides",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance5'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Pull Over",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Prise Large",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 12, charge: 100),
                              SerieConfig(repetitions: 10, charge: 110),
                              SerieConfig(repetitions: 8, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Face Pull au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,"s2.png", 5, "Pull 2 Largeur du Dos",true),
                  ),

                  TextComponent(text: "Semaine 8",fontWeight: FontWeight.bold,color: mainColor,size: 14,),

                  // Séance 1 : Push 1 Pectoraux et deltoides Lateraux
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance1'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Debout à la Poulie",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 140),
                              SerieConfig(repetitions: 8, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Overhead Press",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Élévations Latérales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Écarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,"s1.png", 1, "Push 1 Pectoraux et deltoides",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance2'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 6, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Unilatéral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Oiseau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,"s2.png", 2, "Pull 1 Epaisseur Du Dos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance3'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 8, charge: 120),
                              SerieConfig(repetitions: 6, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Extension Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 8, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,"s3.png", 3, "Legs 1 Quadriceps",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance4'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Rebonds",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 6, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulevé de terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 6, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Hip Thrust",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 12, charge: 240),
                              SerieConfig(repetitions: 12, charge: 240),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 100, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,"s2.png", 5, "Leg 2 Ischios & Fessiers",true),
                  ),

                  TextComponent(text: "Semaine 9",fontWeight: FontWeight.bold,color: mainColor,size: 14,),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine9_seance1'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Debout à la Poulie",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 140),
                              SerieConfig(repetitions: 8, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Overhead Press",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Élévations Latérales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Écarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,"s1.png", 1, "Push 1 Pectoraux et deltoides",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine9_seance2'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 6, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Unilatéral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Oiseau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,"s2.png", 2, "Pull 1 Epaisseur Du Dos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine9_seance3'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 8, charge: 120),
                              SerieConfig(repetitions: 6, charge: 160),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Extension Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 8, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,"s3.png", 3, "Legs 1 Quadriceps",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine9_seance4'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Développé Incliné",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 12, charge: 120),
                              SerieConfig(repetitions: 10, charge: 120),
                              SerieConfig(repetitions: 8, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Développé Militaire Assis",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Élévations Latérales",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                              SerieConfig(repetitions: 20, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Écarté Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 20, charge: 30),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,"s1.png", 4, "Push 2 Haut des Pectoraux",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine9_seance5'),
                        path: widget.path, pg : "powerband_pgpower",
                        exercice: [
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 20, charge: 80),
                              SerieConfig(repetitions: 15, charge: 100),
                              SerieConfig(repetitions: 10, charge: 140),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Rebonds",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 6, charge: 120),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulevé de terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 6, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Hip Thrust",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 15, charge: 200),
                              SerieConfig(repetitions: 12, charge: 240),
                              SerieConfig(repetitions: 12, charge: 240),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension Mollet Unilatéral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 100, charge: 0),
                            ],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,"s2.png", 5, "Leg 2 Ischios & Fessiers",true),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget Box(int semaine,String img, int seance, titre, bool isLocked){
    if(!widget.isFromAccueil){
      isLocked = false;
    }
    return Card(
      color: Colors.white,
      child: Container(
        height: 80,
        width: Screen.width(context),
        padding: EdgeInsets.all(10),
        child: Row(
          spacing: 20,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage("assets/images/$img"),fit: BoxFit.cover)
              ),
            ),
            Expanded(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 3,
                children: [
                  TextComponent(text: "Séance $seance",fontWeight: FontWeight.bold,),
                  TextComponent(text: titre,textAlign: TextAlign.start,)
                ],
              ),
            ),
            Icon(_isSessionCompleted('semaine${semaine}_seance$seance') ? Icons.check_circle : isLocked ? Icons.lock : Icons.check_circle_outline, color: mainColor, size: 35),
          ],
        ),
      ),
    );
  }
}
