import 'package:flutter/material.dart';
import 'package:fitness_app/app/components/text_components.dart';
import 'package:fitness_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/monCompte/controller/controller.dart';
import '../LectureVideoExo/lectureVideosExo.dart';

class BibliothequeStepper extends StatefulWidget {
  bool isFromAccueil;
  BibliothequeStepper({required this.isFromAccueil});

  @override
  State<BibliothequeStepper> createState() => _BibliothequeStepperState();
}

class _BibliothequeStepperState extends State<BibliothequeStepper> {

  late SharedPreferences _prefs;
  final Set<String> _completedExercises = {};

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadCompletedExercises();
  }

  void _loadCompletedExercises() {
    Set<String> completedExercises = _prefs.getStringList('completedExercises_stepper')?.toSet() ?? {};
    setState(() {
      _completedExercises.addAll(completedExercises);
    });
  }

  void _markExerciseAsCompleted(String exerciseName) {
    setState(() {
      _completedExercises.add(exerciseName);
      _prefs.setStringList('completedExercises_stepper', _completedExercises.toList());
    });
  }

  bool _isExerciseCompleted(String exerciseName) {
    return _completedExercises.contains(exerciseName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: TextComponent(text: "Exercices",color: Colors.white,size: 16,fontWeight: FontWeight.bold,),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: 14,right: 14,top: 15),child: TextComponent(text: "Bibliotheque d'exercice",fontWeight: FontWeight.w600,size: 14.5,)),
            Padding(padding: EdgeInsets.only(left: 14,right: 14),child: TextComponent(text: "Retrouvez les exercices ici",fontWeight: FontWeight.w600,size: 14.5,color: mainColor,)),
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                child: ExpansionTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage("assets/images/dos.png"),fit: BoxFit.cover)
                    ),
                  ),
                  title: TextComponent(
                    text: "Groupe Musculaire",size: 14,
                  ),
                  subtitle: TextComponent(text: "Dos",fontWeight: FontWeight.bold,),
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Rowing en Unilateral')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=YXmc_dNjvJU&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=6&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Rowing en Unilateral', 'Explication du SH Rowing en Unilateral', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Rowing')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 15),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=dltc4AvyugU&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=5&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Rowing', 'Explication du SH Rowing', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Tirage Horizontal')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Tirage Horizontal', 'Explication du SF Tirage Horizontal', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Rowing')
                            ,nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Rowing', 'Explication du SF Rowing', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Rowing Buste Penché')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=MUkMFCKwuOQ&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=26&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Rowing Buste Penché', 'Explication du SF Rowing Buste Penché', '5min',false)),
                    ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                child: ExpansionTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage("assets/images/pectoraux.png"),fit: BoxFit.cover)
                    ),
                  ),
                  title: TextComponent(
                    text: "Groupe Musculaire",size: 14,
                  ),
                  subtitle: TextComponent(text: "Poitrine",fontWeight: FontWeight.bold,),
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Elevation Unilateral Poitrine')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=K0UoUgcrVEs&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=11&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Elevation Unilateral Poitrine', 'Explication du SH Elevation Unilateral Poitrine', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Poitrine Prise Serré')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=-CH7PQf3LWg&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=20&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Poitrine Prise Serré', 'Explication du SH Poitrine Prise Serré', '5min',false)),
                    ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                child: ExpansionTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage("assets/images/biceps.png"),fit: BoxFit.cover)
                    ),
                  ),
                  title: TextComponent(
                    text: "Groupe Musculaire",size: 14,
                  ),
                  subtitle: TextComponent(text: "Biceps",fontWeight: FontWeight.bold,),
                  children: [
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Biceps Prise Serré')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=8N0w-OHQTwM&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=17&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Biceps Prise Serré', 'Explication du SH Biceps Prise Serrés', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Biceps Curls Unilateral')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=LgE_4WrDvi0&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=19&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Biceps Curls Unilateral', 'Explication du SH Biceps Curls Unilateral', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Biceps Curls')
                            ,nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1,),
                              SerieConfig(repetitions: 1,),
                              SerieConfig(repetitions: 1,),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=uOIDhnX1U0U&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=12&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Biceps Curls', 'Explication du SF Biceps Curls', '5min',true)),
                    // _buildExerciseItem('Biceps Curl Poulie Basse', 'Explication du Biceps Curl Poulie Basse', '5min',true),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Biceps Curls Marteau Concentré')
                            ,nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Biceps Curls Marteau Concentré', 'Explication du SF Biceps Curls Marteau Concentré', '5min',true)),
                  InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Biceps Curls Supination (Concentré)')
                            ,nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Biceps Curls Supination (Concentré)', 'Explication du SF Biceps Curls Supination (Concentré)', '5min',true)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                child: ExpansionTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage("assets/images/triceps.png"),fit: BoxFit.cover)
                    ),
                  ),
                  title: TextComponent(
                    text: "Groupe Musculaire",size: 14,
                  ),
                  subtitle: TextComponent(text: "Triceps",fontWeight: FontWeight.bold,),
                  children: [
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Triceps Unilateral')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=t6FmvlqJ1l4&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=2&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Triceps Unilateral', 'Explication du SH Triceps Unilateral', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Elevation Nuque')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Lw_0Gc3lL5Y&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('SH Elevation Nuque', 'Explication du SH Elevation Nuque', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Tirage Vertical Triceps')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('SF Tirage Vertical Triceps', 'Explication du SF Tirage Vertical Triceps', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Tirage Nuque Triceps')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Tirage Nuque Triceps', 'Explication du SF Tirage Nuque Triceps', '5min',true)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                child: ExpansionTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage("assets/images/epaules.png"),fit: BoxFit.cover)
                    ),
                  ),
                  title: TextComponent(
                    text: "Groupe Musculaire",size: 14,
                  ),
                  subtitle: TextComponent(text: "Epaules",fontWeight: FontWeight.bold,),
                  children: [
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Elevation Laterale')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Wf3s-TBYTPs&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=13&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Elevation Laterale', 'Explication du SH Elevation Laterale', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Developper Militaire Unilateral')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Omz9t2Z5pbQ&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=8&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Developper Militaire Unilateral', 'Explication du SH Developper Militaire Unilateral', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Elevation Frontale')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=dEHpq3GPYrU&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=16&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Elevation Frontale', 'Explication du SH Elevation Frontale', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Elevation Unilateral')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('SF Elevation Unilateral', 'Explication du SF Elevation Unilateral', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Elevation Frontale')
                            ,nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1),
                              SerieConfig(repetitions: 1),
                              SerieConfig(repetitions: 1),
                              SerieConfig(repetitions: 1),
                              SerieConfig(repetitions: 1),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Elevation Frontale', 'Explication du SF Elevation Frontale', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Tirage Menton')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1),
                              SerieConfig(repetitions: 1),
                              SerieConfig(repetitions: 1),
                              SerieConfig(repetitions: 1),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('SF Tirage Menton', 'Explication du SF Tirage Menton', '5min',true)),

                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                child: ExpansionTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage("assets/images/jambe.jpg"),fit: BoxFit.cover)
                    ),
                  ),
                  title: TextComponent(
                    text: "Groupe Musculaire",size: 14,
                  ),
                  subtitle: TextComponent(text: "Jambes",fontWeight: FontWeight.bold,),
                  children: [
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Leg Extension')
                            ,nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=tLbxDzwqZ3Y&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=1&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Leg Extension', 'Explication du SH Leg Extension', '5min',true)),
                    // _buildExerciseItem('Adduction', 'Explication de l\'Adduction', '5min',true),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Squat Militaire')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=B-YoGyFmezw&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=4&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Squat Militaire', 'Explication du SH Squat Militaire', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Squat')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6l17H_4Lugs&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=3&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Squat', 'Explication du SH Squat', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Fente Arriere Pieds Flechis')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=DBy_d7jeT-w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=18&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Fente Arriere Pieds Flechis', 'Explication du SF Fente Arriere Pieds Flechis', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Fente Arrière Pieds Tendus')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=fodKg2BEUHY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=17&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Fente Arrière Pieds Tendus', 'Explication du SF Fente Arrière Pieds Tendus', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Leg Extension Lateral')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Leg Extension Lateral', 'Explication du SF Leg Extension Lateral', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Squat en Unilateral')
                            ,nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=NERG2rQHUIw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=8&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Squat en Unilateral', 'Explication du SF Squat en Unilateral', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Squat')
                            ,nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Squat', 'Explication du SF Squat', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Leg Extension')
                            ,nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=tLbxDzwqZ3Y&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=1&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Leg Extension', 'Explication du SH Leg Extension', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Fente Arrière')
                            ,nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=jF5QMvvRA1w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=24&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Fente Arrière', 'Explication du SF Fente Arrière', '5min',true)),
                     ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                child: ExpansionTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage("assets/images/abdo.png"),fit: BoxFit.cover)
                    ),
                  ),
                  title: TextComponent(
                    text: "Groupe Musculaire",size: 14,
                  ),
                  subtitle: TextComponent(text: "Abdominaux",fontWeight: FontWeight.bold,),
                  children: [
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Elevation Jambes Ecartées')
                            ,nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=-5bwM9pCtF0&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=14&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('SH Elevation Jambes Ecartées', 'Explication du SH Elevation Jambes Ecartées', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Elevation Genoux Vers Poitrine')
                            ,nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=EIBKJxnTB48&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=15&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Elevation Genoux Vers Poitrine', 'Explication du SH Elevation Genoux Vers Poitrine', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SH Montain Climber')
                            ,nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=nz7Kh71LTOk&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=9&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SH Montain Climber', 'Explication du SH Montain Climber', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted("SH Planche de l'ours")
                            ,nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=x398EzNOLQM&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=1&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem("SH Planche de l'ours", "Explication SH Planche de l'ours", '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Montain Climber')
                            ,nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=9yQ_gRi1Q7A&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=15&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Montain Climber', 'Explication du SF Montain Climber', '5min',true)),

                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Tirage Rotation Oblique')
                            ,nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=bzCKZ961VgU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=3&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Tirage Rotation Oblique', 'Explication du SF Tirage Rotation Oblique', '5min',true)),
                    InkWell(

                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Crunch Abdominal')
                            ,nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=N_fcDK2sBes&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=23&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Crunch Abdominal', 'Explication du SF Crunch Abdominal', '5min',true)),

                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Spiderman')
                            ,nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=tKGEnkZmRF4&list=PL27ZZQGb4VdwcvABLhri1uUGy_YjIo08g&index=18&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Spiderman', 'Explication du Spiderman', '5min',true),),

                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Gainage')
                            ,nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Gainage', 'Explication du SF Gainage', '5min',true)),
                    // _buildExerciseItem('SF Gainage', 'Explication du SF Gainage', '5min',true),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                child: ExpansionTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage("assets/images/fessier.jpg"),fit: BoxFit.cover)
                    ),
                  ),
                  title: TextComponent(
                    text: "Groupe Musculaire",size: 14,
                  ),
                  subtitle: TextComponent(text: "Fessier",fontWeight: FontWeight.bold,),
                  children: [
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Soulever de Terre Roumain')
                            ,nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Soulever de Terre Roumain', 'Explication du SF Soulever de Terre Roumain', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('SF Leg Extension Lateral')
                            ,nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('SF Leg Extension Lateral', 'Explication du SF Leg Extension Lateral', '5min',true)),

                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
  Widget _buildExerciseItem(String title, String description, String duration, bool locked) {
    if(!widget.isFromAccueil){
      locked=false;
    }
    return Column(
      children: [
        Divider(color: Colors.black26.withOpacity(0.1),),
        ListTile(
          leading: Container(
              height: 45,width: 45,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey,width: 1.3),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Icon(Icons.play_circle_sharp,color: Colors.blueGrey,)
          ),
          title: TextComponent(
            text: title,size: 13.5,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.90),textAlign: TextAlign.start,
          ),
          subtitle: TextComponent(text: description,textAlign: TextAlign.start,),
          trailing: Column(crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 7,
            children: [
              Icon(locked? Icons.lock : _isExerciseCompleted(title) ? Icons.check_circle : Icons.check_circle_outline,color: mainColor,),
              // Icon(locked? Icons.lock : Icons.check_circle,color: mainColor,),
              Container(
                color: mainColor.withOpacity(0.5),
                padding: EdgeInsets.all(3),
                child: TextComponent(text: "5 min",color: Colors.white,size: 11,),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Exercise {
  final String title;
  final String subtitle;
  final String duration;
  bool isChecked;

  Exercise({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.isChecked,
  });
}

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(Icons.play_circle_outline, color: Colors.blue),
        title: Text(
          exercise.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(exercise.subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                exercise.duration,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 16),
            Checkbox(
              value: exercise.isChecked,
              onChanged: (value) {
                // Mettre à jour l'état de la case à cocher
                exercise.isChecked = value ?? false;
              },
            ),
          ],
        ),
      ),
    );
  }
}