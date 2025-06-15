import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExoFromProgramme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/components/text_components.dart';
import '../../modules/monCompte/controller/controller.dart';
import '../../utils/colors.dart';
import '../LectureVideoExo/lectureVideosExo.dart';
import '../instruction/presentationQuardioQuad.dart';

class ProgrammeRenforcementMusculaireHomme extends StatefulWidget {
  String path;
  bool isFromAccueil;

  ProgrammeRenforcementMusculaireHomme({required this.path,required this.isFromAccueil});

  @override
  State<ProgrammeRenforcementMusculaireHomme> createState() => _ProgrammeRenforcementMusculaireHommeState();
}

class _ProgrammeRenforcementMusculaireHommeState extends State<ProgrammeRenforcementMusculaireHomme> {

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
    Set<String> completedSessions = _prefs.getStringList('completedSessions_pgrenforcementmusculaire_cardio')?.toSet() ?? {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList('completedSessions_pgrenforcementmusculaire_cardio', _completedSessions.toList());
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
                    height: 400,
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
                            height: 180,
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
                                        text: "Renforcement Musculaire Homme",
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
                                              TextComponent(text: "24 semaines", color: Colors.white.withOpacity(0.7))
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InstructionQuardioQuad(producName: "Vidéos d'instruction", path: "quardio1.png")));
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
                  TextComponent(text: "Semaine 1", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine1_seance1'),

                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=9Aa4_6iAatM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=10&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=zegeAw_b1PI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=37&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                        // onComplete: () => _markSessionAsCompleted('semaine1_seance1'),
                        // onComplete: () => _markSessionAsCompleted('Séance 1'),
                      )));
                    },
                    child: Box(1,false,"s1.png", 1, "Ecarter aux Haltère"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine1_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXFBDifw3oQ&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=INj2w0L0N9M&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=18&pp=iAQB",
                          ),
                        ],
                        // onComplete: () => _markSessionAsCompleted('semaine1_seance2'),
                      )));
                    },
                    child: Box(1,false,"s2.png", 2, "Ecarter aux Haltère"),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine1_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=9Aa4_6iAatM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=10&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=zegeAw_b1PI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=37&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s3.png", 3, "Soulever de terre avec Haltère"),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine1_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXFBDifw3oQ&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=INj2w0L0N9M&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s1.png", 4, "Ecarter aux Haltère"),
                  ),

                  TextComponent(text: "Semaine 2", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine2_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OHWfO2VWIfY&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=5&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=pXFBDifw3oQ&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,true,"s1.png", 1, "Fente Arrière"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine2_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXfcfzNEYVk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,true,"s2.png", 2, "Rotation de la Hanche (Oblique)"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine2_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=OHWfO2VWIfY&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=5&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXFBDifw3oQ&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,true,"s3.png", 3, "Rotation Hanche Oblique Assis"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine2_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXfcfzNEYVk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(2,true,"s1.png", 4, "Rotation de la Hanche (Oblique)"),
                  ),

                  TextComponent(text: "Semaine 3", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine3_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=INj2w0L0N9M&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,true,"s1.png", 1, "Air squat"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine3_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DYYQYhbBGck&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,true,"s2.png", 2, "Biceps"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine3_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=INj2w0L0N9M&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,true,"s3.png", 3, "Squat Sauter"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine3_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DYYQYhbBGck&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(3,true,"s1.png", 4, "Biceps"),
                  ),

                  TextComponent(text: "Semaine 4", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine4_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=UhNbMKPTa6I&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=19&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,true,"s1.png", 1, "Elevation Genoux vers la poitrine"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine4_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DYYQYhbBGck&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=nADC7E3h3hE&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=31&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1lAxdXLQsmM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=24&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,true,"s2.png", 2, "Triceps"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine4_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=UhNbMKPTa6I&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=19&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,true,"s3.png", 3, "Elevation Genoux Position Bébé"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine4_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=nADC7E3h3hE&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=31&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DYYQYhbBGck&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1lAxdXLQsmM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=24&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(4,true,"s1.png", 4, "Prise Marto Biceps"),
                  ),

                  TextComponent(text: "Semaine 5", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine5_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oq8rGOYQwn0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=25nZg12ThjU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OHWfO2VWIfY&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=5&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,true,"s1.png", 1, "Elevation Horizontale Epaules"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine5_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DYYQYhbBGck&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=AcLqYKdufUw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,true,"s2.png", 2, "Front Squat"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine5_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=25nZg12ThjU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oq8rGOYQwn0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OHWfO2VWIfY&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=5&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,true,"s3.png", 3, "Crunch Abdominal"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine5_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DYYQYhbBGck&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=AcLqYKdufUw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(5,true,"s1.png", 4, "Triceps"),
                  ),
                  TextComponent(text: "Semaine 6", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine6_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=25nZg12ThjU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=zegeAw_b1PI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=37&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,true,"s1.png", 1, "Tirage à la poulie Basse"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine6_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=pXfcfzNEYVk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oq8rGOYQwn0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=14&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,true,"s2.png", 2, "Squat Sauter"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine6_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=25nZg12ThjU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=zegeAw_b1PI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=37&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,true,"s3.png", 3, "Squat Croisé"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine6_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXfcfzNEYVk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oq8rGOYQwn0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=14&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(6,true,"s1.png", 4, "Rotation de la Hanche (Oblique)"),
                  ),

                  TextComponent(text: "Semaine 7", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=nADC7E3h3hE&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=31&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=51ySRi8hsb4&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=3&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s1.png", 1, "Trapèze"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=1lAxdXLQsmM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s2.png", 2, "Fente Avant Fente Arrière"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=nADC7E3h3hE&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=31&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=51ySRi8hsb4&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=3&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s3.png", 3, "Prise Marto Biceps"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1lAxdXLQsmM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s1.png", 4, "Elevation Fessier Position bébé"),
                  ),

                  TextComponent(text: "Semaine 8", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9Aa4_6iAatM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=10&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s1.png", 1, "Squat Croisé"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OHWfO2VWIfY&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=5&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s2.png", 2, "Soulever de terre avec Haltère"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9Aa4_6iAatM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=10&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s3.png", 3, "Ischio"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OHWfO2VWIfY&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=5&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s1.png", 4, "Tirage Horizontal"),
                  ),

                  TextComponent(text: "Semaine 9", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=AcLqYKdufUw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=nADC7E3h3hE&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=31&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DYYQYhbBGck&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s1.png", 1, "Elevation Lateral & Frontal"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=1lAxdXLQsmM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=NWtSq73XLfI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=zegeAw_b1PI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=37&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=UhNbMKPTa6I&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=19&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s2.png", 2, "Elevation Genoux vers la poitrine"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=AcLqYKdufUw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DYYQYhbBGck&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=35&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=nADC7E3h3hE&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=31&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s3.png", 3, "Quadriceps"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=zegeAw_b1PI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=37&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1lAxdXLQsmM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=UhNbMKPTa6I&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=19&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=NWtSq73XLfI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=11&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s1.png", 4, "Elevation Genoux vers la poitrine"),
                  ),
                  TextComponent(text: "Semaine 10", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=AcLqYKdufUw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1lAxdXLQsmM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s1.png", 1, "Tirage Horizontal"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9Aa4_6iAatM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=10&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=INj2w0L0N9M&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=18&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s2.png", 2, "Fente Militaire Avec Haltère"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=AcLqYKdufUw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1lAxdXLQsmM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s3.png", 3, "Soulever de terre avec Haltère"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=INj2w0L0N9M&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9Aa4_6iAatM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=10&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s1.png", 4, "Dips"),
                  ),
                  TextComponent(text: "Semaine 11", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=UhNbMKPTa6I&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=19&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXFBDifw3oQ&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=17&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s1.png", 1, "Elevation Genoux Position Bébé"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LrjY5vq7Uk0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=7SDob403zg0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=21&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s2.png", 2, "Elevation Genoux (BDO)"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXFBDifw3oQ&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=UhNbMKPTa6I&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=19&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s3.png", 3, "Ecarter aux Haltère"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LrjY5vq7Uk0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=7SDob403zg0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s1.png", 4, "Squat Croisé"),
                  ),


                  TextComponent(text: "Semaine 12", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine12_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=UhNbMKPTa6I&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=19&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=25nZg12ThjU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9Aa4_6iAatM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=10&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s1.png", 1, "Fente Avant Fente Arrière"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine12_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB`",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=NWtSq73XLfI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Incliner",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=XmJLVOZMBKo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=20&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s2.png", 2, "Ischio Fessiers"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine12_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=UhNbMKPTa6I&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=19&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9Aa4_6iAatM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=10&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=25nZg12ThjU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=40&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s3.png", 3, "Fente Avant Fente Arrière"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine12_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=NWtSq73XLfI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Incliner",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=XmJLVOZMBKo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=20&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s1.png", 4, "Fente Militaire Avec Haltère"),
                  ),

                  TextComponent(text: "Semaine 13", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine13_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(13,true,"s1.png", 1, "Squat Sauter"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine13_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oq8rGOYQwn0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=INj2w0L0N9M&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=18&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(13,true,"s2.png", 2, "Elevation Horizontale Epaules"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine13_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(13,true,"s3.png", 3, "Squat Sauter"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine13_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oq8rGOYQwn0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=INj2w0L0N9M&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=18&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(13,true,"s1.png", 4, "Front Squat"),
                  ),

                  TextComponent(text: "Semaine 14", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine14_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=AcLqYKdufUw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(14,true,"s1.png", 1, "Elevation Fessier Position bébé"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine14_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OHWfO2VWIfY&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=5&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(14,true,"s2.png", 2, "Gainage"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine14_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=AcLqYKdufUw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(14,true,"s3.png", 3, "Elevation Lateral & Frontal"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine14_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OHWfO2VWIfY&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=5&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(14,true,"s1.png", 4, "Biceps"),
                  ),
                  TextComponent(text: "Semaine 15", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine15_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=AcLqYKdufUw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oq8rGOYQwn0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(15,true,"s1.png", 1, "Gainage"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine15_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=7SDob403zg0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(15,true,"s2.png", 2, "Developper Epaules"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine15_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oq8rGOYQwn0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=AcLqYKdufUw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(15,true,"s3.png", 3, "Elevation Horizontale Epaules"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine15_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=7SDob403zg0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(15,true,"s1.png", 4, "Elevation Fessier Position bébé"),
                  ),
                  TextComponent(text: "Semaine 16", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine16_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oq8rGOYQwn0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(16,true,"s1.png", 1, "Extension des Jambes (Femmes)"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine16_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(16,true,"s2.png", 2, "Pompes genoux au sol"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine16_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=oq8rGOYQwn0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(16,true,"s3.png", 3, "Extension des Jambes (Femmes)"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine16_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(16,true,"s1.png", 4, "Front Squat"),
                  ),
                  TextComponent(text: "Semaine 17", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine17_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=51ySRi8hsb4&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=3&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(17,true,"s1.png", 1, "Crunch Lateral"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine17_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=7SDob403zg0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(17,true,"s2.png", 2, "Soulever de terre avec Haltère"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine17_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=28&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=51ySRi8hsb4&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=3&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(17,true,"s3.png", 3, "Rotation Hanche Oblique Assis"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine17_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=7SDob403zg0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=21&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(17,true,"s1.png", 4, "Biceps"),
                  ),
                  TextComponent(text: "Semaine 18", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine18_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=zegeAw_b1PI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=37&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(18,true,"s1.png", 1, "Tirage Horizontal"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine18_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OHWfO2VWIfY&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=5&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(18,true,"s2.png", 2, "Pompes genoux au sol"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine18_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=zegeAw_b1PI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=37&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(18,true,"s3.png", 3, "Elevation Biceps"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine18_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OHWfO2VWIfY&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=5&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(18,true,"s1.png", 4, "Crunch Lateral"),
                  ),
                  TextComponent(text: "Semaine 19", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine19_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=51ySRi8hsb4&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=3&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Incliner",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=XmJLVOZMBKo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=20&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(19,true,"s1.png", 1, "Extension des Jambes (Femmes)"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine19_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXfcfzNEYVk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=1lAxdXLQsmM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=24&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXFBDifw3oQ&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=17&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(19,true,"s2.png", 2, "Rotation de la Hanche (Oblique)"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine19_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=51ySRi8hsb4&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=3&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Incliner",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=XmJLVOZMBKo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=20&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(19,true,"s3.png", 3, "Extension des Jambes (Femmes)"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine19_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXFBDifw3oQ&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXfcfzNEYVk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1lAxdXLQsmM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=24&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(19,true,"s1.png", 4, "Trapèze"),
                  ),

                  TextComponent(text: "Semaine 20", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine20_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=nADC7E3h3hE&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=31&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(20,true,"s1.png", 1, "Biceps"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine20_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=INj2w0L0N9M&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=18&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(20,true,"s2.png", 2, "Elevation Genoux vers la poitrine"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine20_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=nADC7E3h3hE&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=31&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=qfDEJ1KR_e0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(20,true,"s3.png", 3, "Prise Marto Biceps"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine20_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=INj2w0L0N9M&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xHuzv0h_ZU8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=12&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(20,true,"s1.png", 4, "Elevation Genoux vers la poitrine"),
                  ),

                  TextComponent(text: "Semaine 21", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine21_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=25nZg12ThjU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXfcfzNEYVk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=29&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(21,true,"s1.png", 1, "Fente Avant Fente Arrière"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine21_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(21,true,"s2.png", 2, "Crunch Lateral"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine21_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=8wcpw_L7jE8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=36&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXfcfzNEYVk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=25nZg12ThjU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(21,true,"s3.png", 3, "Squat Sauter"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine21_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=sLmxChOjVnw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(21,true,"s1.png", 4, "Biceps"),
                  ),


                  TextComponent(text: "Semaine 22", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine22_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LrjY5vq7Uk0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=NWtSq73XLfI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=nADC7E3h3hE&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=31&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(22,true,"s1.png", 1, "Elevation Genoux (BDO)"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine22_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=7SDob403zg0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=pXFBDifw3oQ&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9Aa4_6iAatM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=10&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(22,true,"s2.png", 2, "Developper Epaules"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine22_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=nADC7E3h3hE&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=31&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=OuDNdDN-cVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=32&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=LrjY5vq7Uk0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=NWtSq73XLfI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=11&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(22,true,"s3.png", 3, "Tirage à la poulie basse Grand dorsaux"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine22_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=_nd1B_dlipU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=42&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXFBDifw3oQ&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=1vw3YfdmIvo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=7SDob403zg0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9Aa4_6iAatM&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=10&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(22,true,"s1.png", 4, "Ecarter aux Haltère"),
                  ),
                  TextComponent(text: "Semaine 23", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine23_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=pXfcfzNEYVk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB4",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=zegeAw_b1PI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=37&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(23,true,"s1.png", 1, "Elevation Genoux vers la poitrine"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine23_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=7SDob403zg0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(23,true,"s2.png", 2, "Squat Croisé"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine23_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=pXfcfzNEYVk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=29&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=DPV3lqNDSNw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=39&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=8&pp=iAQB",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=zegeAw_b1PI&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=37&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(23,true,"s3.png", 3, "Rotation de la Hanche (Oblique)"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine23_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=30&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=3le3xUV-DJ8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=22&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=7SDob403zg0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=QK18r5P_TkA&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=38&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(23,true,"s1.png", 4, "Quadriceps"),
                  ),
                  TextComponent(text: "Semaine 24", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine24_seance1'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=51ySRi8hsb4&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=3&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=UhNbMKPTa6I&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=19&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(24,true,"s1.png", 1, "Trapèze"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine24_seance2'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=xLcMFqQ6DI0&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=26&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=25nZg12ThjU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(24,true,"s2.png", 2, "Soulever de terre avec Haltère"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine24_seance3'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=TwnFE1baiCc&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=33&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=34&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=51ySRi8hsb4&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=3&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=UhNbMKPTa6I&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=19&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(24,true,"s3.png", 3, "Biceps"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine24_seance4'),
                        path: widget.path, pg : "cardio_pg_renforcement",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4dWWnvbWcxo&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=41&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Extension des Jambes (Femmes)",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=yyM9rgZttrk&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "https://www.youtube.com/watch?v=5iwXRalDIho&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=25nZg12ThjU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=40&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=YPKhhkPp5N8&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=27&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 1,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=d6C7fI2L5WU&list=PL9GsY7tWZQwElr49QQOMuC43lnbQZsjw9&index=1&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(24,true,"s1.png", 4, "Extension des Jambes (Femmes)"),
                  ),



                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget Box(int semaine,bool isLocked, String img, int seance, String titre) {
    if (!widget.isFromAccueil) {
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
                  image: DecorationImage(image: AssetImage("assets/images/$img"), fit: BoxFit.cover)
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 3,
                children: [
                  TextComponent(text: "Séance $seance", fontWeight: FontWeight.bold),
                  TextComponent(text: titre, textAlign: TextAlign.start)
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
