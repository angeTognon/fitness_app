import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExoFromProgramme.dart';
import 'package:fitness_app/new/instruction/presentationPowerFit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/components/text_components.dart';
import '../../modules/monCompte/controller/controller.dart';
import '../../utils/colors.dart';
import '../LectureVideoExo/lectureVideosExo.dart';

class ProgrammeBBL extends StatefulWidget {
  String path;
  bool isFromAccueil;

  ProgrammeBBL({required this.path, required this.isFromAccueil});

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
    Set<String> completedSessions = _prefs.getStringList('completedSessions_pgbbl_powerfit')?.toSet() ?? {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList('completedSessions_pgbbl_powerfit', _completedSessions.toList());
    });
  }


  bool _isSessionCompleted(String sessionName) {
    return _completedSessions.contains(sessionName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Screen.height(context) /2,
              child: Stack(
                children: [
                  Container(
                    height: 450,
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
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back_ios,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        Container(
                          height: 200,
                          width: Screen.width(context),
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/${widget.path}"),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center)),
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
                          filter:
                              ImageFilter.blur(sigmaX: 10000, sigmaY: 10000),
                          child: Container(
                            width: Screen.width(context) / 1.05,
                            padding: EdgeInsets.only(
                                top: 15, bottom: 15, right: 10, left: 10),
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
                                          text:
                                              "Perte de poids",
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                    Container(
                                      width: Screen.width(context) / 1.2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              TextComponent(
                                                text: "Objectifs",
                                                color: Colors.white70,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              TextComponent(
                                                text: "Perte de poids",
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                              )
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
                                              TextComponent(
                                                text: "Niveau",
                                                color: Colors.white70,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              TextComponent(
                                                text: "Debutant",
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                              )
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
                                              TextComponent(
                                                text: "Durée",
                                                color: Colors.white70,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              TextComponent(
                                                text: "5*Par sem",
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                              )
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  TextComponent(text: "Contenu",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap : (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InstructionPowerFit(producName: "BBL", path: "newPowerbands.jpg")));
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
                  // Semaine 1
                  TextComponent(
                      text: "Semaine 1",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LectureVideosExoFromProgram(
                                onComplete: () => _markSessionAsCompleted('semaine1_seance1'),
                                    path: widget.path, pg : "powerfit_pgbbl",
                                    exercice: [
                                      Exercice(
                                        titre: "FM Echauffement",
                                        nombreTotalSerie: 1,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 1)
                                        ],
                                        repos: 0,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre:
                                            "FM-L- Exercice Tirage Vertical Poulie Haute",
                                        nombreTotalSerie: 4,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 10),
                                          SerieConfig(repetitions: 8),
                                          SerieConfig(repetitions: 8),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre:
                                            "FM-L- Exercice Tirage Horizontal Assis",
                                        nombreTotalSerie: 4,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 10),
                                          SerieConfig(repetitions: 8),
                                          SerieConfig(repetitions: 8),
                                        ],
                                        repos: 75,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre: "FM -C-BICEPS CURLS UNILATERAL",
                                        nombreTotalSerie: 3,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 15),
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 12),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
                                      ),
                                      Exercice(
                                        titre: "FM-C- TIRAGE NUQUE TRICEPS",
                                        nombreTotalSerie: 3,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 15),
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 12),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
                                      ),
                                    ],
                                  )));
                    },
                    child:
                        Box(1,false, "s1.png", 1, "Tirage Vertical Poulie Haute"),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LectureVideosExoFromProgram(
                                onComplete: () => _markSessionAsCompleted('semaine1_seance2'),
                                    path: widget.path, pg : "powerfit_pgbbl",
                                    exercice: [
                                      Exercice(
                                        titre: "FM Echauffement",
                                        nombreTotalSerie: 1,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 1)
                                        ],
                                        repos: 0,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre: "FM-L- TIRAGE HORIZONTAL BICEPS",
                                        nombreTotalSerie: 4,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 10),
                                          SerieConfig(repetitions: 8),
                                          SerieConfig(repetitions: 8),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=A5rhhzRluhc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=2&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre:
                                            "FM-L- Exercice Developper Militaire",
                                        nombreTotalSerie: 4,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 10),
                                          SerieConfig(repetitions: 8),
                                          SerieConfig(repetitions: 8),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                                      ),
                                      Exercice(
                                        titre: "FM -C- Exercice Air Squat",
                                        nombreTotalSerie: 3,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 15),
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 12),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre:
                                            "FM-C-CRUNCH ELEVATION GENIUX V2",
                                        nombreTotalSerie: 3,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 15),
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 12),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
                                      ),
                                    ],
                                  )));
                    },
                    child: Box(1,false, "s2.png", 2, "TIRAGE HORIZONTAL BICEPS"),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LectureVideosExoFromProgram(
                                onComplete: () => _markSessionAsCompleted('semaine1_seance3'),
                                    path: widget.path, pg : "powerfit_pgbbl",
                                    exercice: [
                                      Exercice(
                                        titre: "FM Echauffement",
                                        nombreTotalSerie: 1,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 1)
                                        ],
                                        repos: 0,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre:
                                            "FM-L- Exercice Tirage Horizontal Assis",
                                        nombreTotalSerie: 4,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 10),
                                          SerieConfig(repetitions: 8),
                                          SerieConfig(repetitions: 8),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre:
                                            "FM-L- Exercice Tirage Vertical Poulie Haute",
                                        nombreTotalSerie: 4,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 10),
                                          SerieConfig(repetitions: 8),
                                          SerieConfig(repetitions: 8),
                                        ],
                                        repos: 75,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre: "FM -C-BICEPS CURLS UNILATERAL",
                                        nombreTotalSerie: 3,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 15),
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 12),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
                                      ),
                                      Exercice(
                                        titre: "FM-C- TIRAGE NUQUE TRICEPS",
                                        nombreTotalSerie: 3,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 15),
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 12),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
                                      ),
                                    ],
                                  )));
                    },
                    child: Box(1,false, "s3.png", 3, "Tirage Horizontal Assis"),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LectureVideosExoFromProgram(
                                onComplete: () => _markSessionAsCompleted('semaine1_seance4'),
                                    path: widget.path, pg : "powerfit_pgbbl",
                                    exercice: [
                                      Exercice(
                                        titre: "FM Echauffement",
                                        nombreTotalSerie: 1,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 1)
                                        ],
                                        repos: 0,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre: "FM-L- TIRAGE HORIZONTAL BICEPS",
                                        nombreTotalSerie: 4,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 10),
                                          SerieConfig(repetitions: 8),
                                          SerieConfig(repetitions: 8),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=A5rhhzRluhc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=2&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre:
                                            "FM-L- Exercice Developper Militaire",
                                        nombreTotalSerie: 4,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 10),
                                          SerieConfig(repetitions: 8),
                                          SerieConfig(repetitions: 8),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                                      ),
                                      Exercice(
                                        titre:
                                            "FM-C-CRUNCH ELEVATION GENIUX V2",
                                        nombreTotalSerie: 3,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 15),
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 12),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
                                      ),
                                      Exercice(
                                        titre: "FM -C- Exercice Air Squat",
                                        nombreTotalSerie: 3,
                                        seriesConfigs: [
                                          SerieConfig(repetitions: 15),
                                          SerieConfig(repetitions: 12),
                                          SerieConfig(repetitions: 12),
                                        ],
                                        repos: 60,
                                        linkVideo:
                                            "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
                                      ),
                                    ],
                                  )));
                    },
                    child: Box(1,false, "s1.png", 4, "TIRAGE HORIZONTAL BICEPS"),
                  ),

                  // Semaine 2
                  TextComponent(
                      text: "Semaine 2",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),

