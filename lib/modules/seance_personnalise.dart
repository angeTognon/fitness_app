import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/main.dart';
import 'package:fitness_app/modules/stockageSeancePersoList/stockage.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_app/modules/details/details_seances_from_seance_perso.dart';
import '../app/components/text_components.dart';
import '../utils/colors.dart';

class SeanceLibre2 extends StatefulWidget {
  final bool isReturningFromDetails;
  const SeanceLibre2({super.key,this.isReturningFromDetails = false});

  @override
  State<SeanceLibre2> createState() => _SeanceLibre2State();
}

class _SeanceLibre2State extends State<SeanceLibre2> {
  final List<String> _warmUpExercises = [
    "PGBF EXERCICE Échauffement",
    "PGBF EXERCICE Etirements",
    "PGBF EXERCICE Etirement v2",
  ];
  String? _combinaisonId;

  final List<String> ObjectifPerteDeGraisseBras=[
    "PGBF EXERCICE Biceps Curls Marteau",
    "PGBF EXERCICE Triceps Tirage Poulie basse",
    "PGBF EXERCICE Biceps Curls Pronation",
    "PGBF EXERCICE Tirage Oblique Haltère",
    "PGBF EXERCICE Tirage Horizontal",
    "PGBF EXERCICE Tirage dans le Dos Poulie Basse",
    "PGBF EXERCICE Rowing à la Poulie basse",
    "PGBF EXERCICE Rope Fly",
    "PGBF EXERCICE Curls Poulie Basse",
    "PGBF EXERCICE Biceps curls à la Poulie　",
    "PGBF EXERCICE Triceps Poulie Basse Unilateral",

  ];
  final List<String> _mainExercises = [
    "Squat Sumo",
    "Kick Squat",
    "Gainage",
    "Elevation Bassin",
    "Crunch Latéral",
    "Crunch Abdominal",
    "Crunch Abdominal V2",
    "Crunch Abdominal Suspendu",
  ];


  List<List<String>> generateNextCycle(List<List<String>> currentProgram) {
    List<String> allExercises = [..._warmUpExercises, ..._mainExercises];
    List<List<String>> nextCycle = [];

    for (int i = 0; i < 14; i++) {
      // Mélanger les exercices à chaque cycle
      List<String> dayProgram = [allExercises[0]]; // Garder l'échauffement
      List<String> mainExercises = allExercises.sublist(1);
      mainExercises.shuffle();
      dayProgram.addAll(mainExercises.take(3)); // 3 exercices principaux
      nextCycle.add(dayProgram);
    }
    return nextCycle;
  }
  List<List<List<String>>> generateSixMonthProgram() {
    List<List<List<String>>> sixMonthProgram = [];

    List<List<String>> currentCycle = generateTwoWeeksProgram();
    sixMonthProgram.add(currentCycle);

    for (int i = 1; i < 12; i++) { // 12 cycles pour 6 mois
      currentCycle = generateNextCycle(currentCycle);
      sixMonthProgram.add(currentCycle);
    }

    return sixMonthProgram;
  }


