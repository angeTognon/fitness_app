import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExoFromProgramme.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosInstruction.dart' show Lecturevideosinstruction;
import 'package:fitness_app/new/instruction/presentationPowerBand.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/components/text_components.dart';
import '../../modules/monCompte/controller/controller.dart';
import '../../utils/colors.dart';
import '../LectureVideoExo/lectureVideosExo.dart';

class ProgrammeBBL extends StatefulWidget {
  String path;
  bool isFromAccueil;

  ProgrammeBBL({required this.path,required this.isFromAccueil});

  @override
  State<ProgrammeBBL> createState() => _ProgrammeBBLState();
}

class _ProgrammeBBLState extends State<ProgrammeBBL> {


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
    Set<String> completedSessions = _prefs.getStringList('completedSessions_pgbbl_powerband')?.toSet() ?? {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList('completedSessions_pgbbl_powerband', _completedSessions.toList());
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
                            mainAxisAlignment: MainAxisAlignment.start,
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
                            height: 160,
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
                                Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: 10,
                                  children: [
                                    Container(
                                        width: Screen.width(context) / 1.3,
                                        child: TextComponent(textAlign: TextAlign.start,text: "BBL",fontWeight: FontWeight.bold,color: Colors.white,)),

                                    Container(
                                      width: Screen.width(context) / 1.2,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center,spacing: 20,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 60,width: 60,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(image: AssetImage("assets/images/objectifs.png"))
                                                ),
                                              ),
                                              TextComponent(text: "Objectifs",color: Colors.white70,fontWeight: FontWeight.bold,),
                                              TextComponent(text: "Perte de poids",color: Colors.white.withOpacity(0.7),)
                                            ],
                                          ),Column(
                                            children: [
                                              Container(
                                                height: 60,width: 60,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: AssetImage("assets/images/level.png"))
                                                 ),
                                              ),
                                              TextComponent(text: "Niveau",color: Colors.white70,fontWeight: FontWeight.bold,),
                                              TextComponent(text: "Debutant",color: Colors.white.withOpacity(0.7),)
                                            ],
                                          ),Column(
                                            children: [
                                              Container(
                                                height: 60,width: 60,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: AssetImage("assets/images/duree.png"))
                                                ),
                                              ),
                                              TextComponent(text: "Durée",color: Colors.white70,fontWeight: FontWeight.bold,),
                                              TextComponent(text: "5*Par sem",color: Colors.white.withOpacity(0.7),)
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InstructionPowerBand(producName: "Vidéos d'instruction du BBL", path: "power1.png")));
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
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Soulevé de terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kick",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Abduction",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s1.png", 1, "Jambes et Fessier",false),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance2'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Développé Militaire",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Élévations Latérales",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curls",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=zS1MBnRvSzk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=15&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl Prise Marteau",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 12, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tL0ihj9VtlM&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Kickback Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 12, charge: 10),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=fm2dGhQLGYY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=10&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s2.png", 2, "Bras, Epaules",false),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance3'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Crunch Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=DOLLrr_OaDU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=28&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Crunch Rameur",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=p7etPEUabZI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=27&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Mountain Climber",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=RJImXD9ySYY&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s3.png", 3, "Cardio & Abdos",false),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance4'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 30),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Bulgares",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 20),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=XRe0TP4y6A4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YA8Mg099KMQ&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s1.png", 4, "Ischio & Fessiers",false),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance5'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Pompes",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 0),
                              SerieConfig(repetitions: 10, charge: 0),
                              SerieConfig(repetitions: 10, charge: 0),
                              SerieConfig(repetitions: 10, charge: 0),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=6b6RwlYK5-8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Développé Debout à la poulie",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 20),
                              SerieConfig(repetitions: 12, charge: 20),
                              SerieConfig(repetitions: 12, charge: 20),
                              SerieConfig(repetitions: 12, charge: 20),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oWvRMrYblHU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pull Over Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Suh9nmccD5o&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=20&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s2.png", 5, "Dos & Pecs",false),
                  ),

                  TextComponent(text: "Semaine 2",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance1'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Soulevé de terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Abduction",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Adduction",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=T9Cy825h9VU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=8&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,"s1.png", 1, "Focus Quadriceps",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance2'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0, charge: 0),
                              SerieConfig(repetitions: 0, charge: 0),
                              SerieConfig(repetitions: 0, charge: 0),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl Poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=lJZqNu8jJEw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=30&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=zS1MBnRvSzk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=15&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Verticale",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=RbA_omOwd34&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=49&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Face Pull",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=-4RCM-1d8SI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=14&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,"s2.png", 2, "Bras & Epaules",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance3'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Crunch Bicyclette",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 10, charge: 10),
                              SerieConfig(repetitions: 10, charge: 10),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=xKEC4lT4044&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Spider Man",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 0),
                              SerieConfig(repetitions: 12, charge: 10),
                              SerieConfig(repetitions: 12, charge: 10),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=E73ZGk7O_ag&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=5&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Flexion Latérale Oblique",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 20),
                              SerieConfig(repetitions: 12, charge: 20),
                              SerieConfig(repetitions: 12, charge: 20),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=6jlAeMmHico&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=11&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,"s3.png", 3, "Cardio & Abdo",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance4'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YA8Mg099KMQ&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Swing",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sKPpu3KX4fM&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Hip Thrust",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vOQNPzXdZo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Leg Curl",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YjzWXDSyUsI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=5&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,"s1.png", 4, "Ischios & fessiers",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance5'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Pompes",
                            nombreTotalSerie: 2,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=6b6RwlYK5-8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Développé debout à la poulie",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=zAfnnw1-3rc&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Poulie Moyenne",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oWvRMrYblHU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=16&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,"s2.png", 5, "Dos & Pecs",true),
                  ),

                  TextComponent(text: "Semaine 3",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance1'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 2,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Fentes rebonds",
                            nombreTotalSerie: 2,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=hqgaIDAxNyg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Extension",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulevé de terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Abduction",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 10, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,"s1.png", 1, "Jambes",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance2'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Développé Militaire",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Menton",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ER1evvpKjPA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=43&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Élévation Frontale",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 10),
                              SerieConfig(repetitions: 12, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=7KjhhHUtg8k&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Verticale",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=RbA_omOwd34&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=49&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps KickBack Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=fm2dGhQLGYY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=10&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,"s2.png", 2, "Bras & Epaules",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance3'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Leg Raise",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 0),
                              SerieConfig(repetitions: 12, charge: 10),
                              SerieConfig(repetitions: 10, charge: 20),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=b-1IdDUyJho&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Rameur",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 0),
                              SerieConfig(repetitions: 10, charge: 10),
                              SerieConfig(repetitions: 10, charge: 20),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=p7etPEUabZI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=27&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Mountain Climber",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 0),
                              SerieConfig(repetitions: 12, charge: 10),
                              SerieConfig(repetitions: 12, charge: 20),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=RJImXD9ySYY&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1),
                              SerieConfig(repetitions: 1),
                              SerieConfig(repetitions: 1),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=7xEOh4yZJ2Y&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,"s3.png", 3, "Cardio & Abdos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance4'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Bulgares",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=XRe0TP4y6A4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Hip Thrust",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 10, charge: 70),
                              SerieConfig(repetitions: 10, charge: 70),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vOQNPzXdZo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Curl",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YjzWXDSyUsI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=5&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,"s1.png", 4, "Jambes",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance5'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Développé Debout à La Poulie",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 50),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 10, charge: 70),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Développé Joint",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=E8vgLRa-HU0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oWvRMrYblHU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pull Over Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Suh9nmccD5o&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=20&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,"s2.png", 5, "Dos & Pecs",true),
                  ),

                  TextComponent(text: "Semaine 4",fontWeight: FontWeight.bold,color: mainColor,size: 14,),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance1'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Rhythmé",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=HMYUk6zA56Q&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Abduction",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,"s1.png", 1, "Jambes",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance2'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Développé Militaire",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Face Pull",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=-4RCM-1d8SI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Élévations Latérales",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Élévations Frontales",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=7KjhhHUtg8k&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl Poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=lJZqNu8jJEw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=30&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Triceps Barre au Front",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9aMKzSbLBf4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=50&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,"s2.png", 2, "Bras Epaules",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance3'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Crunch Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=DOLLrr_OaDU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=28&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Crunch Rameur",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 10),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=p7etPEUabZI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=27&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Mountain Climber",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 10),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=RJImXD9ySYY&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,"s3.png", 3, "Cardio & Abdos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance4'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YA8Mg099KMQ&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Bulgares",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=XRe0TP4y6A4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Hip Thrust",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 10, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vOQNPzXdZo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Squat Swing",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sKPpu3KX4fM&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kick",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,"s1.png", 4, "Jambes",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance5'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Pompes",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=6b6RwlYK5-8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Développé Debout à la Poulie",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 10, charge: 70),
                              SerieConfig(repetitions: 10, charge: 70),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Développé Incliné",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Poulie Moyenne",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oWvRMrYblHU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=16&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,"s2.png", 5, "Dos & Pecs",true),
                  ),

                  TextComponent(text: "Semaine 5",fontWeight: FontWeight.bold,color: mainColor,size: 14,),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance1'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Soulevé de terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Abduction",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Adduction",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=T9Cy825h9VU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=8&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,"s1.png", 1, "Focus Quadriceps",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance2'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Extension Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=zS1MBnRvSzk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=15&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=VKZBNQCYebM&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=44&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Triceps KickBack Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=fm2dGhQLGYY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=10&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Oiseau",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=PQrxt7RCtQ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Élévations Latérales",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,"s2.png", 2, "Bras & Epaules",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance3'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Crunch Bicyclette",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=xKEC4lT4044&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Spiderman",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=Muit-Ys3q5Y&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=19&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Flexion Latérale Oblique",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=6jlAeMmHico&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=11&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,"s3.png", 3, "Cardio / Abdos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance4'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Squat Rythmé",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=HMYUk6zA56Q&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Rebond",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Curl",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YjzWXDSyUsI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=5&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kicks",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,"s1.png", 4, "Jambes",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance5'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Développé Debout à la Poulie",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 70),
                              SerieConfig(repetitions: 10, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Développé Joint",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=E8vgLRa-HU0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ecarté Unilatéral",
                            nombreTotalSerie: 2,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=zAfnnw1-3rc&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 40),
                              SerieConfig(repetitions: 8, charge: 40),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Poulie Moyenne",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oWvRMrYblHU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pull Over Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Suh9nmccD5o&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=20&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,"s2.png", 5, "Dos & Pecs",true),
                  ),

                  TextComponent(text: "Semaine 6",fontWeight: FontWeight.bold,color: mainColor,size: 14,),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance1'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes",
                            nombreTotalSerie: 9,
                            seriesConfigs: [
                              SerieConfig(repetitions: 2, charge: 50),
                              SerieConfig(repetitions: 4, charge: 50),
                              SerieConfig(repetitions: 6, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 6, charge: 50),
                              SerieConfig(repetitions: 4, charge: 50),
                              SerieConfig(repetitions: 2, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Soulevé de Terre",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Leg Extension",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 70),
                              SerieConfig(repetitions: 10, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Abduction",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,"s1.png", 1, "Jambes",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance2'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Biceps Curl Poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=lJZqNu8jJEw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=30&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Triceps Extension Verticale",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=RbA_omOwd34&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=49&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curl",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Barre au Front",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9aMKzSbLBf4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=50&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Développé Militaire",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Face Pull",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=-4RCM-1d8SI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=14&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,"s2.png", 2, "Bras & Epaules",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance3'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Leg Raise",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 20),
                              SerieConfig(repetitions: 12, charge: 20),
                              SerieConfig(repetitions: 12, charge: 20),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=b-1IdDUyJho&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Rameur",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=p7etPEUabZI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=27&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Mountain Climber",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=RJImXD9ySYY&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1), 
                              SerieConfig(repetitions: 1),
                              SerieConfig(repetitions: 1),
                            ],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=7xEOh4yZJ2Y&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,"s3.png", 3, "Cardio & Abdos",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance4'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Donkey Kick",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fentes Bulgares",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                              SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=XRe0TP4y6A4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Hip Thrust",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vOQNPzXdZo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Squat Swing",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sKPpu3KX4fM&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Donkey Kick",
                            nombreTotalSerie: 2,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,"s1.png", 4, "Jambes",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance5'),
                        path: widget.path, pg : "powerband_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Pompes",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=6b6RwlYK5-8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Développé Debout à la Poulie",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 90),
                              SerieConfig(repetitions: 8, charge: 90),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ecarté Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 10, charge: 60),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=zAfnnw1-3rc&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rowing Buste Penché",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                              SerieConfig(repetitions: 8, charge: 70),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oWvRMrYblHU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pull Over Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Suh9nmccD5o&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=20&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,"s2.png", 5, "Dos & Pecs",true),
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
