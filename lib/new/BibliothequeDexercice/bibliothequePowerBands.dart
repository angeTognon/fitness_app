import 'package:flutter/material.dart';
import 'package:fitness_app/app/components/text_components.dart';
import 'package:fitness_app/modules/monCompte/controller/controller.dart';
import 'package:fitness_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LectureVideoExo/lectureVideosExo.dart';

class BibliothequePowerBands extends StatefulWidget {
  bool isFromAccueil;
  BibliothequePowerBands({required this.isFromAccueil});

  @override
  State<BibliothequePowerBands> createState() => _BibliothequePowerBandsState();
}

class _BibliothequePowerBandsState extends State<BibliothequePowerBands> {


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
    Set<String> completedExercises = _prefs.getStringList('completedExercises_powerband')?.toSet() ?? {};
    setState(() {
      _completedExercises.addAll(completedExercises);
    });
  }

  void _markExerciseAsCompleted(String exerciseName) {
    setState(() {
      _completedExercises.add(exerciseName);
      _prefs.setStringList('completedExercises_powerband', _completedExercises.toList());
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
                            onComplete: () => _markExerciseAsCompleted('Face Pull'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=-4RCM-1d8SI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=14&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Face Pull', 'Explication du Face Pull', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Pull Over'),
                            nombreTotalSerie: 3,
                            isVertical: true,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                              SerieConfig(repetitions: 20, charge: 40),
                              // SerieConfig(repetitions: 15, charge: 30),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Pull Over', 'Explication du Pull Over', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Rowing Buste Penché'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Rowing Buste Penché', 'Explication du Rowing Buste Penché', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Soulevé de terre'),
                            nombreTotalSerie: 4,
                            isVertical: true,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 6, charge: 140),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=ZjAMtITHkRA&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=34&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Soulevé de terre', 'Explication du Soulevé de terre', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Tirage Horizontal prise large'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 12, charge: 100),
                              SerieConfig(repetitions: 10, charge: 110),
                              SerieConfig(repetitions: 8, charge: 120),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Tirage Horizontal prise large', 'Explication du Tirage Horizontal prise large', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Tirage Horizontal Unilateral'),
                            nombreTotalSerie: 4,
                            isVertical: true,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Tirage Horizontal Unilateral', 'Explication du Tirage Horizontal Unilateral', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            isVertical: true,
                            onComplete: () => _markExerciseAsCompleted('Tirage Poulie Haute Unilateral'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 12, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=yHdD-2CsZd0&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=47&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Tirage Poulie Haute Unilateral', 'Explication du Tirage Poulie Haute Unilateral', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            isVertical: true,
                            onComplete: () => _markExerciseAsCompleted('Tirage poulie Moyenne'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=sIvIklsKUCw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=48&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Tirage poulie Moyenne', 'Explication du Tirage poulie Moyenne', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Tirage Vertical'),
                            nombreTotalSerie: 4,
                            isVertical: true,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Bx2rvE2-BVI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=45&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Tirage Vertical', 'Explication du Tirage Vertical', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Tirage Vertical Prise Serrée'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=tGiGIhczJ9Q&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=46&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Tirage Vertical Prise Serrée', 'Explication du Tirage Vertical Prise Serrée', '5min',false)),
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
                  subtitle: TextComponent(text: "Pectoraux",fontWeight: FontWeight.bold,),
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Développé à la poulie'),
                            nombreTotalSerie: 4,
                            isVertical: true,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 70),
                              SerieConfig(repetitions: 10, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=31&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Développé à la poulie', 'Explication du Développé à la poulie', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Développé incliné'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 70),
                              SerieConfig(repetitions: 10, charge: 70),
                              SerieConfig(repetitions: 8, charge: 80),
                              SerieConfig(repetitions: 8, charge: 80),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=9&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Développé incliné', 'Explication du Développé incliné', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Développé Joint'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=E8vgLRa-HU0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=25&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('Développé Joint', 'Explication du Développé Joint', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Ecarté Poulie Basse'),
                            nombreTotalSerie: 4,
                            isVertical: true,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=lJZqNu8jJEw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=31&ab_channel=fitness_app",
                          ),));
                        },
                        child: _buildExerciseItem('Ecarté Poulie Basse', 'Explication de Ecarté Poulie Basse', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Ecarté Poulie Haute'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 20, charge: 30),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Ecarté Poulie Haute', 'Explication de Ecarté Poulie Haute', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Ecarté Unilateral'),
                            isVertical: true,
                            nombreTotalSerie: 2,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 12, charge: 50),
                              // SerieConfig(repetitions: 15, charge: 30),
                              // SerieConfig(repetitions: 20, charge: 30),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=zAfnnw1-3rc&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=37&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Ecarté Unilateral', 'Explication de Ecarté Unilateral', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Pompes Lestées /Pompes Genoux sol/Pompe normal'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 0),
                              SerieConfig(repetitions: 10, charge: 0),
                              SerieConfig(repetitions: 10, charge: 0),
                              SerieConfig(repetitions: 10, charge: 0),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=ZxqLK7FOp3A&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=19&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Pompes Lestées /Pompes Genoux sol/Pompe normal', 'Explication Pompes Lestées /Pompes Genoux sol/Pompe normal', '5min',false)),
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
                            onComplete: () => _markExerciseAsCompleted('Biceps Curls'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                              SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=33&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Biceps Curls', 'Explication du Biceps Curls', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('F-biceps curl poulie Basse'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=uZiunifMoh4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=31&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('F-biceps curl poulie Basse', 'Explication du F-biceps curl poulie Basse', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Biceps Curl Prise Marteau'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 12, charge: 20),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=tL0ihj9VtlM&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=23&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Biceps Curl Prise Marteau', 'Explication du Biceps Curl Prise Marteau', '5min',true)),
                    // _buildExerciseItem('Biceps Curl Poulie Basse', 'Explication du Biceps Curl Poulie Basse', '5min',true),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Biceps Curl Prise Pronation'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=VKZBNQCYebM&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=22&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Biceps Curl Prise Pronation', 'Explication du Biceps Curl Prise Pronation', '5min',true)),
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
                            onComplete: () => _markExerciseAsCompleted('Triceps Barre au Front'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=9aMKzSbLBf4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=44&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Triceps Barre au Front', 'Explication du Triceps Barre au Front', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Triceps extension Verticale'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=RbA_omOwd34&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=49&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Triceps extension Verticale', 'Explication du Triceps extension Verticale', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Triceps Extension Poulie haute'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=zS1MBnRvSzk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=15&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Triceps Extension Poulie haute', 'Explication du Triceps Extension Poulie haute', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Triceps KickBack unilatérale'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 12, charge: 10),
                              // SerieConfig(repetitions: 10, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=fm2dGhQLGYY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=10&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Triceps KickBack unilatérale ', 'Explication du Triceps KickBack unilatérale', '5min',true)),
                    /*InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Triceps KickBack'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 12, charge: 10),
                              // SerieConfig(repetitions: 10, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=fm2dGhQLGYY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=10&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Triceps KickBack', 'Explication du Triceps KickBack', '5min',true)),*/
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
                            onComplete: () => _markExerciseAsCompleted('Développé Militaire Assis'),
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 12, charge: 60),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=tVl3UevC7vQ&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=39&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Développé Militaire Assis', 'Explication du Développé Militaire Assis', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Élévations Frontales'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 10),
                              SerieConfig(repetitions: 12, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              // SerieConfig(repetitions: 8, charge: 100),
                              // SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=7KjhhHUtg8k&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=32&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Élévations Frontales', 'Explication des Élévations Frontales', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Élévations Latérales'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              SerieConfig(repetitions: 15, charge: 20),
                              // SerieConfig(repetitions: 8, charge: 100),
                              // SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('Élévations Latérales', 'Explication des Élévations Latérales', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Face Pull'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=-4RCM-1d8SI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=14&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Face Pull', 'Explication du Face Pull', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Oiseau'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 8, charge: 100),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=PQrxt7RCtQ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=21&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Oiseau', 'Explication de l\'Oiseau', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Overhead Press'),
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
                          ),));
                        },
                        child: _buildExerciseItem('Overhead Press', 'Explication de l\'Overhead Press', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Tirage Menton'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 10, charge: 40),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=ER1evvpKjPA&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=14&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Tirage Menton', 'Explication du Tirage Menton', '5min',true)),
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
                            onComplete: () => _markExerciseAsCompleted('Abduction'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Abduction', 'Explication de l\'Abduction', '5min',true)),
                    // _buildExerciseItem('Adduction', 'Explication de l\'Adduction', '5min',true),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Donkey Kick'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 10, charge: 30),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Donkey Kick', 'Explication du Donkey Kick', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Extension Mollet'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              SerieConfig(repetitions: 15, charge: 0),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Extension Mollet', 'Explication de l\'Extension Mollet', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Fentes'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 80),
                              SerieConfig(repetitions: 8, charge: 120),
                              SerieConfig(repetitions: 6, charge: 160),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Fentes', 'Explication des Fentes', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Fentes Bulgares'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 8, charge: 60),
                              SerieConfig(repetitions: 8, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=XRe0TP4y6A4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=36&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Fentes Bulgares', 'Explication des Fentes Bulgares', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Fentes Rebonds'),
                            nombreTotalSerie: 2,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              // SerieConfig(repetitions: 8, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Fentes Rebonds', 'Explication des Fentes Rebonds', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Front Squat'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 12, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Front Squat', 'Explication du Front Squat', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Hip Thrust'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 10, charge: 80),
                              SerieConfig(repetitions: 8, charge: 100),
                              SerieConfig(repetitions: 8, charge: 100),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=1vOQNPzXdZo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=13&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Hip Thrust', 'Explication du Hip Thrust', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Leg Curl'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              // SerieConfig(repetitions: 8, charge: 100),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=YjzWXDSyUsI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=5&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Leg Curl', 'Explication du Leg Curl', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Leg Extension'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              SerieConfig(repetitions: 15, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 100),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Leg Extension', 'Explication du Leg Extension', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Soulevé de Terre'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 12, charge: 40),
                              SerieConfig(repetitions: 10, charge: 40),
                              // SerieConfig(repetitions: 8, charge: 100),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=ZjAMtITHkRA&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=34&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Soulevé de Terre', 'Explication du Soulevé de Terre', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Squat'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 40),
                              SerieConfig(repetitions: 10, charge: 50),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 8, charge: 70),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Squat', 'Explication du Squat', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Squat Swing'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 10, charge: 60),
                              SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=sKPpu3KX4fM&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=17&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Squat Swing', 'Explication du Squat Swing', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Squat Sumo'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              SerieConfig(repetitions: 15, charge: 30),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=YA8Mg099KMQ&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=18&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Squat Sumo', 'Explication du Squat Sumo', '5min',true)),
                  ],
                ),
              ),
            ),Padding(
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
                            onComplete: () => _markExerciseAsCompleted('Crunch Bicyclette'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=xKEC4lT4044&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=41&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Crunch Bicyclette', 'Explication du Crunch Bicyclette', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Crunch Poulie Haute'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              SerieConfig(repetitions: 12, charge: 30),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=h1vEtJhyDes&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=6&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Crunch Poulie Haute', 'Explication du Crunch Poulie Haute', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Crunch Rameur'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                              SerieConfig(repetitions: 15, charge: 10),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=2tkSHnbVNlc&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=1&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Crunch Rameur', 'Explication du Crunch Rameur', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Flexion Latérale Oblique'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 20),
                              SerieConfig(repetitions: 12, charge: 20),
                              SerieConfig(repetitions: 12, charge: 20),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6jlAeMmHico&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=11&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Flexion Latérale Oblique', 'Explication de la Flexion Latérale Oblique', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Leg Raise'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12, charge: 0),
                              SerieConfig(repetitions: 12, charge: 10),
                              SerieConfig(repetitions: 10, charge: 20),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=b-1IdDUyJho&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=33&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Leg Raise', 'Explication du Leg Raise', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Mountain Climber'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=E73ZGk7O_ag&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=5&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('Mountain Climber', 'Explication du Mountain Climber', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('Spiderman'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              SerieConfig(repetitions: 10, charge: 20),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Muit-Ys3q5Y&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=19&pp=iAQB",
                          ),));
                        },
                        child:  _buildExerciseItem('Spiderman', 'Explication du Spiderman', '5min',true),),

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