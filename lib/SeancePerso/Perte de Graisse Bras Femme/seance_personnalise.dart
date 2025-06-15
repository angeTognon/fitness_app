import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/main.dart';
import 'package:fitness_app/modules/stockageSeancePersoList/stockage.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_app/modules/details/details_seances_from_seance_perso.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/components/text_components.dart';
import '../../modules/monCompte/controller/controller.dart';
import '../../utils/colors.dart';

class PerteDeGraisseBras extends StatefulWidget {
  final bool isReturningFromDetails;
  List<String> joursSemaine;
  PerteDeGraisseBras({super.key, this.isReturningFromDetails = false, required this.joursSemaine});

  @override
  State<PerteDeGraisseBras> createState() => _PerteDeGraisseBrasState();
}

class _PerteDeGraisseBrasState extends State<PerteDeGraisseBras> {
  final List<String> _warmUpExercises = [
    "EXERCICE Échauffement",
    "EXERCICE Etirements",
    "EXERCICE Etirement v2",
  ];

  final List<String> _mainExercises = [
    "EXERCICE Biceps Curls Marteau",
    "EXERCICE Triceps Tirage Poulie basse",
    "EXERCICE Biceps Curls Pronation",
    "EXERCICE Tirage Oblique Haltère",
    "EXERCICE Tirage Horizontal",
    "EXERCICE Tirage dans le Dos Poulie Basse",
    "EXERCICE Rowing à la Poulie basse",
    "EXERCICE Rope Fly",
    "EXERCICE Curls Poulie Basse",
    "EXERCICE Biceps curls à la Poulie",
    "EXERCICE Triceps Poulie Basse Unilateral",
  ];

  List<List<Map<String, double>>> generateSixMonthsProgram(int sessionsPerWeek) {
    List<String> warmUpVideos = _warmUpExercises;
    List<String> exerciseVideos = List.from(_mainExercises);
    List<String> stretchingVideos = [
      ""
    ];

    List<List<Map<String, double>>> program = [];
    Set<String> usedCombinations = {};
    int totalDays = sessionsPerWeek * 4 * 6; // 6 months worth of workouts
    int exerciseIndex = 0;
    int warmUpIndex = 0;

    while (program.length < totalDays) {
      // Select warm-up and stretching videos
      String warmUp = warmUpVideos[warmUpIndex % warmUpVideos.length];
      String stretching = stretchingVideos[program.length ~/ (sessionsPerWeek * 4) % stretchingVideos.length];

      // Select 3 new exercises every full cycle of permutations
      if (exerciseIndex + 3 > exerciseVideos.length) {
        exerciseIndex = 0;
        warmUpIndex++; // Change warm-up exercise
        exerciseVideos.shuffle();
      }
      List<String> selectedExercises = exerciseVideos.sublist(exerciseIndex, exerciseIndex + 3);

      // Generate all possible orders of the 3 exercises, keeping the first one fixed
      List<List<String>> permutations = [
        [selectedExercises[0], selectedExercises[1], selectedExercises[2]],
        [selectedExercises[0], selectedExercises[2], selectedExercises[1]],
        [selectedExercises[1], selectedExercises[0], selectedExercises[2]],
        [selectedExercises[1], selectedExercises[2], selectedExercises[0]],
        [selectedExercises[2], selectedExercises[0], selectedExercises[1]],
        [selectedExercises[2], selectedExercises[1], selectedExercises[0]],
      ];

      for (List<String> permutation in permutations) {
        if (program.length >= totalDays) break;

        // Create the day's program
        List<Map<String, double>> dayProgram = [
          {warmUp: 0.0},
          {stretching: 0.0},
          for (String exercise in permutation) {exercise: 0.0},
        ];

        // Ensure unique session combinations
        String combinationKey = dayProgram.map((e) => e.keys.first).join(",");
        if (usedCombinations.contains(combinationKey)) continue;

        usedCombinations.add(combinationKey);
        program.add(dayProgram);
      }

      exerciseIndex += 3;
    }

    return program;
  }

