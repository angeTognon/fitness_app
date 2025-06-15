import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExoFromProgramme.dart';
import 'package:fitness_app/new/instruction/presentationPowerFit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/components/text_components.dart';
import '../../modules/monCompte/controller/controller.dart';
import '../../utils/colors.dart';
import '../LectureVideoExo/lectureVideosExo.dart';
import '../instruction/presentationPowerBand.dart';

class ProgrammePower extends StatefulWidget {
  String path;
  bool isFromAccueil;

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
    Set<String> completedSessions = _prefs.getStringList('completedSessions_pgpower_powerfit')?.toSet() ?? {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList('completedSessions_pgpower_powerfit', _completedSessions.toList());
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
                                              TextComponent(text: "12 semaines", color: Colors.white.withOpacity(0.7))
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
                children:[

                  TextComponent(text: "Contenu",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap : (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InstructionPowerFit(producName: "Power", path: "newPowerbands.jpg")));
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

                  // SEM 1 - SÉANCE 1
                  TextComponent(text: "Semaine 1", fontWeight: FontWeight.bold, color: mainColor, size: 14),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: ()=> () => _markSessionAsCompleted('semaine1_seance1'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),

                          // Exercice 1
                          Exercice(
                            titre: "Triceps Tirage Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
                          ),

                          // Exercice 2
                          Exercice(
                            titre: "Biceps Tirage Horizontal Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=eSHgAWBCCjI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=24&pp=iAQB",
                          ),

                          // Exercice 3
                          Exercice(
                            titre: "Tirage Horizontal Unilateral Assis",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
                          ),

                          // Exercice 4
                          Exercice(
                            titre: "Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s1.png", 1, "Upper Body"),
                  ),

                  // SEM 1 - SÉANCE 2
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: ()=> () => _markSessionAsCompleted('semaine1_seance2'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "Triceps Tirage Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Unilateral Assis",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
                          ),
                          Exercice(
                            titre: "Biceps Tirage Horizontal Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=eSHgAWBCCjI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=24&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s2.png", 2, "Biceps tirage vertical"),
                  ),

// SEM 1 - SÉANCE 3
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: ()=> () => _markSessionAsCompleted('semaine1_seance3'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps Tirage Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Tirage Horizontal Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=eSHgAWBCCjI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Unilateral Assis",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
                          ),
                          Exercice(
                            titre: "Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s3.png", 3, "Triceps Tirage"),
                  ),

// SEM 1 - SÉANCE 4
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: ()=> () => _markSessionAsCompleted('semaine1_seance4'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "Triceps Tirage Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Unilateral Assis",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
                          ),
                          Exercice(
                            titre: "Biceps Tirage Horizintal Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=eSHgAWBCCjI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=24&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s1.png", 4, "Biceps Prise Pronation"),
                  ),

                  // SEMAINE 2
                  TextComponent(text: "Semaine 2", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=>_markSessionAsCompleted('semaine2_seance1'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curls Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Rowing",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=vkQJadKk4VI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Renforcement des ischios",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                          Exercice(
                            titre: "Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,true,"s1.png", 1, "Biceps Marteau"),
                  ),

// SÉANCE 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerfit_pgpower",
                        onComplete: ()=> _markSessionAsCompleted('semaine2_seance2'),

                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curls Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                          Exercice(
                            titre: "Biceps Curls Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Renforcement des ischios",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                          Exercice(
                            titre: "Rowing",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=vkQJadKk4VI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=29&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,true,"s2.png", 2, "Biceps Unilateral"),
                  ),

// SÉANCE 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerfit_pgpower",
                        onComplete: ()=> _markSessionAsCompleted('semaine2_seance3'),
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curls Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Rowing",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=vkQJadKk4VI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Renforcement des ischios",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                          Exercice(
                            titre: "Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,true,"s3.png", 3, "Biceps Marteau"),
                  ),

// SÉANCE 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerfit_pgpower",
                        onComplete: ()=> _markSessionAsCompleted('semaine2_seance4'),
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps Curls Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                          Exercice(
                            titre: "Biceps Curls Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Renforcement des ischios",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                          Exercice(
                            titre: "Rowing",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=vkQJadKk4VI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=29&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,true,"s1.png", 4, "Biceps Unilateral"),
                  ),

                  // SEMAINE 3
                  TextComponent(text: "Semaine 3", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// SÉANCE 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerfit_pgpower",
                        onComplete: ()=> _markSessionAsCompleted('semaine3_seance1'),
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM-L Exercice Tirage Vertical Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=j-iIsz5S8K4&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,true,"s1.png", 1, "Développer Militaire Arrière"),
                  ),

// SÉANCE 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine3_seance2'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                          Exercice(
                            titre: "HM-L Exercice Tirage Vertical Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=j-iIsz5S8K4&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,true,"s2.png", 2, "Triceps Tirage Nuque Unilateral"),
                  ),