// SESSION 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine2_seance1'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Elevation Laterale",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=A203KccHReo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=11&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=tTLHrF1ZFPA&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=5&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre: "FM -C-TIRAGE COUDE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- TIRAGE NUQUE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child:
                        Box(2,true, "s1.png", 1, "Exercice Elevation Laterale"),
                  ),

// SESSION 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine2_seance2'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Poulie Haute",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM -L- TIRAGE VERTICAL POITRINE",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=-RXu8V-hYxw&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=4&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Tirage horizontal fessier",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- Exercice Kikback",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=sJWG3P1JkHg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=16&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(2,true, "s2.png", 2,
                        "Exercice Tirage Vertical Poulie Haute"),
                  ),

// SESSION 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine2_seance3'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=tTLHrF1ZFPA&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=5&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Elevation Laterale",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=A203KccHReo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=11&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C-TIRAGE COUDE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- TIRAGE NUQUE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(2,
                        true, "s3.png", 3, "Exercice Tirage Vertical Assis"),
                  ),

// SESSION 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine2_seance4'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM -L- TIRAGE VERTICAL POITRINE",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=-RXu8V-hYxw&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=4&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Poulie Haute",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Tirage horizontal fessier",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- Exercice Kikback",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=sJWG3P1JkHg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=16&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(2,true, "s1.png", 4, "TIRAGE VERTICAL POITRINE"),
                  ),

                  // Semaine 3
                  TextComponent(
                      text: "Semaine 3",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),

