import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitness_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../modules/monCompte/controller/controller.dart';
import 'lectureVideosExo.dart';

class LectureVideosExoFromProgram extends StatefulWidget {
  final List<Exercice> exercice;
  String path;
  String pg;
  final VoidCallback? onComplete; // Ajoutez ce callback

  LectureVideosExoFromProgram({required this.exercice, required this.path, this.onComplete,required this.pg});

  @override
  State<LectureVideosExoFromProgram> createState() => _LectureVideosExoFromProgramState();
}

class _LectureVideosExoFromProgramState extends State<LectureVideosExoFromProgram> {
  late SharedPreferences _prefs;
  final Set<String> _completedExercises = {};

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadCompletedExercises("");
  }

  void _markExerciseAsCompleted(String exerciseName) {
    if (!_isExerciseCompleted(exerciseName)) {
      setState(() {
        _completedExercises.add(exerciseName);
        _prefs.setStringList('completedExercises_${widget.pg}_$exerciseName', _completedExercises.toList());
        _loadCompletedExercises(exerciseName);
      });
    }
  }

  void _loadCompletedExercises(String? exerciceName) {
    Set<String> completedExercises = _prefs.getStringList('completedExercises_${widget.pg}_$exerciceName')?.toSet() ?? {};
    setState(() {
      _completedExercises.addAll(completedExercises);
    });
  }

  bool _isExerciseCompleted(String exerciseName) {
    return _completedExercises.contains(exerciseName);
  }

  bool _isSessionCompleted() {
    print("Completed Exercises: $_completedExercises");
    print("Total Exercises: ${widget.exercice.length}");
    print("Completed Exercises Length: ${_completedExercises.length}");
    return _completedExercises.length == widget.exercice.length;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Screen.height(context) / 2.5,
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
                                text: "Liste des Exercices",
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
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  TextComponent(text: "Exercices",fontWeight: FontWeight.bold,color: mainColor,size: 15),
                  ...List.generate(widget.exercice.length, (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Lecturevideosexo(
                          nombreTotalSerie: widget.exercice[index].nombreTotalSerie,
                          seriesConfigs: widget.exercice[index].seriesConfigs,
                          linkVideo: widget.exercice[index].linkVideo,
                          repos: widget.exercice[index].repos,
                          onComplete: () => _markExerciseAsCompleted(widget.exercice[index].titre),
                        )));
                        print(_isExerciseCompleted(widget.exercice[index].titre));
                      },
                      child: _buildExerciseItem(
                        widget.exercice[index].titre,
                        'Explication du ${widget.exercice[index].titre}',
                        '5 min',
                        _isExerciseCompleted(widget.exercice[index].titre),
                      ),
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _isSessionCompleted()
          ? InkWell(
        onTap: () {
          widget.onComplete!();
          showToast(context, "Séance Validée avec succès", Colors.green);
          Navigator.pop(context);
        },
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: ButtonComponent(label: "VALIDER LA SEANCE EN CLIQUANT ICI", color: Colors.black,fontWeight: FontWeight.bold,),
        ),
      )
          : null,
    );
  }

  Widget _buildExerciseItem(String title, String description, String duration, bool isCompleted) {
    return Column(
      children: [
        Card(
          elevation: 3,
          color: Colors.white,
          child: ListTile(
            leading: Container(
                height: 45,width: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey,width: 1.3),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Icon(Icons.play_circle_sharp,color: Colors.blueGrey)
            ),
            title: TextComponent(
              text: title,size: 13,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.70),textAlign: TextAlign.start,
            ),
            subtitle: TextComponent(text: description,textAlign: TextAlign.start),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 7,
              children: [
                Icon(isCompleted ? Icons.check_circle : Icons.check_circle_outline, color: mainColor),
                Container(
                  color: mainColor.withOpacity(0.5),
                  padding: EdgeInsets.all(3),
                  child: TextComponent(text: "5 min",color: Colors.white,size: 11),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Exercice {
  String titre;
  int nombreTotalSerie;
  final List<SerieConfig> seriesConfigs;
  String linkVideo;
  int repos;
  Exercice({required this.titre, required this.nombreTotalSerie, required this.seriesConfigs, required this.repos, required this.linkVideo});
}