// SÉANCE 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine3_seance3'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM-L Exercice Tirage Vertical Poulie Haute",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=j-iIsz5S8K4&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,true,"s3.png", 3, "Développer Militaire Arrière"),
                  ),

// SÉANCE 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine3_seance4'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                          Exercice(
                            titre: "HM-L Exercice Tirage Vertical Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=j-iIsz5S8K4&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,true,"s1.png", 4, "Triceps Tirage Nuque Unilateral"),
                  ),

                  // SEMAINE 4
                  TextComponent(text: "Semaine 4", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// SÉANCE 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine4_seance1'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Fentes Arriere",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Tirage Unilateral Poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=dQrV1R1N-cE&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM -C-Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/Gbjng5YUOAY",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,true,"s1.png", 1, "Fentes Arriere"),
                  ),

// SÉANCE 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine4_seance2'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Fentes Arriere",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM -C-Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/Gbjng5YUOAY",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Tirage Unilateral Poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=dQrV1R1N-cE&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,true,"s2.png", 2, "Biceps tirage vertical Prise Pronation"),
                  ),

// SÉANCE 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerfit_pgpower",
                        onComplete: ()=> _markSessionAsCompleted('semaine4_seance3'),
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Fentes Arriere",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Tirage Unilateral Poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=dQrV1R1N-cE&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM -C-Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/Gbjng5YUOAY",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,true,"s3.png", 3, "Fentes Arriere"),
                  ),

// SÉANCE 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine4_seance4'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Fentes Arriere",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM -C-Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/Gbjng5YUOAY",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Tirage Unilateral Poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=dQrV1R1N-cE&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,true,"s1.png", 4, "Biceps tirage vertical Prise Pronation"),
                  ),


                  // SEMAINE 5
                  TextComponent(text: "Semaine 5", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// SÉANCE 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine5_seance1'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Squat Sumo",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=WT76YmmXjvg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Triceps Tirage Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Tirage Unilatéral Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/X4d6ibnRgW0",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontal Unilateral Assis",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,true,"s1.png", 1, "Squat Sumo"),
                  ),

// SÉANCE 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine5_seance2'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontal Unilateral Assis",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Squat Sumo",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=WT76YmmXjvg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Tirage Unilatéral Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/X4d6ibnRgW0",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Triceps Tirage Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,true,"s2.png", 2, "Tirage Horizontal Unilateral Assis"),
                  ),

// SÉANCE 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine5_seance3'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Squat Sumo",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=WT76YmmXjvg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Triceps Tirage Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Tirage Unilatéral Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/X4d6ibnRgW0",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontal Unilateral Assis",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,true,"s3.png", 3, "Squat Sumo"),
                  ),