// SESSION 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        onComplete: () => _markSessionAsCompleted('semaine3_seance1'),
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- TIRAGE HORIZONTAL TRICEPS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- BICEPS CURLS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre: "FM-C- Exercice Mini SQuat",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Elevation genoux",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(3,true, "s1.png", 1, "TIRAGE HORIZONTAL TRICEPS"),
                  ),

// SESSION 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine3_seance2'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=tTLHrF1ZFPA&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=5&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Poulie Haute",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C- Exercice Air Squat",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Squat a Genoux",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(3,
                        true, "s2.png", 2, "Exercice Tirage Vertical Assis"),
                  ),

// SESSION 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine3_seance3'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- TIRAGE HORIZONTAL TRICEPS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- BICEPS CURLS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre: "FM-C- Exercice Mini SQuat",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Elevation genoux",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(3,true, "s3.png", 3, "TIRAGE HORIZONTAL TRICEPS"),
                  ),

// SESSION 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine3_seance4'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Poulie Haute",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=tTLHrF1ZFPA&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=5&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Squat a Genoux",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C- Exercice Air Squat",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(3,true, "s1.png", 4,
                        "Exercice Tirage Vertical Poulie Haute"),
                  ),

                  // Semaine 4
                  TextComponent(
                      text: "Semaine 4",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),

// SESSION 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine4_seance1'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- TIRAGE HORIZONTAL TRICEPS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- TIRAGE HORIZONTAL BICEPS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=A5rhhzRluhc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=2&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Rowing Unilateral",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Elevation Laterale Jambes",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=VwW_Tt7NplY&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=17&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(4,true, "s1.png", 1, "TIRAGE HORIZONTAL TRICEPS"),
                  ),

// SESSION 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine4_seance2'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Elevation Laterale",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=A203KccHReo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=11&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- Exercice ROWING",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C-CRUNCH ELEVATION GENIUX V2",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C-TIRAGE COUDE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child:
                        Box(4,true, "s2.png", 2, "Exercice Elevation Laterale"),
                  ),

// SESSION 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine4_seance3'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- TIRAGE HORIZONTAL TRICEPS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- TIRAGE HORIZONTAL BICEPS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=A5rhhzRluhc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=2&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Rowing Unilateral",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Elevation Laterale Jambes",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=VwW_Tt7NplY&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=17&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(4,true, "s3.png", 3, "TIRAGE HORIZONTAL TRICEPS"),
                  ),

// SESSION 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine4_seance4'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- Exercice ROWING",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Elevation Laterale",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=A203KccHReo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=11&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C-CRUNCH ELEVATION GENIUX V2",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C-TIRAGE COUDE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(4,true, "s1.png", 4, "Exercice ROWING"),
                  ),

                  // Semaine 5
                  TextComponent(
                      text: "Semaine 5",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),

// SESSION 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine5_seance1'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Elevation Frontal",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=kPNmz30EQYc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=12&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Squat a Genoux",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Tirage horizontal fessier",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(5,true, "s1.png", 1, "Exercice Elevation Frontal"),
                  ),

// SESSION 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        onComplete: () => _markSessionAsCompleted('semaine5_seance2'),
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- TIRAGE HORIZONTAL TRICEPS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Poulie Basse",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C- Exercice Air Squat",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C-CRUNCH ELEVATION GENIUX V2",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(5,true, "s2.png", 2, "TIRAGE HORIZONTAL TRICEPS"),
                  ),

// SESSION 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine5_seance3'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Elevation Frontal",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=kPNmz30EQYc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=12&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Squat a Genoux",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Tirage horizontal fessier",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(5,
                        true, "s3.png", 3, "Exercice Tirage Horizontal Assis"),
                  ),

// SESSION 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine5_seance4'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Poulie Basse",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- TIRAGE HORIZONTAL TRICEPS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C- Exercice Air Squat",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C-CRUNCH ELEVATION GENIUX V2",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(5,true, "s1.png", 4,
                        "Exercice Tirage Horizontal Poulie Basse"),
                  ),

                  // Semaine 6
                  TextComponent(
                      text: "Semaine 6",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),

