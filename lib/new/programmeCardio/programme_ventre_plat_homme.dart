import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExoFromProgramme.dart';

import '../../app/components/text_components.dart';
import '../../modules/monCompte/controller/controller.dart';
import '../../utils/colors.dart';
import '../LectureVideoExo/lectureVideosExo.dart';

class ProgrammeVentrePlatHomme extends StatefulWidget {
  String path;
  bool isFromAccueil;

  ProgrammeVentrePlatHomme({required this.path,required this.isFromAccueil});

  @override
  State<ProgrammeVentrePlatHomme> createState() => _ProgrammeVentrePlatHommeState();
}

class _ProgrammeVentrePlatHommeState extends State<ProgrammeVentrePlatHomme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Screen.height(context) / 1.8,
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
                              TextComponent(
                                text: "StartStrong",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                size: 15,
                              ),
                              Container(width: 20)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
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
                    bottom: 50,
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
                                        child: TextComponent(textAlign: TextAlign.start,text: "Programme de renforcement musculaire",fontWeight: FontWeight.bold,color: Colors.white,)),

                                    Container(
                                      width: Screen.width(context) / 1.3,
                                      child: Expanded(
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,spacing: 20,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(Icons.flag_circle_rounded,color: mainColor,size: 35,),
                                                TextComponent(text: "Objectifs",color: Colors.white70,fontWeight: FontWeight.bold,),
                                                TextComponent(text: "Perte de poids",color: Colors.white.withOpacity(0.7),)
                                              ],
                                            ),Column(
                                              children: [
                                                Icon(Icons.flag_circle_rounded,color: mainColor,size: 35,),
                                                TextComponent(text: "Niveau",color: Colors.white70,fontWeight: FontWeight.bold,),
                                                TextComponent(text: "Debutant",color: Colors.white.withOpacity(0.7),)
                                              ],
                                            ),Column(
                                              children: [
                                                Icon(Icons.flag_circle_rounded,color: mainColor,size: 35,),
                                                TextComponent(text: "Durée",color: Colors.white70,fontWeight: FontWeight.bold,),
                                                TextComponent(text: "5*Par sem",color: Colors.white.withOpacity(0.7),)
                                              ],
                                            ),
                                          ],
                                        ),
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
                  TextComponent(text: "Semaine 1", fontWeight: FontWeight.bold, color: mainColor, size: 14),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/trapeze.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/developper_epaules.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(false,"s1.png", 1, "Trapèze"),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(false,"s2.png", 2, "Ischio"),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/developper_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/trapeze.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(false,"s3.png", 3, "Developper Epaules"),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(false,"s1.png", 4, "Tirage Horizontal"),
                  ),

                  TextComponent(text: "Semaine 2", fontWeight: FontWeight.bold, color: mainColor, size: 14),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_fessier_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/kickback.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Fente Avant"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_fessier_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Rotation de la Hanche (Oblique)"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_fessier_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio_fessiers.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Ischio"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/tirage_poulie_basse.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Tirage Horizontal"),
                  ),


                  TextComponent(text: "Semaine 3", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/prise_marto_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/trapeze.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sauter.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Prise Marto Biceps"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio_fessiers.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_militaire_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Ischio Fessiers"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sauter.mp4",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/trapeze.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/prise_marto_biceps.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Squat Sauter"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/fente_militaire_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio_fessiers.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Soulever de terre avec Haltère"),
                  ),

                  TextComponent(text: "Semaine 4", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/kickback.mp4",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/fente_militaire_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "KickBack"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Tirage à la poulie basse Grand dorsaux"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_militaire_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/kickback.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Biceps"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Rotation de la Hanche (Oblique)"),
                  ),

                  TextComponent(text: "Semaine 5", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/developper_epaules.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Elevation Horizontale Epaules"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Ecarter aux Haltère"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/developper_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Developper Epaules"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Rotation de la Hanche (Oblique)"),
                  ),

                  TextComponent(text: "Semaine 6", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_lateral.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Crunch Lateral"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_fessier_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Tirage à la poulie Basse"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_lateral.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Rotation de la Hanche (Oblique)"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Fessier Position bébé",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_fessier_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Dips"),
                  ),


                  TextComponent(text: "Semaine 7", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_lateral.mp4",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/fente_militaire_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Crunch Lateral"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Tirage à la poulie basse Grand dorsaux"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_militaire_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_lateral.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Elevation Biceps"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Ecarter aux Haltère"),
                  ),

                  TextComponent(text: "Semaine 8", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sauter.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Soulever de terre avec Haltère"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/air_squat.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Rotation de la Hanche (Oblique)"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/squat_sauter.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Elevation Horizontale Epaules"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/air_squat.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Elevation Genoux (BDO)"),
                  ),

                  TextComponent(text: "Semaine 9", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/triceps.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Triceps"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_croise.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/air_squat.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Fente Avant"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/triceps.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Ecarter aux Haltère"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/air_squat.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                          Exercice(
                            titre: "Squat Croisé",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_croise.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Air squat"),
                  ),

                  TextComponent(text: "Semaine 10", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Developper Incliner",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/developper_incliner.mp4",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/developper_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Elevation Genoux (BDO)"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_genoux_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio_fessiers.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Rotation de la Hanche (Oblique)"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/developper_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Developper Incliner",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/developper_incliner.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Russian Twists"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio_fessiers.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Ischio Fessiers"),
                  ),

                  TextComponent(text: "Semaine 11", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/triceps.mp4",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/prise_marto_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Russian Twists"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/gainage.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Squat Sumo"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/prise_marto_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/triceps.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Elevation Lateral & Frontal"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/gainage.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Soulever de terre avec Haltère"),
                  ),

                  TextComponent(text: "Semaine 12", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_lateral.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sauter.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Crunch Lateral"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_militaire_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Ecarter aux Haltère"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/squat_sauter.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_lateral.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Biceps"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_militaire_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Elevation Genoux vers la poitrine"),
                  ),

                  TextComponent(text: "Semaine 13", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/triceps.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/gainage.mp4",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_militaire_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Triceps"),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/prise_marto_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Fente Avant"),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Fente Militaire Avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/fente_militaire_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/gainage.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/triceps.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Pompes genoux au sol"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),

                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/prise_marto_biceps.mp4",
                          ),

                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Elevation Genoux (BDO)"),
                  ),


                  TextComponent(text: "Semaine 14", fontWeight: FontWeight.bold, color: mainColor, size: 14),

                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/squat_sauter.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/trapeze.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_position_bebe.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Ecarter aux Haltère"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio_fessiers.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Russian Twists"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/trapeze.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sauter",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sauter.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Elevation Genoux Position Bébé"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/ischio_fessiers.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Ecarter aux Haltère"),
                  ),

                  TextComponent(text: "Semaine 15", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Ecarter aux Haltère"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/air_squat.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Air squat"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Front Squat"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/air_squat.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Elevation Genoux (BDO)"),
                  ),

                  TextComponent(text: "Semaine 16", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/developper_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Fente Arrière"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/kickback.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Pompes genoux au sol"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse.mp4",
                          ),
                          Exercice(
                            titre: "Developper Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/developper_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_arriere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Front Squat"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/kickback.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Russian Twists"),
                  ),

                  TextComponent(text: "Semaine 17", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/crunch_lateral.mp4",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/trapeze.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Biceps"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_lateral.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Fente Avant"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/trapeze.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_lateral.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Elevation Horizontale Epaules"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Lateral",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_lateral.mp4",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/ischio.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Front Squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/front_squat.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Crunch Lateral"),
                  ),

                  TextComponent(text: "Semaine 18", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/gainage.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Ischio"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Tirage à la poulie Basse"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/gainage.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Elevation Genoux vers la poitrine"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie Basse",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Tirage Horizontal"),
                  ),

                  TextComponent(text: "Semaine 19", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio_fessiers.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant_fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Ischio Fessiers"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/prise_marto_biceps.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Pompes genoux au sol"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/fente_avant_fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Ecarter aux Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ecarter_aux_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio_fessiers.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Elevation Lateral & Frontal"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/prise_marto_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Prise Marto Biceps"),
                  ),

                  TextComponent(text: "Semaine 20", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/prise_marto_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Elevation Genoux vers la poitrine"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/air_squat.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant_fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Elevation Horizontale Epaules"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Dips",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/dips.mp4",
                          ),
                          Exercice(
                            titre: "Prise Marto Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/prise_marto_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Dips"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Lateral & Frontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_lateral_frontal.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/fente_avant_fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/air_squat.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Elevation Lateral & Frontal"),
                  ),


                  TextComponent(text: "Semaine 21", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Fente Avant"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/trapeze.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/air_squat.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Soulever de terre avec Haltère"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Elevation Horizontale Epaules"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Air squat",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/air_squat.mp4",
                          ),
                          Exercice(
                            titre: "Tirage Horizontal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/tirage_horizontal.mp4",
                          ),
                          Exercice(
                            titre: "Trapèze",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/trapeze.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Soulever de terre avec Haltère",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/soulever_de_terre_avec_haltere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Air squat"),
                  ),

                  TextComponent(text: "Semaine 22", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Developper Incliner",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/developper_incliner.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Elevation Genoux vers la poitrine"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant_fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/ischio_fessiers.mp4",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio.mp4",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/triceps.mp4",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/kickback.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Fente Avant Fente Arrière"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/fente_avant.mp4",
                          ),
                          Exercice(
                            titre: "Developper Incliner",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/developper_incliner.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux vers la poitrine",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_vers_la_poitrine.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Pompes genoux au sol"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/kickback.mp4",
                          ),
                          Exercice(
                            titre: "Triceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/triceps.mp4",
                          ),
                          Exercice(
                            titre: "Ischio",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio.mp4",
                          ),
                          Exercice(
                            titre: "Ischio Fessiers",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/ischio_fessiers.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant_fente_arriere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "KickBack"),
                  ),

                  TextComponent(text: "Semaine 23", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_position_bebe.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/fente_avant_fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Elevation Genoux Position Bébé"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/kickback.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Pompes genoux au sol"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux (BDO)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/elevation_genoux_bdo.mp4",
                          ),
                          Exercice(
                            titre: "Rotation Hanche Oblique Assis",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique_assis.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant_fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Genoux Position Bébé",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_genoux_position_bebe.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Squat Sumo"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Russian Twists",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/russian_twists.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "KickBack",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/kickback.mp4",
                          ),
                          Exercice(
                            titre: "Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/biceps.mp4",
                          ),
                          Exercice(
                            titre: "Pompes genoux au sol",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/pompes_genoux_au_sol.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Russian Twists"),
                  ),

                  TextComponent(text: "Semaine 24", fontWeight: FontWeight.bold, color: mainColor, size: 14),