// SÉANCE 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine5_seance4'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontal Unilateral Assis",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Squat Sumo",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=WT76YmmXjvg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Tirage Unilatéral Poulie Haute",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/X4d6ibnRgW0",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Triceps Tirage Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,true,"s1.png", 4, "Tirage Horizontal Unilateral Assis"),
                  ),

                  // SEMAINE 6
                  TextComponent(text: "Semaine 6", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// SÉANCE 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine6_seance1'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM -L- Exercice Biceps Curls Poulie Basse Tirage Vertical",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=feqR6E9eUfY&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Biceps Curls Pronation",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=C7J4RIXxR7o&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Vertical Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/T7Wd17_Sr_8",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage sur les adducteurs",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/V3KoSgDUYRM",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,true,"s1.png", 1, "Biceps Curls Poulie Basse Tirage Vertical"),
                  ),

// SÉANCE 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine6_seance2'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage sur les adducteurs",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/V3KoSgDUYRM",
                          ),
                          Exercice(
                            titre: "HM -L- Exercice Biceps Curls Poulie Basse Tirage Vertical",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=feqR6E9eUfY&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Vertical Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/T7Wd17_Sr_8",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Biceps Curls Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=C7J4RIXxR7o&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=26&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,true,"s2.png", 2, "Tirage sur les adducteurs"),
                  ),

// SÉANCE 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine6_seance3'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM -L- Exercice Biceps Curls Poulie Basse Tirage Vertical",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=feqR6E9eUfY&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Biceps Curls Pronation",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=C7J4RIXxR7o&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Vertical Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/T7Wd17_Sr_8",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage sur les adducteurs",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/V3KoSgDUYRM",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,true,"s3.png", 3, "Biceps Curls Poulie Basse Tirage Vertical"),
                  ),

// SÉANCE 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: ()=> _markSessionAsCompleted('semaine6_seance4'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage sur les adducteurs",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/V3KoSgDUYRM",
                          ),
                          Exercice(
                            titre: "HM -L- Exercice Biceps Curls Poulie Basse Tirage Vertical",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=feqR6E9eUfY&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Vertical Unilatéral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/T7Wd17_Sr_8",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Biceps Curls Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=C7J4RIXxR7o&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=26&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,true,"s1.png", 4, "Tirage sur les adducteurs"),
                  ),

                  // SEMAINE 8
                  TextComponent(text: "Semaine 8", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// SÉANCE 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine8_seance1'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Biceps Curls Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Dos Tirage Vertical Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/WOGlNg2Pyvs",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s1.png", 1, "Développer Militaire Arrière"),
                  ),

// SÉANCE 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine8_seance2'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Dos Tirage Vertical Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/WOGlNg2Pyvs",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Biceps Curls Prise Marteau",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s2.png", 2, "Dos Tirage Vertical Unilateral"),
                  ),

// SÉANCE 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine8_seance3'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Biceps Curls Prise Marteau",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Dos Tirage Vertical Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/WOGlNg2Pyvs",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s3.png", 3, "Développer Militaire Arrière"),
                  ),

// SÉANCE 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine8_seance4'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Dos Tirage Vertical Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/WOGlNg2Pyvs",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Biceps Curls Prise Marteau",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s1.png", 4, "Dos Tirage Vertical Unilateral"),
                  ),

                  // SEMAINE 9
                  TextComponent(text: "Semaine 9", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// SÉANCE 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine9_seance1'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Tirage Vertical a la poulie",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=HMAG7U5fKLM&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=0dms1paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Oiseaux",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/GI_U5Fu53dc",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontale Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s1.png", 1, "Tirage Vertical a la poulie"),
                  ),

// SÉANCE 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine9_seance2'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontale Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Tirage Vertical a la poulie",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=HMAG7U5fKLM&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Oiseaux",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/GI_U5Fu53dc",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=0dms1paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s2.png", 2, "Tirage Horizontale Frontal"),
                  ),

// SÉANCE 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine9_seance3'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Tirage Vertical a la poulie",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=HMAG7U5fKLM&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=0dms1paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Oiseaux",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/GI_U5Fu53dc",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontale Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s3.png", 3, "Tirage Vertical a la poulie"),
                  ),