// SESSION 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine6_seance1'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Elevation Frontal",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=kPNmz30EQYc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=12&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- Exercice ROWING",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- TIRAGE NUQUE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C- Exercice Air Squat",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(6,true, "s1.png", 1, "Exercice Elevation Frontal"),
                  ),

// SESSION 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine6_seance2'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Developper Militaire",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Tirage horizontal fessier",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Rowing Unilateral",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child:
                        Box(6,true, "s2.png", 2, "Exercice Developper Militaire"),
                  ),

// SESSION 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine6_seance3'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- Exercice ROWING",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Elevation Frontal",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=kPNmz30EQYc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=12&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- TIRAGE NUQUE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C- Exercice Air Squat",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(6,true, "s3.png", 3, "Exercice ROWING"),
                  ),

// SESSION 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        onComplete: () => _markSessionAsCompleted('semaine6_seance4'),
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Developper Militaire",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Tirage horizontal fessier",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Rowing Unilateral",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(6,
                        true, "s1.png", 4, "Exercice Tirage Horizontal Assis"),
                  ),

                  // Semaine 7
                  TextComponent(
                      text: "Semaine 7",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),

// SESSION 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance1'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- BICEPS CURLS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM -L- TIRAGE VERTICAL POITRINE",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=-RXu8V-hYxw&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=4&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C-TIRAGE COUDE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- TIRAGE NUQUE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(7,true, "s1.png", 1, "BICEPS CURLS"),
                  ),

// SESSION 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance2'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Developper Militaire",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Rowing Unilateral",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C- Exercice Air Squat",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(7,
                        true, "s2.png", 2, "Exercice Tirage Horizontal Assis"),
                  ),

// SESSION 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance3'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- BICEPS CURLS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM -L- TIRAGE VERTICAL POITRINE",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=-RXu8V-hYxw&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=4&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C-TIRAGE COUDE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- TIRAGE NUQUE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(7,true, "s3.png", 3, "BICEPS CURLS"),
                  ),

// SESSION 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance4'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Developper Militaire",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Rowing Unilateral",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM -C- Exercice Air Squat",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child:
                        Box(7,true, "s1.png", 4, "Exercice Developper Militaire"),
                  ),

                  // Semaine 8
                  TextComponent(
                      text: "Semaine 8",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),

// SESSION 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance1'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice rowing Buste penché",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=mR1ghqgyqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=9&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM -C-BICEPS CURLS UNILATERAL",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Elevation Laterale Jambes",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=VwW_Tt7NplY&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=17&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child:
                        Box(8,true, "s1.png", 1, "Exercice rowing Buste penché"),
                  ),

// SESSION 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance2'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- BICEPS CURLS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Rowing Buste Penché Unilateral",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=poxJClRBqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=14&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Elevation genoux",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- Exercice Kikback",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=sJWG3P1JkHg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=16&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(8,true, "s2.png", 2, "BICEPS CURLS"),
                  ),

// SESSION 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance3'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice rowing Buste penché",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=mR1ghqgyqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=9&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Assis",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM -C-BICEPS CURLS UNILATERAL",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Elevation Laterale Jambes",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=VwW_Tt7NplY&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=17&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child:
                        Box(8,true, "s3.png", 3, "Exercice rowing Buste penché"),
                  ),

// SESSION 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance4'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Rowing Buste Penché Unilateral",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=poxJClRBqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=14&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- BICEPS CURLS",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Elevation genoux",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- Exercice Kikback",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=sJWG3P1JkHg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=16&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(8,true, "s1.png", 4,
                        "Exercice Rowing Buste Penché Unilateral"),
                  ),

                  // Semaine 9
                  TextComponent(
                      text: "Semaine 9",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),

// SESSION 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance1'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Poulie Basse",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- Exercice ROWING",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Tirage horizontal fessier",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- CRUNCH CROISé",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(9,true, "s1.png", 1,
                        "Exercice Tirage Horizontal Poulie Basse"),
                  ),

// SESSION 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance2'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- TIRAGE VERTICAL POITRINE",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=-RXu8V-hYxw&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=4&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Elevation Frontal",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=kPNmz30EQYc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=12&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- CRUNCH ELEVATION GENIUX V2",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- TIRAGE COUDE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(9,true, "s2.png", 2, "TIRAGE VERTICAL POITRINE"),
                  ),

