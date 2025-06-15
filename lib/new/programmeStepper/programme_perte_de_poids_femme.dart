import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExoFromProgramme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/components/text_components.dart';
import '../../modules/monCompte/controller/controller.dart';
import '../../utils/colors.dart';
import '../LectureVideoExo/lectureVideosExo.dart';
import '../instruction/presentationStepper.dart';

class ProgrammeStepperPerteDePoidsFemme extends StatefulWidget {
  String path;
  bool isFromAccueil;

  ProgrammeStepperPerteDePoidsFemme({required this.path,required this.isFromAccueil});

  @override
  State<ProgrammeStepperPerteDePoidsFemme> createState() => _ProgrammeStepperPerteDePoidsFemmeState();
}

class _ProgrammeStepperPerteDePoidsFemmeState extends State<ProgrammeStepperPerteDePoidsFemme> {

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
    Set<String> completedSessions = _prefs.getStringList('completedSessions_pgbbl_stepper')?.toSet() ?? {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList('completedSessions_pgbbl_stepper', _completedSessions.toList());
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
                                        child: TextComponent(textAlign: TextAlign.start,text: "Perte de poids",fontWeight: FontWeight.bold,color: Colors.white,)),

                                    Container(
                                      width: Screen.width(context) / 1.2,
                                      child: Row(

                                        mainAxisAlignment: MainAxisAlignment.center,spacing: 20,
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
                  TextComponent(text: "Contenu",fontWeight: FontWeight.bold,color: mainColor,size: 14,),
                  InkWell(
                    onTap : (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PresentationStepper(producName: "Power", path: "stepper1.png")));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance1'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Séance Cardio
                          Exercice(
                            titre: "Séance Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "SF Biceps Curls",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=uOIDhnX1U0U&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=12&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Rowing",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Leg Extension Lateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s1.png", 1, "Séance 1"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine1_seance2'),
                         path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // SF Echauffement
                          Exercice(
                            titre: "SF Echauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "SF Biceps Curls Supination (Concentré)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Horizontal (Dos)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Soulever de Terre Roumain",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s2.png", 2, "Séance 2"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine1_seance3'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Séance Cardio
                          Exercice(
                            titre: "Séance Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "SF Biceps Curls",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=uOIDhnX1U0U&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=12&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Rowing",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Leg Extension Lateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s3.png", 3, "Séance 3"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine1_seance4'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Séance Cardio
                          Exercice(
                            titre: "Séance Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "SF Biceps Curls Supination (Concentré)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Horizontal (Dos)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Soulever de Terre Roumain",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s1.png", 4, "Séance 4"),
                  ),
                  TextComponent(text: "Semaine 2", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine2_seance1'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Etirements
                              Exercice(
                                titre: "SF Etirements",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Vertical Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Biceps Curls Marteau Concentré",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Fente Arrière",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jF5QMvvRA1w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=24&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Rotation Oblique",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=bzCKZ961VgU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=3&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(2,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine2_seance2'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Echauffement
                              Exercice(
                                titre: "SF Echauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Nuque Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Biceps Curls Supination (Concentré)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Leg Extension Lateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Gainage",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(2,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine2_seance3'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Echauffement
                              Exercice(
                                titre: "SF Echauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Vertical Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Biceps Curls Marteau Concentré",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Fente Arrière",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jF5QMvvRA1w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=24&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Rotation Oblique",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=bzCKZ961VgU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=3&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(2,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine2_seance4'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Etirements
                              Exercice(
                                titre: "SF Etirements",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Nuque Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Biceps Curls Supination (Concentré)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Leg Extension Lateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Gainage",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(2,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 3", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine3_seance1'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Echauffement
                              Exercice(
                                titre: "SF Echauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Menton",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Tirage Horizontal (Dos)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Tirage Vertical Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Leg Extension Lateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(3,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine3_seance2'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Etirements
                              Exercice(
                                titre: "SF Etirements",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Elevation Frontale",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Rowing Buste Penché",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=MUkMFCKwuOQ&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=26&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Nuque Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Soulever de Terre Roumain",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(3,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine3_seance3'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Echauffement
                              Exercice(
                                titre: "SF Echauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Menton",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Tirage Horizontal (Dos)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Tirage Vertical Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Leg Extension Lateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(3,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine3_seance4'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // Séance Cardio
                              Exercice(
                                titre: "Séance Cardio",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Elevation Frontale",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Rowing Buste Penché",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=MUkMFCKwuOQ&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=26&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Nuque Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Soulever de Terre Roumain",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(3,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 4", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine4_seance1'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // Séance Cardio
                              Exercice(
                                titre: "Séance Cardio",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Rowing",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Biceps Curls Supination (Concentré)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Fente Arriere Pieds Flechis",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=DBy_d7jeT-w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=18&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Soulever de Terre Roumain",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(4,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine4_seance2'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Echauffement
                              Exercice(
                                titre: "SF Echauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Horizontal (Dos)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Biceps Curls Marteau Concentré",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Fente Arrière",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jF5QMvvRA1w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=24&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Leg Extension Lateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(4,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine4_seance3'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // Séance Cardio
                              Exercice(
                                titre: "Séance Cardio",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Rowing",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Biceps Curls Supination (Concentré)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Fente Arriere Pieds Flechis",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=DBy_d7jeT-w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=18&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Soulever de Terre Roumain",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(4,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine4_seance4'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // Séance Cardio
                              Exercice(
                                titre: "Séance Cardio",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Horizontal (Dos)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Biceps Curls Marteau Concentré",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Fente Arrière",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jF5QMvvRA1w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=24&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Leg Extension Lateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(4,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 5", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine5_seance1'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Echauffement
                              Exercice(
                                titre: "SF Echauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Elevation Unilateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Squat",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Gainage",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Horizontal (Dos)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                            ],
                          )));
                        },
                        child: Box(5,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine5_seance2'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // Séance Cardio
                              Exercice(
                                titre: "Séance Cardio",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Menton",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Squat en Unilateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=NERG2rQHUIw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=8&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Rotation Oblique",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=bzCKZ961VgU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Rowing",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(5,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine5_seance3'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Echauffement
                              Exercice(
                                titre: "SF Echauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Elevation Unilateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Squat",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Gainage",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Horizontal (Dos)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                            ],
                          )));
                        },
                        child: Box(5,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine5_seance4'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Etirements
                              Exercice(
                                titre: "SF Etirements",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Menton",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Squat en Unilateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=NERG2rQHUIw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=8&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Rotation Oblique",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=bzCKZ961VgU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Rowing",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(5,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 6", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine6_seance1'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Echauffement
                              Exercice(
                                titre: "SF Echauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Rowing",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Leg Extension Lateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Nuque Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Elevation Unilateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(6,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine6_seance2'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // Séance Cardio
                              Exercice(
                                titre: "Séance Cardio",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Horizontal (Dos)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Soulever de Terre Roumain",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Vertical Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Elevation Frontale",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(6,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine6_seance3'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // Séance Cardio
                              Exercice(
                                titre: "Séance Cardio",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Rowing",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Leg Extension Lateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Nuque Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Elevation Unilateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(6,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine6_seance4'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // Séance Cardio
                              Exercice(
                                titre: "Séance Cardio",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Horizontal (Dos)",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Soulever de Terre Roumain",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Vertical Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Elevation Frontale",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(6,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 7", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance1'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // Séance Cardio
                              Exercice(
                                titre: "Séance Cardio",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Elevation Unilateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Squat",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Leg Extension Lateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Vertical Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(7,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance2'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Echauffement
                              Exercice(
                                titre: "SF Echauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Menton",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Fente Arrière Pieds Tendus",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=fodKg2BEUHY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=17&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Soulever de Terre Roumain",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Nuque Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(7,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance3'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // Séance Cardio
                              Exercice(
                                titre: "Séance Cardio",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Elevation Unilateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Squat",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Leg Extension Lateral",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Vertical Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(7,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine7_seance4'),
                            path: widget.path, pg : "stepper_pgbbl",
                            exercice: [
                              // SF Echauffement
                              Exercice(
                                titre: "SF Echauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "SF Tirage Menton",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "SF Fente Arrière Pieds Tendus",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 60,
                                linkVideo: "https://www.youtube.com/watch?v=fodKg2BEUHY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=17&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Soulever de Terre Roumain",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "SF Tirage Nuque Triceps",
                                nombreTotalSerie: 5,
                                seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                                repos: 45,
                                linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(7,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 8", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance1'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Echauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Elevation Unilateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Crunch Abdominal",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=N_fcDK2sBes&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Fente Arriere Pieds Flechis",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=DBy_d7jeT-w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s1.png", 1, "Séance 1"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance2'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "Séance Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Elevation Frontale",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Gainage",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Leg Extension Lateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s2.png", 2, "Séance 2"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance3'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Echauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Elevation Unilateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Crunch Abdominal",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=N_fcDK2sBes&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Fente Arriere Pieds Flechis",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=DBy_d7jeT-w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=18&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s3.png", 3, "Séance 3"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine8_seance4'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Echauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Elevation Frontale",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Gainage",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Leg Extension Lateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(8,true,"s1.png", 4, "Séance 4"),
                  ),
                  TextComponent(text: "Semaine 9", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance1'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Echauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Soulever de Terre Roumain",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Horizontal (Dos)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Supination (Concentré)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s1.png", 1, "Séance 1"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance2'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Etirements",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Leg Extension Lateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Rowing",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Marteau Concentré",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s2.png", 2, "Séance 2"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance3'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "Séance Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Soulever de Terre Roumain",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Horizontal (Dos)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Supination (Concentré)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s3.png", 3, "Séance 3"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine9_seance4'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Echauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Leg Extension Lateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Rowing",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Marteau Concentré",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(9,true,"s1.png", 4, "Séance 4"),
                  ),
                  TextComponent(text: "Semaine 10", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance1'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "Séance Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Menton",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Rowing",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Marteau Concentré",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s1.png", 1, "Séance 1"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance2'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Echauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Elevation Unilateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Horizontal (Dos)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=uOIDhnX1U0U&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=12&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s2.png", 2, "Séance 2"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance3'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Etirements",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Tirage Menton",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Rowing",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Marteau Concentré",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s3.png", 3, "Séance 3"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine10_seance4'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Etirements",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Elevation Unilateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Horizontal (Dos)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=uOIDhnX1U0U&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=12&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                        ],
                      )));
                    },
                    child: Box(10,true,"s1.png", 4, "Séance 4"),
                  ),
                  TextComponent(text: "Semaine 11", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance1'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Etirements",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Crunch Abdominal",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=N_fcDK2sBes&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Menton",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Marteau Concentré",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s1.png", 1, "Séance 1"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance2'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "Séance Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Gainage",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Elevation Frontale",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Supination (Concentré)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s2.png", 2, "Séance 2"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance3'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Etirements",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Crunch Abdominal",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=N_fcDK2sBes&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=23&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Menton",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Marteau Concentré",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s3.png", 3, "Séance 3"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine11_seance4'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Echauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Gainage",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Elevation Frontale",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Supination (Concentré)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(11,true,"s1.png", 4, "Séance 4"),
                  ),
                  TextComponent(text: "Semaine 12", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine12_seance1'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Etirements",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Fente Arrière Pieds Tendus",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=fodKg2BEUHY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Elevation Frontale",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Marteau Concentré",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s1.png", 1, "Séance 1"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine12_seance2'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "Séance Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Squat",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Elevation Unilateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Supination (Concentré)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s2.png", 2, "Séance 2"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine12_seance3'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          // Exercices principaux
                          Exercice(
                            titre: "SF Etirements",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
                          ),
                          Exercice(
                            titre: "SF Fente Arrière Pieds Tendus",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=fodKg2BEUHY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=17&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Elevation Frontale",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Marteau Concentré",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Vertical Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s3.png", 3, "Séance 3"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(onComplete: () => _markSessionAsCompleted('semaine12_seance4'),
                        path: widget.path, pg : "stepper_pgbbl",
                        exercice: [
                          Exercice(
                            titre: "Séance Cardio",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Squat",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Elevation Unilateral",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
                            repos: 60,
                            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Biceps Curls Supination (Concentré)",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                          ),
                          Exercice(
                            titre: "SF Tirage Nuque Triceps",
                            nombreTotalSerie: 5,
                            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(12,true,"s1.png", 4, "Séance 4"),
                  ),

                ]
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget Box(int semaine, bool isLocked,String img, int seance, titre){
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