// SÉANCE 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine9_seance4'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontale Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Tirage Vertical a la poulie",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=HMAG7U5fKLM&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Oiseaux",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/GI_U5Fu53dc",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=0dms1paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s1.png", 4, "Tirage Horizontale Frontal"),
                  ),


                  // SEMAINE 10
                  TextComponent(text: "Semaine 10", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// SÉANCE 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine10_seance1'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Trapeze Tirage Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Elévation Latérale",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Renforcement des ischios",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s1.png", 1, "Trapeze Tirage Frontal"),
                  ),

// SÉANCE 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine10_seance2'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Renforcement des ischios",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Trapeze Tirage Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Elévation Latérale",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s2.png", 2, "Renforcement des ischios"),
                  ),

// SÉANCE 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine10_seance3'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Trapeze Tirage Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Elévation Latérale",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Renforcement des ischios",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s3.png", 3, "Trapeze Tirage Frontal"),
                  ),

// SÉANCE 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine10_seance4'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Renforcement des ischios",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Trapeze Tirage Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Elévation Latérale",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s1.png", 4, "Renforcement des ischios"),
                  ),
// SEMAINE 10
                  TextComponent(text: "Semaine 11", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// SÉANCE 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine11_seance1'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Trapeze Tirage Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Elévation Latérale",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Renforcement des ischios",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s1.png", 1, "Trapeze Tirage Frontal"),
                  ),

// SÉANCE 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine11_seance2'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Renforcement des ischios",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Trapeze Tirage Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Elévation Latérale",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s2.png", 2, "Renforcement des ischios"),
                  ),

// SÉANCE 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine11_seance3'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Trapeze Tirage Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Elévation Latérale",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Renforcement des ischios",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s3.png", 3, "Trapeze Tirage Frontal"),
                  ),

// SÉANCE 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine11_seance4'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Renforcement des ischios",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Trapeze Tirage Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Elévation Latérale",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s1.png", 4, "Renforcement des ischios"),
                  ),

                  // SEMAINE 11
                  TextComponent(text: "Semaine 11", fontWeight: FontWeight.bold, color: mainColor, size: 14),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine12_seance1'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Fentes Arriere",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontale Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s1.png", 1, "Biceps Tirage Vertical Poulie Basse"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine12_seance2'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                          Exercice(
                            titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontale Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Fentes Arriere",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s2.png", 2, "Biceps Curls Unilateral"),
                  ),

// SÉANCE 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine12_seance3'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Fentes Arriere",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontale Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s3.png", 3, "Biceps Tirage Vertical Poulie Basse"),
                  ),

// SÉANCE 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine12_seance4'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps Curls Unilateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),
                          Exercice(
                            titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Horizontale Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Fentes Arriere",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s1.png", 4, "Biceps Curls Unilateral"),
                  ),


                  // SEMAINE 12
                  TextComponent(text: "Semaine 12", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// SÉANCE 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine13_seance1'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=0dms1paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Vertical Deltoides Posterieur",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/HlH9r3INnGE",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s1.png", 1, "Développer Militaire"),
                  ),

// SÉANCE 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine13_seance2'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Vertical Deltoides Posterieur",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/HlH9r3INnGE",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=0dms1paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s2.png", 2, "Tirage Vertical Deltoides Posterieur"),
                  ),

// SÉANCE 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine13_seance3'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=0dms1paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Vertical Deltoides Posterieur",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/HlH9r3INnGE",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s3.png", 3, "Développer Militaire"),
                  ),

// SÉANCE 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram( onComplete: ()=> _markSessionAsCompleted('semaine13_seance4'),
                        path: widget.path, pg : "powerfit_pgpower",
                        exercice: [
                          Exercice(
                            titre: "HM Exercice Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Tirage Vertical Deltoides Posterieur",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/HlH9r3INnGE",
                          ),
                          Exercice(
                            titre: "HM-L- Exercice Développer Militaire",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=0dms1paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
                          ),
                          Exercice(
                            titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s1.png", 4, "Tirage Vertical Deltoides Posterieur"),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget Box(int semaine, bool isLocked, String img, int seance, titre){
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