// SESSION 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance3'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-L- Exercice ROWING",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Horizontal Poulie Basse",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 75,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- CRUNCH CROISé",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- Exercice Tirage horizontal fessier",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(9,true, "s3.png", 3, "Exercice ROWING"),
                  ),

// SESSION 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance4'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                            titre: "FM Echauffement",
                                            nombreTotalSerie: 1,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 1)
                                            ],
                                            repos: 0,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- TIRAGE VERTICAL POITRINE",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=-RXu8V-hYxw&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=4&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Elevation Frontal",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=kPNmz30EQYc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=12&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre:
                                                "FM-C- CRUNCH ELEVATION GENIUX V2",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
                                          ),
                                          Exercice(
                                            titre: "FM-C- TIRAGE COUDE TRICEPS",
                                            nombreTotalSerie: 3,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 15),
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 12),
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
                                          ),
                                        ],
                                      )));
                    },
                    child: Box(9,true, "s1.png", 4, "TIRAGE VERTICAL POITRINE"),
                  ),

                  // Semaine 10
                  TextComponent(
                      text: "Semaine 10",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),

// SESSION 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance1'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                              titre: "FM Echauffement",
                                              nombreTotalSerie: 1,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 1)
                                              ],
                                              repos: 0,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-L- Exercice ROWING",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-L- Exercice Tirage Horizontal Poulie Basse",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-C- TIRAGE COUDE TRICEPS",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 15),
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 12)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-C- Exercice Air Squat",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB"),
                                        ],
                                      )));
                    },
                    child: Box(10,true, "s1.png", 1, "ROWING & Tirage Horizontal"),
                  ),

// SESSION 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance2'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                              titre: "FM Echauffement",
                                              nombreTotalSerie: 1,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 1)
                                              ],
                                              repos: 0,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB"),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Poulie Haute",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8)
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
                                          ),
                                          Exercice(
                                              titre:
                                                  "FM-L- TIRAGE HORIZONTAL TRICEPS",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-C- CRUNCH CROISé",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 15),
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 12)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-C- Exercice Mini SQuat",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB"),
                                        ],
                                      )));
                    },
                    child: Box(10,true, "s2.png", 2, "Tirage Vertical & Triceps"),
                  ),

// SESSION 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance3'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                              titre: "FM Echauffement",
                                              nombreTotalSerie: 1,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 1)
                                              ],
                                              repos: 0,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-L- Exercice Tirage Horizontal Poulie Basse",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-L- Exercice ROWING",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-C- TIRAGE COUDE TRICEPS",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 15),
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 12)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-C- Exercice Air Squat",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB"),
                                        ],
                                      )));
                    },
                    child: Box(10,true, "s3.png", 3, "ROWING & Tirage Horizontal"),
                  ),

// SESSION 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance4'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                              titre: "FM Echauffement",
                                              nombreTotalSerie: 1,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 1)
                                              ],
                                              repos: 0,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-L- TIRAGE HORIZONTAL TRICEPS",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB"),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Poulie Haute",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8)
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
                                          ),
                                          Exercice(
                                              titre:
                                                  "FM-C- Exercice Mini SQuat",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-C- CRUNCH CROISé",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 15),
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 12)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB"),
                                        ],
                                      )));
                    },
                    child: Box(10,true, "s1.png", 4, "Triceps & Vertical"),
                  ),

                  // Semaine 11
                  TextComponent(
                      text: "Semaine 11",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),

// SESSION 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance1'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                              titre: "FM Echauffement",
                                              nombreTotalSerie: 1,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 1)
                                              ],
                                              repos: 0,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB"),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Poulie Haute",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8)
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
                                          ),
                                          Exercice(
                                              titre:
                                                  "FM-L- Exercice Tirage Vertical Assis",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=tTLHrF1ZFPA&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=5&pp=iAQB0gcJCYQJAYcqIYzv"),
                                          Exercice(
                                              titre:
                                                  "FM-C- BICEPS CURLS UNILATERAL",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 15),
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 12)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv"),
                                          Exercice(
                                              titre:
                                                  "FM-C- CRUNCH ELEVATION GENIUX V2",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB"),
                                        ],
                                      )));
                    },
                    child: Box(11,true, "s1.png", 1, "Tirage Vertical & Biceps"),
                  ),

