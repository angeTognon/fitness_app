import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExoFromProgramme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/components/text_components.dart';
import '../../modules/monCompte/controller/controller.dart';
import '../../utils/colors.dart';
import '../LectureVideoExo/lectureVideosExo.dart';

class ProgrammeMix extends StatefulWidget {
  String path;
  bool isFromAccueil;

  ProgrammeMix({required this.path,required this.isFromAccueil});

  @override
  State<ProgrammeMix> createState() => _ProgrammeMixState();
}

class _ProgrammeMixState extends State<ProgrammeMix> {
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
    Set<String> completedSessions = _prefs.getStringList('completedSessions_pgmix_powerband')?.toSet() ?? {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList('completedSessions_pgmix_powerband', _completedSessions.toList());
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
              height: Screen.height(context) /2,
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
                                Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: 10,
                                  children: [
                                    Container(
                                        width: Screen.width(context) / 1.3,
                                        child: TextComponent(textAlign: TextAlign.start,text: "Douleurs lombaires",fontWeight: FontWeight.bold,color: Colors.white,)),

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
                                              // Icon(Icons.flag_circle_rounded,color: mainColor,size: 35,),
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
                                              // Icon(Icons.flag_circle_rounded,color: mainColor,size: 35,),
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
                                              // Icon(Icons.flag_circle_rounded,color: mainColor,size: 35,),
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
                children:[
                  TextComponent(text: "Semaine 1",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance1'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          // Étirement (toujours en premier)
                          Exercice(
                            titre: "Etirement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=vbvgHjop6jk&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal Poulie Basse",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=RsRCd41HbxA&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Oiseau Inversé",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=JOy9m45wpK8&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=5&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s1.png", 1, "Séance 1",false),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance2'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          // Étirement
                          Exercice(
                            titre: "Etirement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=RWdInNhpZP4&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pull Over",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Vertical",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9I-Gt0N9Ung&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s2.png", 2, "Séance 2",false),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance3'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          // Étirement
                          Exercice(
                            titre: "Etirement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "Mini Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 5)],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=9j3o18I--qM&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "GoodMorning",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 5)],
                            repos: 30,
                            linkVideo: "https://www.youtube.com/watch?v=mDSH9w4cRdQ&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Pulltrough",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 5)],
                            repos: 20,
                            linkVideo: "https://www.youtube.com/watch?v=ROzo6d6LTJc&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,"s3.png", 3, "Séance 3",false),
                  ),
                  TextComponent(text: "Semaine 2",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance1'),
                            path: widget.path, pg : "powerband_pgmix",
                            exercice: [
                              Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                              Exercice(titre: "Squat Sumo", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=RWdInNhpZP4&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=11&pp=iAQB"),
                              Exercice(titre: "Pull Over", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB"),
                              Exercice(titre: "Oiseau Inversé", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 45, linkVideo: "https://www.youtube.com/watch?v=JOy9m45wpK8&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=5&pp=iAQB"),
                            ],
                          )));
                        },
                        child: Box(2,"s1.png", 1, "Séance 1",true),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance2'),
                            path: widget.path, pg : "powerband_pgmix",
                            exercice: [
                              Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                              Exercice(titre: "Squat", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=vbvgHjop6jk&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=9&pp=iAQB"),
                              Exercice(titre: "Tirage Vertical", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=9I-Gt0N9Ung&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=4&pp=iAQB"),
                              Exercice(titre: "GoodMorning", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=mDSH9w4cRdQ&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=8&pp=iAQB0gcJCYQJAYcqIYzv"),
                            ],
                          )));
                        },
                        child: Box(2,"s2.png", 2, "Séance 2",true),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance3'),
                            path: widget.path, pg : "powerband_pgmix",
                            exercice: [
                              Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                              Exercice(titre: "Mini Squat", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=9j3o18I--qM&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=10&pp=iAQB"),
                              Exercice(titre: "Tirage Horizontal Poulie Basse", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=RsRCd41HbxA&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=14&pp=iAQB"),
                              Exercice(titre: "Pulltrough", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 20, linkVideo: "https://www.youtube.com/watch?v=ROzo6d6LTJc&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=13&pp=iAQB"),
                            ],
                          )));
                        },
                        child: Box(2,"s3.png", 3, "Séance 3",true),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 3",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance1'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Squat Sumo", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=RWdInNhpZP4&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=11&pp=iAQB"),
                          Exercice(titre: "Pull Over", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB"),
                          Exercice(titre: "Tirage Vertical", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=9I-Gt0N9Ung&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=4&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(3,"s1.png", 1, "Séance 1",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance2'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Mini Squat", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=9j3o18I--qM&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=10&pp=iAQB"),
                          Exercice(titre: "GoodMorning", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=mDSH9w4cRdQ&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=8&pp=iAQB0gcJCYQJAYcqIYzv"),
                          Exercice(titre: "Tirage Horizontal Poulie Basse", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=RsRCd41HbxA&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=14&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(3,"s2.png", 2, "Séance 2",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance3'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Squat", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=vbvgHjop6jk&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=9&pp=iAQB"),
                          Exercice(titre: "Oiseau Inversé", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 45, linkVideo: "https://www.youtube.com/watch?v=JOy9m45wpK8&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=5&pp=iAQB"),
                          Exercice(titre: "Pulltrough", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 20, linkVideo: "https://www.youtube.com/watch?v=ROzo6d6LTJc&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=13&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(3,"s3.png", 3, "Séance 3",true),
                  ),

                  TextComponent(text: "Semaine 4",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance1'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=vbvgHjop6jk&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=9&pp=iAQB",
                          ),
                          Exercice(titre: "Pull Over", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB"),
                          Exercice(titre: "Tirage Vertical", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=9I-Gt0N9Ung&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=4&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(4,"s1.png", 1, "Séance 1",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance2'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Squat Sumo", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=RWdInNhpZP4&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=11&pp=iAQB"),
                          Exercice(titre: "Tirage Horizontal Poulie Basse", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=RsRCd41HbxA&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=14&pp=iAQB"),
                          Exercice(titre: "GoodMorning", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=mDSH9w4cRdQ&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=8&pp=iAQB0gcJCYQJAYcqIYzv"),
                        ],
                      )));
                    },
                    child: Box(4,"s2.png", 2, "Séance 2",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance3'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Mini Squat", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=9j3o18I--qM&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=10&pp=iAQB"),
                          Exercice(titre: "Oiseau Inversé", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 45, linkVideo: "https://www.youtube.com/watch?v=JOy9m45wpK8&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=5&pp=iAQB"),
                          Exercice(titre: "Pulltrough", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 20, linkVideo: "https://www.youtube.com/watch?v=ROzo6d6LTJc&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=13&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(4,"s3.png", 3, "Séance 3",true),
                  ),

                  TextComponent(text: "Semaine 5",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance1'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Tirage Horizontal Poulie Basse", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=RsRCd41HbxA&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=14&pp=iAQB"),
                          Exercice(titre: "Squat Sumo", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=RWdInNhpZP4&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=11&pp=iAQB"),
                          Exercice(titre: "Pull Over", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(5,"s1.png", 1, "Séance 1",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance2'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Squat", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=vbvgHjop6jk&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=9&pp=iAQB"),
                          Exercice(titre: "Oiseau Inversé", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 45, linkVideo: "https://www.youtube.com/watch?v=JOy9m45wpK8&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=5&pp=iAQB"),
                          Exercice(titre: "Tirage Vertical", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=9I-Gt0N9Ung&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=4&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(5,"s2.png", 2, "Séance 2",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance3'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Mini Squat", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=9j3o18I--qM&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=10&pp=iAQB"),
                          Exercice(titre: "GoodMorning", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=mDSH9w4cRdQ&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=8&pp=iAQB0gcJCYQJAYcqIYzv"),
                          Exercice(titre: "Pulltrough", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 20, linkVideo: "https://www.youtube.com/watch?v=ROzo6d6LTJc&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=13&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(5,"s3.png", 3, "Séance 3",true),
                  ),

                  TextComponent(text: "Semaine 6",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance1'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 6),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=vbvgHjop6jk&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=9&pp=iAQB",
                          ),
                          Exercice(titre: "Pull Over", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB"),
                          Exercice(titre: "Tirage Vertical", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=9I-Gt0N9Ung&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=4&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(6,"s1.png", 1, "Séance 1",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance2'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Squat Sumo", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=RWdInNhpZP4&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=11&pp=iAQB"),
                          Exercice(titre: "Tirage Horizontal Poulie Basse", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=RsRCd41HbxA&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=14&pp=iAQB"),
                          Exercice(titre: "Oiseau Inversé", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 45, linkVideo: "https://www.youtube.com/watch?v=JOy9m45wpK8&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=5&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(6,"s2.png", 2, "Séance 2",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance3'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Mini Squat", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=9j3o18I--qM&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=10&pp=iAQB"),
                          Exercice(titre: "GoodMorning", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=mDSH9w4cRdQ&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=8&pp=iAQB0gcJCYQJAYcqIYzv"),
                          Exercice(titre: "Pulltrough", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 20, linkVideo: "https://www.youtube.com/watch?v=ROzo6d6LTJc&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=13&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(6,"s3.png", 3, "Séance 3",true),
                  ),

                  TextComponent(text: "Semaine 7",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance1'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=RWdInNhpZP4&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=11&pp=iAQB",
                          ),
                          Exercice(titre: "Pull Over", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB"),
                          Exercice(titre: "Tirage Vertical", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=9I-Gt0N9Ung&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=4&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(7,"s1.png", 1, "Séance 1",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance2'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Tirage Horizontal Poulie Basse", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 20)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=RsRCd41HbxA&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=14&pp=iAQB"),
                          Exercice(titre: "Oiseau Inversé", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 45, linkVideo: "https://www.youtube.com/watch?v=JOy9m45wpK8&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=5&pp=iAQB"),
                          Exercice(titre: "GoodMorning", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=mDSH9w4cRdQ&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=8&pp=iAQB0gcJCYQJAYcqIYzv"),
                        ],
                      )));
                    },
                    child: Box(7,"s2.png", 2, "Séance 2",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance3'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "Squat", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=vbvgHjop6jk&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=9&pp=iAQB"),
                          Exercice(titre: "Mini Squat", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=9j3o18I--qM&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=10&pp=iAQB"),
                          Exercice(titre: "Pulltrough", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 20, linkVideo: "https://www.youtube.com/watch?v=ROzo6d6LTJc&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=13&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(7,"s3.png", 3, "Séance 3",true),
                  ),

                  TextComponent(text: "Semaine 8",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance1'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(
                            titre: "Squat",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 6),
                              SerieConfig(repetitions: 6),
                              SerieConfig(repetitions: 5),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=vbvgHjop6jk&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=9&pp=iAQB",
                          ),
                          Exercice(titre: "Tirage Horizontal Poulie Basse", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (i) => SerieConfig(repetitions: i < 2 ? 20 : 15)), repos: 75, linkVideo: "https://www.youtube.com/watch?v=RsRCd41HbxA&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=14&pp=iAQB"),
                          Exercice(titre: "Pull Over", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (i) => SerieConfig(repetitions: i < 3 ? 20 : 15)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(8,"s1.png", 1, "Séance 1",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance2'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 6),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=RWdInNhpZP4&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=11&pp=iAQB",
                          ),
                          Exercice(titre: "Tirage Vertical", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (i) => SerieConfig(repetitions: i < 3 ? 20 : 15)), repos: 75, linkVideo: "https://www.youtube.com/watch?v=9I-Gt0N9Ung&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=4&pp=iAQB"),
                          Exercice(titre: "Oiseau Inversé", nombreTotalSerie: 5, seriesConfigs: List.generate(5, (_) => SerieConfig(repetitions: 15)), repos: 60, linkVideo: "https://www.youtube.com/watch?v=JOy9m45wpK8&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=5&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(8,"s2.png", 2, "Séance 2",true),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance3'),
                        path: widget.path, pg : "powerband_pgmix",
                        exercice: [
                          Exercice(titre: "Etirement", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 1)], repos: 0, linkVideo: "https://www.youtube.com/watch?v=CvKWQHpkMko&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=6&pp=iAQB"),
                          Exercice(titre: "GoodMorning", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 45, linkVideo: "https://www.youtube.com/watch?v=mDSH9w4cRdQ&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=8&pp=iAQB0gcJCYQJAYcqIYzv"),
                          Exercice(titre: "Mini Squat", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 45, linkVideo: "https://www.youtube.com/watch?v=9j3o18I--qM&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=10&pp=iAQB"),
                          Exercice(titre: "Pulltrough", nombreTotalSerie: 1, seriesConfigs: [SerieConfig(repetitions: 5)], repos: 30, linkVideo: "https://www.youtube.com/watch?v=ROzo6d6LTJc&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=13&pp=iAQB"),
                        ],
                      )));
                    },
                    child: Box(8,"s3.png", 3, "Séance Finale", true),
                  ),
                ]
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
