import 'package:flutter/material.dart';
import 'package:fitness_app/app/components/text_components.dart';
import 'package:fitness_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/monCompte/controller/controller.dart';
import '../LectureVideoExo/lectureVideosExo.dart';

class BibliothequePowerFit extends StatefulWidget {
  bool isFromAccueil;
   BibliothequePowerFit({required this.isFromAccueil});

  @override
  State<BibliothequePowerFit> createState() => _BibliothequePowerFitState();
}

class _BibliothequePowerFitState extends State<BibliothequePowerFit> {

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
    Set<String> completedExercises = _prefs.getStringList('completedExercises_powerfit')?.toSet() ?? {};
    setState(() {
      _completedExercises.addAll(completedExercises);
    });
  }

  void _markExerciseAsCompleted(String exerciseName) {
    setState(() {
      _completedExercises.add(exerciseName);
      _prefs.setStringList('completedExercises_powerfit', _completedExercises.toList());
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
                            onComplete: () => _markExerciseAsCompleted('HML Trapèze Tirage Frontal'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Trapèze Tirage Frontal', 'Explication du HML Trapèze Tirage Frontal', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Tirage Vertical Unilatéral'),
                            nombreTotalSerie: 4,
                            isVertical: true,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 15),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=O5aoFNLi8Vw&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=8&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Tirage Vertical Unilatéral', 'Explication du HML Tirage Vertical Unilatéral', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HMC Tirage Horizontale Frontal'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
                          ),));
                        },
                        child: _buildExerciseItem('HMC Tirage Horizontale Frontal', 'Explication du HMC Tirage Horizontale Frontal', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Tirage Vertical à la Poulie'),
                            isVertical: true,
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=HMAG7U5fKLM&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=11&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Tirage Vertical à la Poulie', 'Explication du HML Tirage Vertical à la Poulie', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Trapeze Tirage au Sol'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              SerieConfig(repetitions: 10),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=VUvrQoFOarU&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=7&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Trapeze Tirage au Sol', 'Explication du HML Trapeze Tirage au Sol', '5min',false)),
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
                            onComplete: () => _markExerciseAsCompleted('HML Poitrine Tirage Vertical Poulie Haute'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=VYgJGGFd4RE&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=20&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Poitrine Tirage Vertical Poulie Haute', 'Explication du HML Poitrine Tirage Vertical Poulie Haute', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Poitrine Tirage Vertical Poulie Basse'),
                            nombreTotalSerie: 4,
                            isVertical: true,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=uywj0LH8fzw&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=44&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Poitrine Tirage Vertical Poulie Basse', 'Explication du HML Poitrine Tirage Vertical Poulie Basse', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('FML Tirage Vertical Poitrine'),
                            isVertical: true,
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=-RXu8V-hYxw&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=4&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('FML Tirage Vertical Poitrine', 'Explication du FML Tirage Vertical Poitrine', '5min',false)),
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
                            onComplete: () => _markExerciseAsCompleted('HML Tirage Unilateral Poulie Basse'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=dQrV1R1N-cE&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=13&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Tirage Unilateral Poulie Basse', 'Explication du HML Tirage Unilateral Poulie Basse', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Biceps Tirage Unilateral Poulie Haute'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=CiZDnv-WgBc&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=23&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Biceps Tirage Unilateral Poulie Haute', 'Explication du HML Biceps Tirage Unilateral Poulie Haute', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HMC Biceps Curls Unilateral'),
                            nombreTotalSerie: 5,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1,),
                              SerieConfig(repetitions: 1,),
                              SerieConfig(repetitions: 1,),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
                          ),));
                        },
                        child: _buildExerciseItem('HMC Biceps Curls Unilateral', 'Explication du HMC Biceps Curls Unilateral', '5min',true)),
                    // _buildExerciseItem('Biceps Curl Poulie Basse', 'Explication du Biceps Curl Poulie Basse', '5min',true),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Biceps Curls Supination'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=WutX2QDf-Sk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=25&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Biceps Curls Supination', 'Explication du HML Biceps Curls Supination', '5min',true)),
                  InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Biceps Curls Pronation'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=C7J4RIXxR7o&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=26&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Biceps Curls Pronation', 'Explication du HML Biceps Curls Pronation', '5min',true)),
                 InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Biceps Curls Prise Marteau'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Biceps Curls Prise Marteau', 'Explication du HML Biceps Curls Prise Marteau', '5min',true)),
                 InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Biceps Curls Poulie Basse'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              SerieConfig(repetitions: 1, ),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=feqR6E9eUfY&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=42&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Biceps Curls Poulie Basse', 'Explication du HML Biceps Curls Poulie Basse', '5min',true)),
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
                            onComplete: () => _markExerciseAsCompleted('HML Tirage Nuque Triceps'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              // SerieConfig(repetitions: 8, charge: 50),
                              // SerieConfig(repetitions: 4, charge: 35),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=y2ZDuk3fcns&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=1&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Tirage Nuque Triceps', 'Explication du HML Tirage Nuque Triceps', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HMC Triceps Tirage Vertical'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/shorts/T7Wd17_Sr_8",
                          ),));
                        },
                        child: _buildExerciseItem('HMC Triceps Tirage Vertical', 'Explication du HMC Triceps Tirage Vertical', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('FMC Tirage Coude Triceps'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('FMC Tirage Coude Triceps', 'Explication du FMC Tirage Coude Triceps', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('FML Tirage Horizontal Triceps'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('FML Tirage Horizontal Triceps', 'Explication du FML Tirage Horizontal Triceps', '5min',true)),
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
                            onComplete: () => _markExerciseAsCompleted('FML Elevation Frontal'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=kPNmz30EQYc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=12&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('FML Elevation Frontal', 'Explication du FML Elevation Frontal', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('FML Developper Millitaire'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('FML Developper Millitaire', 'Explication du FML Developper Millitaire', '5min',true))
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
                            onComplete: () => _markExerciseAsCompleted('HMC Tirage sur les adducteurs'),
                            nombreTotalSerie: 5,
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
                            linkVideo: "https://www.youtube.com/shorts/V3KoSgDUYRM",
                          ),));
                        },
                        child: _buildExerciseItem('HMC Tirage sur les adducteurs', 'Explication du HMC Tirage sur les adducteurs', '5min',true)),
                    // _buildExerciseItem('Adduction', 'Explication de l\'Adduction', '5min',true),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Squat'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=9JJYYKFO9UQ&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=17&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Squat ', 'Explication du HML Squat ', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Squat Sumo'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                              SerieConfig(repetitions: 20),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=WT76YmmXjvg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=18&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('HML Squat Sumo', 'Explication du HML Squat Sumo', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Squat Militaire'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=_2B1jPImCXo&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=19&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Squat Militaire', 'Explication du HML Squat Militaire', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HMC Renforcement des Ischios'),
                            nombreTotalSerie: 4,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
                          ),));
                        },
                        child: _buildExerciseItem('HMC Renforcement des Ischios', 'Explication du HMC Renforcement des Ischios', '5min',true)),
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
                            onComplete: () => _markExerciseAsCompleted('HML Tirage Oblique Gauche Droit'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=EWkoX8IXg8Y&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=9&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('HML Tirage Oblique Gauche Droit', 'Explication du HML Tirage Oblique Gauche Droit', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Elavation Genoux vers le ventre'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=LrwgwSUWJCk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=31&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Elavation Genoux vers le ventre', 'Explication du HML Elavation Genoux vers le ventre', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('HML Crunchs Abdominal'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Eff9IJe6V2I&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=35&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('HML Crunchs Abdominal', 'Explication du HML Crunchs Abdominal', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('FM Crunch Abdominal Assis Ventre'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=r7yCpbSc_Ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=4&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('FM Crunch Abdominal Assis Ventre', 'Explication FM Crunch Abdominal Assis Ventre', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('FM Gainage'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=7xEOh4yZJ2Y&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=7&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('FM Gainage', 'Explication du FM Gainage', '5min',true)),
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
                            onComplete: () => _markExerciseAsCompleted('FMC tirage Horizontal Fessier'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('FMC tirage Horizontal Fessier', 'Explication du FMC tirage Horizontal Fessier', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('FMC Kickback'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "",
                          ),));
                        },
                        child: _buildExerciseItem('FMC Kickback', 'Explication du FMC Kickback', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('FMC mini Squat'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              SerieConfig(repetitions: 15),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('FMC mini Squat', 'Explication du FMC mini Squat', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('FMC Air Squat'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('FMC Air Squat', 'Explication FMC Air Squat', '5min',true)),
                    InkWell(
                        onTap: () {
                          widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('FMC Squat à Genoux'),
                            nombreTotalSerie: 3,
                            seriesConfigs: [
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 12),
                              SerieConfig(repetitions: 10),
                              // SerieConfig(repetitions: 10, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('FMC Squat à Genoux', 'Explication du FMC Squat à Genoux', '5min',true)),
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