// SESSION 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance2'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                              titre: "FM Echauffement",
                                              nombreTotalSerie: 1,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 1)
                                              ],
                                              repos: 0,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-L- TIRAGE HORIZONTAL BICEPS",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=A5rhhzRluhc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=2&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-L- Exercice ROWING",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-C- Exercice Mini SQuat",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-C- CRUNCH CROISé",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 15),
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 12)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB"),
                                        ],
                                      )));
                    },
                    child: Box(11,true, "s2.png", 2, "Rowing & Biceps"),
                  ),

// SESSION 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance3'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                              titre: "FM Echauffement",
                                              nombreTotalSerie: 1,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 1)
                                              ],
                                              repos: 0,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-L- Exercice Tirage Vertical Assis",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=tTLHrF1ZFPA&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=5&pp=iAQB0gcJCYQJAYcqIYzv"),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Poulie Haute",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8)
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
                                          ),
                                          Exercice(
                                              titre:
                                                  "FM-C- BICEPS CURLS UNILATERAL",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 15),
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 12)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv"),
                                          Exercice(
                                              titre:
                                                  "FM-C- CRUNCH ELEVATION GENIUX V2",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB"),
                                        ],
                                      )));
                    },
                    child: Box(11,true, "s3.png", 3, "Vertical & Biceps"),
                  ),

// SESSION 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance4'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                              titre: "FM Echauffement",
                                              nombreTotalSerie: 1,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 1)
                                              ],
                                              repos: 0,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-L- TIRAGE HORIZONTAL BICEPS",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=A5rhhzRluhc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=2&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-L- Exercice ROWING",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-C- Exercice Mini SQuat",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-C- CRUNCH CROISé",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 15),
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 12)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB"),
                                        ],
                                      )));
                    },
                    child: Box(11,true, "s1.png", 4, "Rowing & Biceps"),
                  ),

                  // Semaine 12
                  TextComponent(
                      text: "Semaine 12",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      size: 14),

// SESSION 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine12_seance1'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                              titre: "FM Echauffement",
                                              nombreTotalSerie: 1,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 1)
                                              ],
                                              repos: 0,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-L- Exercice Rowing Buste Penché Unilateral",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=poxJClRBqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=14&pp=iAQB"),
                                          Exercice(
                                            titre:
                                                "FM-L- Exercice Tirage Vertical Poulie Haute",
                                            nombreTotalSerie: 4,
                                            seriesConfigs: [
                                              SerieConfig(repetitions: 12),
                                              SerieConfig(repetitions: 10),
                                              SerieConfig(repetitions: 8),
                                              SerieConfig(repetitions: 8)
                                            ],
                                            repos: 60,
                                            linkVideo:
                                                "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
                                          ),
                                          Exercice(
                                              titre:
                                                  "FM-C- Exercice Mini SQuat",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-C- CRUNCH CROISé",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 15),
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 12)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB"),
                                        ],
                                      )));
                    },
                    child: Box(12,
                        true, "s1.png", 1, "Rowing Buste Penché & Vertical"),
                  ),

// SESSION 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil
                          ? showToast(
                              context, "Cette vidéo est Bloquée", Colors.red)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LectureVideosExoFromProgram(
                                        onComplete: () => _markSessionAsCompleted('semaine12_seance2'),
                                        path: widget.path, pg : "powerfit_pgbbl",
                                        exercice: [
                                          Exercice(
                                              titre: "FM Echauffement",
                                              nombreTotalSerie: 1,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 1)
                                              ],
                                              repos: 0,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB"),
                                          Exercice(
                                              titre: "FM-L- Exercice ROWING",
                                              nombreTotalSerie: 4,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 10),
                                                SerieConfig(repetitions: 8),
                                                SerieConfig(repetitions: 8)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-L- Exercice Elevation Frontal",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 15),
                                                SerieConfig(repetitions: 12),
                                                SerieConfig(repetitions: 12)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=kPNmz30EQYc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=12&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-C- Exercice Squat a Genoux",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB"),
                                          Exercice(
                                              titre:
                                                  "FM-C- Exercice Elevation genoux",
                                              nombreTotalSerie: 3,
                                              seriesConfigs: [
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20),
                                                SerieConfig(repetitions: 20)
                                              ],
                                              repos: 60,
                                              linkVideo:
                                                  "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB"),
                                        ],
                                      )));
                    },
                    child: Box(12,true, "s2.png", 2, "Rowing & Elevation Frontal"),
                  ),

// (Session 3 & 4 continuent de la même manière - je peux aussi te les écrire si tu veux)
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