  Future<void> _loadProgram() async {
    List<List<Map<String, double>>>? storedProgram =
    await getProgramFromSharedPreferences();
    List<bool>? storedDaysCompleted = await getDaysCompletedFromSharedPreferences();

    if (storedProgram == null) {
      storedProgram = generateSixMonthsProgram(3); // Adjust sessions per week as needed
      await saveProgramToSharedPreferences(storedProgram);
    }

    if (storedDaysCompleted == null) {
      storedDaysCompleted = List.generate(storedProgram.length, (index) => false);
      await saveDaysCompletedToSharedPreferences(storedDaysCompleted);
    }

    _program = storedProgram;
    _daysCompleted = storedDaysCompleted;
    _getCurrentDayIndex(); // Determine current day index

    _countZeroPercentExercises();

    setState(() {});
  }

  List<List<Map<String, double>>> _program = [];
  List<DateTime> datesAssociees = [];
  int _currentDayIndex = -1; // Current day index in the program
  List<bool> _daysCompleted = []; // Track completed days



  Future<void> saveDaysCompletedToSharedPreferences(List<bool> daysCompleted) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String daysCompletedJson = jsonEncode(daysCompleted);
    await prefs.setString('daysCompleted', daysCompletedJson);
  }

  Future<List<bool>?> getDaysCompletedFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? daysCompletedJson = prefs.getString('daysCompleted');
    if (daysCompletedJson != null) {
      return List<bool>.from(jsonDecode(daysCompletedJson));
    }
    return null;
  }

  Future<void> saveProgramGenerationDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await prefs.setString('programGenerationDate', currentDate);
  }

  void _getCurrentDayIndex() async {
    DateTime now = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? programGenerationDate = prefs.getString('programGenerationDate');

    // Retrieve stored dates
    List<DateTime>? storedDates = await getDatesFromSharedPreferences();

    if (storedDates == null || storedDates.isEmpty) {
      if (programGenerationDate != null) {
        DateTime generationDate = DateTime.parse(programGenerationDate);
        List<DateTime> newDates = [];

        for (int i = 0; i < _program.length; i++) {
          String jourEntrainement = widget.joursSemaine[i % widget.joursSemaine.length];
          DateTime currentDate = findNextDay(generationDate, jourEntrainement);
          newDates.add(currentDate);
          generationDate = currentDate.add(Duration(days: 1));
        }

        await saveDatesToSharedPreferences(newDates);
        datesAssociees = newDates;
      } else {
        datesAssociees = [];
      }
    } else {
      datesAssociees = storedDates;
    }

    _currentDayIndex = datesAssociees.indexWhere((date) => date.isAfter(now) || date.isAtSameMomentAs(now)) - 1;

    if (_currentDayIndex == -1) {
      _currentDayIndex = 0; // Restart if all dates have passed
    }

    setState(() {});
  }
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadProgram();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _loadProgram();
    });
    _getCurrentDayIndex();
    saveProgramGenerationDate();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Annulez le timer lorsque le widget est détruit
    super.dispose();
  }



  Future<void> saveProgramToSharedPreferences(List<List<Map<String, double>>> program) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String programJson = jsonEncode(program);
    await prefs.setString('threeMonthsProgram', programJson);
  }

  Future<List<List<Map<String, double>>>?> getProgramFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? programJson = prefs.getString('threeMonthsProgram');
    if (programJson != null) {
      List<dynamic> decodedJson = jsonDecode(programJson);
      return decodedJson.map((day) => (day as List<dynamic>).map((exercise) => Map<String, double>.from(exercise)).toList()).toList();
    }
    return null;
  }

  DateTime findNextDay(DateTime startDate, String targetDay) {
    Map<String, int> daysOfWeek = {
      "Lundi": 1,
      "Mardi": 2,
      "Mercredi": 3,
      "Jeudi": 4,
      "Vendredi": 5,
      "Samedi": 6,
      "Dimanche": 7,
    };

    int targetDayIndex = daysOfWeek[targetDay]!;
    int currentDayIndex = startDate.weekday;

    int daysToAdd = (targetDayIndex - currentDayIndex + 7) % 7;
    return startDate.add(Duration(days: daysToAdd));
  }

  Future<void> saveDatesToSharedPreferences(List<DateTime> dates) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dateStrings = dates.map((date) => date.toIso8601String()).toList();
    await prefs.setStringList('programDates', dateStrings);
  }

  Future<List<DateTime>?> getDatesFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dateStrings = prefs.getStringList('programDates');
    if (dateStrings != null) {
      return dateStrings.map((dateString) => DateTime.parse(dateString)).toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        centerTitle: true,
        title: const TextComponent(
          text: "Perte de Graisse Bras",
          color: Colors.white,
          size: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                clearProgramAndDates();
              },
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage("assets/images/ventre_plat_et_abdos.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.center
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextComponent(
              text: "Jour d'entraînement",
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              size: 15,
            ),
            if (_program.isNotEmpty) ...[
              for (int week = 0; week < (_program.length / widget.joursSemaine.length).ceil(); week++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      text: "Semaine ${week + 1}",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      size: 15,
                    ),
                    SizedBox(height: 10),

                    for (int day = 0; day < widget.joursSemaine.length; day++)
                      if ((week * widget.joursSemaine.length + day) < _program.length)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextComponent(
                              text: "Jour ${week * widget.joursSemaine.length + day + 1} (${widget.joursSemaine[day]})",
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700]!,
                              size: 14,
                            ),
                            SizedBox(height: 10),

                            ..._program[week * widget.joursSemaine.length + day].asMap().entries.map((entry) {
                              int exerciseIndex = entry.key;
                              Map<String, double> exerciseMap = entry.value;
                              String exerciseName = exerciseMap.keys.first;
                              double progress = exerciseMap[exerciseName]!;

                              return buildExerciseBox(
                                  exerciseName,
                                  week * widget.joursSemaine.length + day,
                                  exerciseIndex,
                                  progress.toInt()
                              );
                            }).toList(),

                            SizedBox(height: 10),
                          ],
                        ),
                    Divider(color: Colors.grey[300], thickness: 1),
                  ],
                ),
            ] else
              Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
  final Map<String, Map<String, String>> exerciseDetails = {
    "EXERCICE Échauffement": {
      "séries": "1",
      "second": "60",
      "répétitions": "15",
      "lien_video": "https://www.youtube.com/watch?v=hMQ9UWuZkoA&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=3&t=2s&pp=iAQB"
    },
    "EXERCICE Etirements": {
      "séries": "1",
      "second": "30",
      "répétitions": "2",
      "lien_video": "https://www.youtube.com/watch?v=M8r1J9a0IFM&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=10&t=58s&pp=iAQB"
    },
    "EXERCICE Etirement v2": {
      "séries": "1",
      "second": "10",
      "répétitions": "2",
      "lien_video": "https://www.youtube.com/watch?v=iyM0n-Y8a44&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=11&t=1s&pp=iAQB"
    },
    "EXERCICE Biceps Curls Marteau": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=fYsZ52SUKf0&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=1&t=1s&pp=iAQB"
    },
    "EXERCICE Triceps Tirage Poulie basse": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=T4iubxldptw&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=2&t=15s&pp=iAQB"
    },
    "EXERCICE Biceps Curls Pronation": {
      "séries": "15",
      "second": "45",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=mgUSsVs_81o&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=4&t=1s&pp=iAQB"
    },
    "EXERCICE Tirage Oblique Haltère": {
      "séries": "15",
      "second": "30",
      "répétitions": "3",
      "lien_video": "https://www.youtube.com/watch?v=X_HjpRXr6gE&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=5&t=1s&pp=iAQB"
    },
    "EXERCICE Tirage Horizontal": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=JIYZDoxQBc8&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=6&pp=iAQB"
    },
    "EXERCICE Tirage dans le Dos Poulie Basse": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=ZruHFb2vd_A&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=7&pp=iAQB"
    },
    "EXERCICE Rowing à la Poulie basse": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=xzNNckIaao8&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=8&pp=iAQB"
    },
    "EXERCICE Rope Fly": {
      "séries": "20",
      "second": "60",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=EDGNlT6DQhs&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=9&pp=iAQB"
    },
    "EXERCICE Curls Poulie Basse": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=jME0zi7eCOo&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=12&pp=iAQB"
    },
    "EXERCICE Biceps curls à la Poulie": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=RqS9JoTQnzg&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=13&pp=iAQB"
    },
    "EXERCICE Triceps Poulie Basse Unilateral": {
      "séries": "15",
      "second": "55",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=BtLiZ-qBTcc&list=PL9GsY7tWZQwEOPWOqki5PxG_xyG7w2885&index=14&t=6s&pp=iAQB"
    },
  };
  double nbrManque = 0;

  Future<void> _countZeroPercentExercises() async {
    nbrManque = 0; // Réinitialiser le compteur à chaque appel
    for (int i = 0; i < _currentDayIndex; i++) {
      double count = 0;
      for (var exercise in _program[i]) {
        // Vérifiez si la valeur est de type double
        if (exercise.values.first == 0.0) {
          count++;
        }
      }
      // Stockez le compteur dans la dernière entrée du programmePowerBand du jour
      _program[i].last["countZeroPercent"] = count;

      // Ajoutez le count au total
      nbrManque += count; // Accumulez le nombre total d'exercices à 0 %
      print("*******ICICICICIICICICI :**********");
      print(nbrManque);
    }
    await saveNbrManqueToSharedPreferences(nbrManque);
  }
  Future<void> saveNbrManqueToSharedPreferences(double nbrManque) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('nbrManque', nbrManque);
  }
  Widget buildExerciseBox(String exerciseName, int dayIndex, int exerciseIndex, int progress) {
    Color circleColor = progress == 100 ? Colors.green : Colors.red;

    int currentWeek = getCurrentWeek();
    int daysPerWeek = widget.joursSemaine.length;

    bool isCurrentWeek = (dayIndex ~/ daysPerWeek) + 1 == currentWeek;
    bool isCurrentDay = dayIndex % daysPerWeek == _currentDayIndex % daysPerWeek;

    return exerciseName == ""
        ? Container()
        : InkWell(
      onTap: isCurrentWeek && isCurrentDay
          ? () async {
        String numberOfSeries = exerciseDetails[exerciseName]?["séries"] ?? "0";
        String reps = exerciseDetails[exerciseName]?["répétitions"] ?? "0";
        String jourSelectionne = "Jour ${dayIndex + 1}";

        String videoUrl = exerciseDetails[exerciseName]!["lien_video"]!;
        String second = exerciseDetails[exerciseName]?["second"] ?? "0";

        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsSeancesFromSeancePerso(
          second: int.parse(second),
          nomExo: exerciseName,
          nombreDeSerie: numberOfSeries,
          exerciceIndex: "$exerciseIndex",
          jourIndex: "$dayIndex",
          nombreDeRepetition: reps,
          videoUrls: videoUrl,
          combinaisonId: "",
          jourSelectionne: jourSelectionne,
        )));
      }
          : () {
        String jourSelectionne = "Jour ${dayIndex + 1}";
        showToast(context, "Veuillez attendre le jour $jourSelectionne avant de faire cet Exercice", Colors.red);
      },
      child: Card(
        color: isCurrentWeek && isCurrentDay ? Colors.white : Colors.redAccent.withOpacity(0.1),
        elevation: isCurrentWeek && isCurrentDay ? 3 : 0,
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
                  radius: 25,
                  child: Center(
                    child: TextComponent(
                      text: "$progress%",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
                SizedBox(width: 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 240,
                      child: TextComponent(
                        text: exerciseName,
                        size: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextComponent(
                      text: "Progression: $progress%",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      size: 13,
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
  int getCurrentWeek() {
    if (prefs == null) return 1; // Valeur par défaut si prefs n'est pas initialisé

    DateTime now = DateTime.now();
    String? programGenerationDate = prefs!.getString('programGenerationDate');
    if (programGenerationDate == null) return 1; // Valeur par défaut si la date n'est pas définie

    DateTime startDate = DateTime.parse(programGenerationDate);
    int daysSinceStart = now.difference(startDate).inDays;
    return (daysSinceStart ~/ 7) + 1;
  }
  SharedPreferences? prefs;
  Future<void> clearProgramAndDates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('threeMonthsProgram');
    await prefs.remove('programDates');
    await prefs.remove('daysCompleted');
    await prefs.remove('programGenerationDate');

    // Réinitialiser les variables d'état
    setState(() {
      _program = [];
      datesAssociees = [];
      _currentDayIndex = -1;
      _daysCompleted = [];
    });
  }
}