  List<String> _exerciseSchedule = [];
  Map<String, int> _exerciseProgress = {}; // Stocker les pourcentages


  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // _loadProgram();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {

    });
    print(widget.isReturningFromDetails);
  }

 /* Future<void> _loadProgram() async {
    List<List<String>>? storedProgram = await getProgramFromSharedPreferences();

    if (storedProgram == null) {
      // Si pas de programmePowerBand stocké, générer un nouveau programmePowerBand
      storedProgram = generateTwoWeeksProgram();

      // Sauvegarder le programmePowerBand généré dans SharedPreferences
      await saveProgramToSharedPreferences(storedProgram);
    }

    // Mettre à jour l'état avec le programmePowerBand
    setState(() {
      _program = storedProgram!;
    });
  }*/
  List<List<String>> _program = [];


  @override
  void dispose() {
    _timer?.cancel(); // Annulez le timer lorsque le widget est détruit
    super.dispose();
  }

  List<List<String>> generateTwoWeeksProgram() {
    List<String> warmUpExercises = _warmUpExercises; // Échauffements
    List<String> mainExercises = _mainExercises; // Exercices principaux

    List<List<String>> program = [];
    Set<String> usedCombinations = {}; // Suivi des combinaisons déjà utilisées

    // Générer le programmePowerBand pour 14 jours
    for (int i = 0; i < 14; i++) {
      String warmUp = warmUpExercises[Random().nextInt(warmUpExercises.length)];

      // Mélanger les exercices principaux (pour changer l'ordre)
      List<String> shuffledMainExercises = List.from(mainExercises);
      shuffledMainExercises.shuffle();

      // Créer la séance du jour avec un label "Jour X"
      List<String> dayProgram = ["Jour ${i + 1}", warmUp, ...shuffledMainExercises.take(3)];

      // Vérifier si la combinaison a déjà été utilisée
      String combinationKey = dayProgram.sublist(1).join(","); // Exclure le "Jour X" de la clé
      if (usedCombinations.contains(combinationKey)) {
        // Si la combinaison a déjà été utilisée, régénérer
        i--;
        continue;
      }

      usedCombinations.add(combinationKey);

      // Ajouter le programmePowerBand du jour à la liste des programmes
      program.add(dayProgram);
    }

    return program;
  }






  @override
  Widget build(BuildContext context) {
    List<List<String>> twoWeeksProgram = generateTwoWeeksProgram();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        centerTitle: true,
        title: const TextComponent(
          text: "Séance personnalisée",
          color: Colors.white,
          size: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/images/h.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TextComponent(
              text: "Jour d'entraînement",
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              size: 15,
            ),
            // Afficher les 14 jours du programme
        ListView.builder(
          shrinkWrap: true,
          itemCount: _program.length,
          itemBuilder: (context, index) {
            List<String> dayExercises = _program[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(
                  text: "Jour ${index + 1}",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  size: 17,
                ),
                ...dayExercises.map((exerciseName) {
                  return buildExerciseBox(exerciseName, index, dayExercises.indexOf(exerciseName));
                }).toList(),
              ],
            );
          },
        )
        ],
        ),
      ),
    );
  }

  final Map<String, String> _exerciseSeriesMap = {
    "Squat Sumo": "10",
    "Kick Squat": "12",
    "Gainage": "5",
    "Elevation Bassin": "4",
    "Crunch Latéral": "15",
    "Crunch Abdominal": "15",
    "Crunch Abdominal V2": "12",
    "Crunch Abdominal Suspendu": "15",
    "Échauffement": "5",
    "Etirements": "4",
    "Etirement v2": "5",
  };
  Widget buildExerciseBox(String exerciseName, int dayIndex, int exerciseIndex) {
    int progress = _exerciseProgress[exerciseName] ?? 0; // Récupérer le pourcentage
    Color circleColor = progress == 100 ? Colors.green : Colors.red; // Couleur en fonction du pourcentage

    return exerciseName.contains("Jour")? SizedBox() :  InkWell(
      onTap: () async {
        String numberOfSeries = _exerciseSeriesMap[exerciseName] ?? "N/A";
        if (progress != 100) {
           String numberOfSeries = _exerciseSeriesMap[exerciseName] ?? "N/A";
           String jourSelectionne = "Jour ${dayIndex + 1}";
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsSeancesFromSeancePerso(
            nomExo: exerciseName,
            nombreDeSerie: numberOfSeries,
            combinaisonId: _exerciseSchedule.join(","),
            jourSelectionne: jourSelectionne,
          )));
        }
      },
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: circleColor,
                  radius: 40,
                  child: Center(
                    child: progress==0? Icon(Icons.lock,color: Colors.white,) :  TextComponent(
                      text: "$progress%",// Placeholder for completion percentage
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    TextComponent(
                      text: "Exercice ${exerciseIndex - 1}",
                      fontWeight: FontWeight.bold,
                      size: 15,
                      color: Colors.black,
                    ),
                    TextComponent(
                      text: exerciseName,
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}