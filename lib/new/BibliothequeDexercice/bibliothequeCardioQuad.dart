import 'package:flutter/material.dart';
import 'package:fitness_app/app/components/text_components.dart';
import 'package:fitness_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/monCompte/controller/controller.dart';
import '../LectureVideoExo/lectureVideosExo.dart';

class BibliothequeCardioQuad extends StatefulWidget {
  bool isFromAccueil;
  BibliothequeCardioQuad({required this.isFromAccueil});

  @override
  State<BibliothequeCardioQuad> createState() => _BibliothequeCardioQuadState();
}

class _BibliothequeCardioQuadState extends State<BibliothequeCardioQuad> {

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
    Set<String> completedExercises = _prefs.getStringList('completedExercises_cardio')?.toSet() ?? {};
    setState(() {
      _completedExercises.addAll(completedExercises);
    });
  }

  void _markExerciseAsCompleted(String exerciseName) {
    setState(() {
      _completedExercises.add(exerciseName);
      _prefs.setStringList('completedExercises_cardio', _completedExercises.toList());
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
                            onComplete: () => _markExerciseAsCompleted('R M Exercice Trapèze'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=yt7PUBXYuVw&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=20&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('R M Exercice Trapèze', 'Explication du R M Exercice Trapèze', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('R M Tirage Horizontal'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 45,
                            linkVideo: "https://www.youtube.com/watch?v=33_oPPlXRqc&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=21&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('R M Tirage Horizontal', 'Explication du R M Tirage Horizontal', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('R M Tirage à la Poulie Basse Grand Dorsaux'),

                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=gq97Awzjrvo&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=27&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('R M Tirage à la Poulie Basse Grand Dorsaux', 'Explication du R M Tirage à la Poulie Basse Grand Dorsaux', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RS Tirage Horizontal 2'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=3XatVJGA9ZQ&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=7&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RS Tirage Horizontal 2', 'Explication du RS Tirage Horizontal 2', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('PPH Tirage Horizontal'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=BVmD5bw18LE&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=11&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('PPH Tirage Horizontal', 'Explication du PPH Tirage Horizontal', '5min',false)),],
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
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=XmJLVOZMBKo&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=26&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('R M Developper Incliner', 'Explication du R M Developper Incliner', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('DPB Developper Unilatéral'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Ym4hkO8J1-8&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=15&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('DPB Developper Unilatéral', 'Explication du DPB Developper Unilatéral', '5min',false)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('DPB Developper Coucher (decliner serré)'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=BKQ2rnlFDcE&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=16&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('DPB Developper Coucher (decliner serré)', 'Explication du DPB Developper Coucher (decliner serré)', '5min',false)),

                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('DPB Developper Assis'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=F1LaNoDrtE4&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=17&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('DPB Developper Assis', 'Explication du DPB Developper Assis', '5min',false)),],
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
                                                    onComplete: () => _markExerciseAsCompleted('DPB Tirage à la Poulie Basse'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=e97B5gjxfL0&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=2&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('DPB Tirage à la Poulie Basse', 'Explication du DPB Tirage à la Poulie Basse', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                                                    onComplete: () => _markExerciseAsCompleted('DPB Biceps Curls Assis'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0,),
                              SerieConfig(repetitions: 0,),
                              SerieConfig(repetitions: 0,),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=FCPiEGKGGFk&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=18&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('DPB Biceps Curls Assis', 'Explication du DPB Biceps Curls Assis', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('DPB Biceps Curls Concentré'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0, ),
                              SerieConfig(repetitions: 0, ),
                              SerieConfig(repetitions: 0, ),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=hJdJJZXpxlE&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=19&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('DPB Biceps Curls Concentré', 'Explication du DPB Biceps Curls Concentré', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RS Tirage Frontale Biceps'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0, ),
                              SerieConfig(repetitions: 0, ),
                              SerieConfig(repetitions: 0, ),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=BJ3LxU-jDVI&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=8&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RS Tirage Frontale Biceps', 'Explication du RS Tirage Frontale Biceps', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RS Curls à la Poulie'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0, ),
                              SerieConfig(repetitions: 0, ),
                              SerieConfig(repetitions: 0, ),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=mWYImDGqCyg&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=31&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RS Curls à la Poulie', 'Explication du RS Curls à la Poulie', '5min',true)),
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
                            onComplete: () => _markExerciseAsCompleted('R M Dips'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=INj2w0L0N9M&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=25&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('R M Dips', 'Explication du R M Dips', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('R M Triceps'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=DYYQYhbBGck&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=33&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('R M Triceps', 'Explication du R M Triceps', '5min',true)),],
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
                            onComplete: () => _markExerciseAsCompleted('PPH Elevation Lateral & Frontale'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=b-ks6xvd1SA&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=14&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('PPH Elevation Lateral & Frontale', 'Explication du PPH Elevation Lateral & Frontale', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RS Tirage Montant'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=HTdmnGPF1hQ&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=1&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RS Tirage Montant', 'Explication du RS Tirage Montant', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RS Elevation Lateral Epaules'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=F40I2pgIqJg&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=5&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RS Elevation Lateral Epaules', 'Explication du RS Elevation Lateral Epaules', '5min',true))
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
                            onComplete: () => _markExerciseAsCompleted('R M Fente Arrière'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=OHWfO2VWIfY&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=9&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('R M Fente Arrière', 'Explication du R M Fente Arrière', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('R M Ischio Fessier'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=NWtSq73XLfI&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=23&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('R M Ischio Fessier', 'Explication du R M Ischio Fessier', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RM Ischio'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=9Aa4_6iAatM&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=22&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RM Ischio', 'Explication du RM Ischio', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RM Quadriceps'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=Pp0aH3w5_5U&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=30&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RM Quadriceps', 'Explication du RM Quadriceps', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('CJF Squat 3'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=sMWcI_zdY_U&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=12&t=96s&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('CJF Squat 3', 'Explication du CJF Squat 3', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RM Air Squat'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=dA4PfUaKqTk&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=32&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RM Air Squat', 'Explication du RM Air Squat', '5min',true)),
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
                            onComplete: () => _markExerciseAsCompleted('RM Rotation Hanche Oblique Assis'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=LY-AhtVdRRA&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=28&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RM Rotation Hanche Oblique Assis', 'Explication du RM Rotation Hanche Oblique Assis', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RM Rotation Hanche Oblique'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=pXfcfzNEYVk&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=29&pp=iAQBB",
                          ),));
                        },
                        child: _buildExerciseItem('RM Rotation Hanche Oblique', 'Explication du RM Rotation Hanche Oblique', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RM Crunch Abdominal 1'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=25nZg12ThjU&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=35&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RM Crunch Abdominal 1', 'Explication du RM Crunch Abdominal 1', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RM Elevation Genoux ABDO'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=e8AxgNfYPFs&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=24&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RM Elevation Genoux ABDO', 'Explication RM Elevation Genoux ABDO', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RS Rotation Russe'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=XIxBP1sDwCg&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
                          ),));
                        },
                        child: _buildExerciseItem('RS Rotation Russe', 'Explication du RS Rotation Russe', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RS Flexion Lateral'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              // SerieConfig(repetitions: 0, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=elt2FRzpd4E&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=4&t=7s&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RS Flexion Lateral', 'Explication du RS Flexion Lateral', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('RS Elevation Genoux'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              // SerieConfig(repetitions: 0, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=y4dDqsYyQb4&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=6&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('RS Elevation Genoux', 'Explication RS Elevation Genoux', '5min',true)),
                    InkWell(
                        onTap: () {
                                                    widget.isFromAccueil? showToast(context, "Veuillez vous connecter pour avoir accès à cette vidéo.", Colors.red): Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                            onComplete: () => _markExerciseAsCompleted('CJF Gainage'),
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              // SerieConfig(repetitions: 0, charge: 60),
                              // SerieConfig(repetitions: 8, charge: 60),
                            ],
                            repos: 90,
                            linkVideo: "https://www.youtube.com/watch?v=lor9ZeIeHBk&list=PL9GsY7tWZQwGXkL5AfpusmjBQpZI9JOUt&index=13&pp=iAQB",
                          ),));
                        },
                        child: _buildExerciseItem('CJF Gainage', 'Explication du CJF Gainage', '5min',true)),
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
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
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
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              // SerieConfig(repetitions: 0, charge: 60),
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
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              // SerieConfig(repetitions: 0, charge: 60),
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
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              // SerieConfig(repetitions: 0, charge: 60),
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
                            nombreTotalSerie: 0,
                            seriesConfigs: [
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              SerieConfig(repetitions: 0),
                              // SerieConfig(repetitions: 0, charge: 60),
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