// Séance 1
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/gainage.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 1, "Rotation de la Hanche (Oblique)"),
                  ),

// Séance 2
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant_fente_arriere.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s2.png", 2, "Fente Avant Fente Arrière"),
                  ),

// Séance 3
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 1",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Biceps",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_biceps.mp4",
                          ),
                          Exercice(
                            titre: "Tirage à la poulie basse Grand dorsaux",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/tirage_poulie_basse_grand_dorsaux.mp4",
                          ),
                          Exercice(
                            titre: "Gainage",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/gainage.mp4",
                          ),
                          Exercice(
                            titre: "Quadriceps",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/quadriceps.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s3.png", 3, "Elevation Biceps"),
                  ),

// Séance 4
                  InkWell(
                    onTap: () {
                      widget.isFromAccueil? showToast(context, "Cette vidéo est Bloquée", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => LectureVideosExoFromProgram(
                        path: widget.path, pg : "powerband_pgcardio",
                        exercice: [
                          Exercice(
                            titre: "Echauffement 2",
                            nombreTotalSerie: 1,
                            seriesConfigs: [SerieConfig(repetitions: 1)],
                            repos: 0,
                            linkVideo: "assets/videos/echauffement.mp4",
                          ),
                          Exercice(
                            titre: "Elevation Horizontale Epaules",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/elevation_horizontale_epaules.mp4",
                          ),
                          Exercice(
                            titre: "Squat Sumo",
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 8),
                              SerieConfig(repetitions: 8),
                            ],
                            repos: 75,
                            linkVideo: "assets/videos/squat_sumo.mp4",
                          ),
                          Exercice(
                            titre: "Rotation de la Hanche (Oblique)",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/rotation_hanche_oblique.mp4",
                          ),
                          Exercice(
                            titre: "Crunch Abdominal",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/crunch_abdominal.mp4",
                          ),
                          Exercice(
                            titre: "Fente Avant Fente Arrière",
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 60,
                            linkVideo: "assets/videos/fente_avant_fente_arriere.mp4",
                          ),
                        ],
                      )));
                    },
                    child: Box(true,"s1.png", 4, "Elevation Horizontale Epaules"),
                  ),



                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget Box(bool isLocked,String img, int seance, titre){
    if(!widget.isFromAccueil){
      isLocked=false;
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
            Icon(isLocked?Icons.lock: Icons.check_circle_outlined,color: Colors.grey,size: 35,)
          ],
        ),
      ),
    );
  }
}
