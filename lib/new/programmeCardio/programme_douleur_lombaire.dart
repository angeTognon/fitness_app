import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExoFromProgramme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/components/text_components.dart';
import '../../modules/monCompte/controller/controller.dart';
import '../../utils/colors.dart';
import '../LectureVideoExo/lectureVideosExo.dart';
import '../instruction/presentationQuardioQuad.dart';

class ProgrammeDouleurLombaire extends StatefulWidget {
  String path;
  bool isFromAccueil;

  ProgrammeDouleurLombaire({required this.path,required this.isFromAccueil});

  @override
  State<ProgrammeDouleurLombaire> createState() => _ProgrammeDouleurLombaireState();
}

class _ProgrammeDouleurLombaireState extends State<ProgrammeDouleurLombaire> {
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
                children: [
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance1'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Échauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "Assis en Tailleur",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage Latéral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement le long du corps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Étirements Jambes sur Grand Fessier",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s1.png", 1, "Séance 1"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance2'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Échauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "Gainage lombaire GD",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tension Lombaire",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Lombaire Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement du Bas du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Étirement du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s2.png", 2, "Séance 2"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance3'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Échauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "Assouplissement du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage Latéral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assis en Tailleur",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Étirements Jambes sur Grand Fessier",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement le long du corps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(1,false,"s3.png", 3, "Séance 3"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine1_seance4'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Échauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "Étirement du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage lombaire GD",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement du Bas du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Lombaire Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tension Lombaire",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
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
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(2,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQBassets/videos/echauffement.mp4",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(2,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(2,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine2_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
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
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(3,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Étirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(3,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(3,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine3_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
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
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(4,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(4,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Étirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(4,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine4_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
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
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(5,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(5,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(5,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine5_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
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
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(6,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(6,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(6,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine6_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(6,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),

                  TextComponent(text: "Semaine 7", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance1'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Échauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "Tension Lombaire",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Étirements Jambes sur Grand Fessier",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Lombaire Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assis en Tailleur",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement le long du Corps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s1.png", 1, "Séance 1"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance2'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Échauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "Gainage Latéral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Bas du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement le long du Corps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement du Bas du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s2.png", 2, "Séance 2"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance3'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Échauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "Assouplissement le long du Corps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tension Lombaire",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Lombaire Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Étirements Jambes sur Grand Fessier",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assis en Tailleur",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s3.png", 3, "Séance 3"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine7_seance4'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Échauffement",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                          ),
                          // Exercices principaux
                          Exercice(
                            titre: "Assouplissement le long du Corps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Bas du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage Latéral",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement du Bas du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(7,true,"s1.png", 4, "Séance 4"),
                  ),
                  TextComponent(text: "Semaine 8", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(8,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(8,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(8,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(8,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 9", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine8_seance5'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(9,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine9_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(9,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine9_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(9,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine9_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(9,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 10", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine10_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(10,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine10_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Étirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(10,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine10_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(10,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine10_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Étirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(10,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 11", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine11_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(11,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine11_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(11,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine11_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(11,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine11_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(11,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 12", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine12_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(12,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine12_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(12,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine12_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(12,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine12_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "assets/videos/echauffement.mp4",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(12,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 13", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine13_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(13,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine13_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(13,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine13_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                            ],
                          )));
                        },
                        child: Box(13,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine13_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(13,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 14", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine14_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(14,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine14_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                            ],
                          )));
                        },
                        child: Box(14,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine14_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Latéral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(14,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine14_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Échauffement",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=vZgOY7hP1R8&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=15&pp=iAQB",
                              ),
                              // Exercices principaux
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "ahttps://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Étirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(14,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 15", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine15_seance1'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Tirage Bas du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assis en Tailleur",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tension Lombaire",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Lombaire Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(15,true,"s1.png", 1, "Séance 1"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine15_seance2'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Gainage lombaire GD",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Etirement du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement le long du Corps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Etirements Jambes sur Grand Fessier",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(15,true,"s2.png", 2, "Séance 2"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine15_seance3'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Assis en Tailleur",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Rotation Lombaire Assis",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tension Lombaire",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Tirage Bas du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(15,true,"s3.png", 3, "Séance 3"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine15_seance4'),
                        path: widget.path, pg : "cardio_pgdouleur",
                        exercice: [
                          // Échauffement
                          Exercice(
                            titre: "Rotation du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Assouplissement le long du Corps",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Gainage lombaire GD",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Etirements Jambes sur Grand Fessier",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                          ),
                          Exercice(
                            titre: "Etirement du Dos",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                          ),
                        ],
                      )));
                    },
                    child: Box(15,true,"s1.png", 4, "Séance 4"),
                  ),
                  TextComponent(text: "Semaine 16", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine16_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(16,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine16_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(16,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine16_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(16,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine16_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(16,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 17", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine17_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(17,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine17_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(17,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine17_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Etirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(17,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine17_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(17,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 18", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine18_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(18,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine18_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(18,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine18_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(18,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine18_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Etirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(18,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 19", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine19_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(19,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine19_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(19,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine19_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(19,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine19_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(19,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 20", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine20_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(20,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine20_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(20,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine20_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Gainage lombaire GD",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=n6-6sALj1Ps&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=12&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(20,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine20_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(20,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 21", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine21_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(21,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine21_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(21,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine21_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(21,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine21_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(21,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 22", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine22_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(22,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine22_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(22,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine22_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(22,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine22_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                            ],
                          )));
                        },
                        child: Box(22,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 23", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine23_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(23,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine23_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Etirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=peVdPS5hieY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=5&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(23,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine23_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Gainage Lateral",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=3L5pMZQDRNs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=13&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                            ],
                          )));
                        },
                        child: Box(23,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine23_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=csjnIDvDVyY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=16&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=t4SuJoQDUDY&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=11&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(23,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),
                  TextComponent(text: "Semaine 24", fontWeight: FontWeight.bold, color: mainColor, size: 14),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine24_seance1'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(24,true,"s1.png", 1, "Séance 1"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine24_seance2'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=ygaJca4xol0&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=4&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(24,true,"s2.png", 2, "Séance 2"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine24_seance3'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Tirage Vertical",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=zxIXeKzoLPI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=8&pp=iAQB0gcJCYQJAYcqIYzv",
                              ),
                              Exercice(
                                titre: "Tension Lombaire",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=7dFeSGR4Vb4&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=9&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du Corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirements Jambes sur Grand Fessier",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=TvNaDkq6bVI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=14&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Etirement du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=2ohBu4Glg58&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=3&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(24,true,"s3.png", 3, "Séance 3"),
                      ),
                      InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        onComplete: () => _markSessionAsCompleted('semaine24_seance4'),
                            path: widget.path, pg : "cardio_pgdouleur",
                            exercice: [
                              // Échauffement
                              Exercice(
                                titre: "Assis en Tailleur",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=U2jEdkYJEGw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=7&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Tirage Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=4wyMfMachBw&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=2&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement du Bas du Dos",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=17pVZZKIsvs&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=6&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Rotation Lombaire Assis",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=pw2_P63U8fI&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=10&pp=iAQB",
                              ),
                              Exercice(
                                titre: "Assouplissement le long du corps",
                                nombreTotalSerie: 1,
                                seriesConfigs: [SerieConfig(repetitions: 1)],
                                repos: 0,
                                linkVideo: "https://www.youtube.com/watch?v=YL5F9lmGNdk&list=PL9GsY7tWZQwE5dqbMTWRE3dnBsCrqz9fA&index=1&pp=iAQB",
                              ),
                            ],
                          )));
                        },
                        child: Box(24,true,"s1.png", 4, "Séance 4"),
                      ),
                    ],
                  ),

                ]
              ),
            )
          ],
        ),
      ),
    );
  }

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
    Set<String> completedSessions = _prefs.getStringList('completedSessions_pgdouleur_cardio')?.toSet() ?? {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList('completedSessions_pgdouleur_cardio', _completedSessions.toList());
    });
  }

  bool _isSessionCompleted(String sessionName) {
    return _completedSessions.contains(sessionName);
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
