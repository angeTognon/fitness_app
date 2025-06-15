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
import '../../utils/colors.dart';

class PerteDePoidsFemme extends StatefulWidget {
  final bool isReturningFromDetails;
  List<String> joursSemaine;
  PerteDePoidsFemme({super.key, this.isReturningFromDetails = false, required this.joursSemaine});

  @override
  State<PerteDePoidsFemme> createState() => _PerteDePoidsFemmeState();
}

class _PerteDePoidsFemmeState extends State<PerteDePoidsFemme> {
  final List<String> _warmUpExercises = [
    "EXERCICE Etirements V2"
    "Exercice Etirements",
        "EXERCICE Echauffement",
  ];

  final List<String> _mainExercises = [
    "EXERCICE squat Tirage sur orteils",
    "EXERCICE Triceps Tirage Poulie basse",
    "EXERCICE Triceps Poulie Basse Unilateral",
    "EXERCICE Tirage Oblique Haltère",
    "EXERCICE Tirage Horizontal",
    "EXERCICE Tirage dans le Dos Poulie Basse",
    "EXERCICE squat 3",
    "Exercice Soulever de terre",
    "EXERCICE Rowing à la Poulie basse",
    "EXERCICE Rotation des Hanches",
    "EXERCICE Rope Fly",
    "EXERCICE Quadriceps",
    "Exercice Kick Squat",
    "EXERCICE Kick Back",
    "Exercice Squat Sumo",
    "Exercice Squat Sauter",
    "EXERCICE Front squat Halteres",
    "Exercice Fire Hydrant",
    "EXERCICE Fentes Croisé Unilateral",
    "Exercice Fente avant Fente Arrière",
    "Exercice Fente Arrière",
    "EXERCICE Fente Arrière Gauche Droit",
    "EXERCICE Kick Back Unilateral",
    "EXERCICE Kick Back 2",
    "EXERCICE GoodMorning",
    "EXERCICE Gainage",
    "EXERCICE Elevation Fessier",
    "EXERCICE Elevation genoux",
    "Exercice Elevation Bassin",
    "Exercice Double Fente Avant",
    "Exercice Fente Arrière Croisé",
    "Exercice Extension Mollet",
    "Exercice Extension Jambes au Sol",
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
          text: "Perte de Poids",
          color: Colors.white,
          size: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
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
    "EXERCICE Etirements V2": {
      "séries": "1",
      "second": "30",
      "répétitions": "2",
      "lien_video": "https://www.youtube.com/watch?v=NAZZQ8yVAuY&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=27&t=5s&pp=iAQB"
    },
    "EXERCICE Etirements": {
      "séries": "1",
      "second": "30",
      "répétitions": "3",
      "lien_video": "https://www.youtube.com/watch?v=CVzqNgWtygo&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=36&t=2s&pp=iAQB"
    },
    "EXERCICE squat Tirage sur orteils": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=-MIY5xUvgX0&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=1&pp=iAQB"
    },
    "EXERCICE Triceps Tirage Poulie basse": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=wKPtX8eQpA0&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=2&t=4s&pp=iAQB"
    },
    "EXERCICE Triceps Poulie Basse Unilateral": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=310KtVqTXJw&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=3&t=11s&pp=iAQB"
    },
    "EXERCICE Tirage Oblique Haltère": {
      "séries": "15",
      "second": "60",
      "répétitions": "2",
      "lien_video": "https://www.youtube.com/watch?v=k8vtwNFkKmE&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=4&t=31s&pp=iAQB"
    },
    "EXERCICE Tirage Horizontal": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=lPEUOxG2yxs&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=5&t=14s&pp=iAQB"
    },
    "EXERCICE Tirage dans le Dos Poulie Basse": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=G_g7mQCiSa4&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=6&t=8s&pp=iAQB"
    },
    "EXERCICE squat 3": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=VM2Ea3x0AEE&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=7&t=8s&pp=iAQB"
    },
    "Exercice Soulever de terre": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=qu9HfXImVy0&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=8&t=9s&pp=iAQB"
    },
    "EXERCICE Rowing à la Poulie basse": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=H4orCb5A6qE&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=9&t=11s&pp=iAQB"
    },
    "EXERCICE Rotation des Hanches": {
      "séries": "20",
      "second": "60",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=IDhlZlAm8ho&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=10&pp=iAQB"
    },
    "EXERCICE Rope Fly": {
      "séries": "20",
      "second": "60",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=INEeJKuXqUQ&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=11&t=11s&pp=iAQB"
    },
    "EXERCICE Quadriceps": {
      "séries": "20",
      "second": "60",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=4C3q23nwMHQ&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=12&t=7s&pp=iAQB"
    },
    "Exercice Kick Squat": {
      "séries": "12",
      "second": "40",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=o3hOsGViDmg&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=13&pp=iAQB"
    },
    "EXERCICE Kick Back": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=i38OgKCPHYc&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=14&t=6s&pp=iAQB"
    },
    "Exercice Squat Sumo": {
      "séries": "10",
      "second": "30",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=cRbYoyb_qh0&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=15&pp=iAQB"
    },
    "Exercice Squat Sauter": {
      "séries": "10",
      "second": "40",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=4hy3CaKjx9Q&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=16&pp=iAQB"
    },
    "EXERCICE Front squat Halteres": {
      "séries": "15",
      "second": "40",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=7cEEE8DEjl4&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=17&t=5s&pp=iAQB"
    },
    "Exercice Fire Hydrant": {
      "séries": "10",
      "second": "30",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=7tmeSCZdfV0&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=18&t=9s&pp=iAQB"
    },
    "EXERCICE Fentes Croisé Unilateral": {
      "séries": "12",
      "second": "40",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=fPmQakD8WgM&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=19&t=2s&pp=iAQB"
    },
    "Exercice Fente avant Fente Arrière": {
      "séries": "10",
      "second": "30",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=gl3yK7DIBVA&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=20&pp=iAQB"
    },
    "Exercice Fente Arrière": {
      "séries": "1",
      "second": "30",
      "répétitions": "3",
      "lien_video": "https://www.youtube.com/watch?v=DMn3vfOwHO8&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=21&t=9s&pp=iAQB"
    },
    "EXERCICE Fente Arrière Gauche Droit": {
      "séries": "12",
      "second": "35",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=BxBEPe9ktdU&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=22&pp=iAQB"
    },
    "EXERCICE Kick Back Unilateral": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=YBfPP3e3n_A&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=23&t=2s&pp=iAQB"
    },
    "EXERCICE Kick Back 2": {
      "séries": "15",
      "second": "45",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=Uc5ra_GJLII&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=24&pp=iAQB"
    },
    "EXERCICE GoodMorning": {
      "séries": "20",
      "second": "40",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=KZdZLiQ7fKg&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=25&t=2s&pp=iAQB"
    },
    "EXERCICE Gainage": {
      "séries": "1",
      "second": "10",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=QVAjSxeFxbM&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=26&t=4s&pp=iAQB"
    },
    "EXERCICE Elevation Fessier": {
      "séries": "15",
      "second": "40",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=u_0rwvRwGU4&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=29&pp=iAQB"
    },
    "EXERCICE Elevation genoux": {
      "séries": "15",
      "second": "30",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=F7ZWUkL_LCU&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=28&t=1s&pp=iAQB"
    },
    "Exercice Elevation Bassin": {
      "séries": "1",
      "second": "30",
      "répétitions": "3",
      "lien_video": "https://www.youtube.com/watch?v=plrNdRLe5Z0&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=30&t=7s&pp=iAQB"
    },
    "EXERCICE Echauffement": {
      "séries": "1",
      "second": "50",
      "répétitions": "15",
      "lien_video": "https://www.youtube.com/watch?v=SKL2bXgH2qM&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=31&t=3s&pp=iAQB"
    },
    "Exercice Double Fente Avant": {
      "séries": "1",
      "second": "30",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=2qkfyrqIPRw&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=32&t=5s&pp=iAQB"
    },
    "Exercice Fente Arrière Croisé": {
      "séries": "10",
      "second": "30",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=nI6iNia-8ws&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=33&t=3s&pp=iAQB"
    },
    "Exercice Extension Mollet": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=VPSb64JxINc&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=34&pp=iAQB"
    },
    "Exercice Extension Jambes au Sol": {
      "séries": "10",
      "second": "45",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=ban9lnJsjSE&list=PL9GsY7tWZQwE8DV1cAy_7C3bEmbt61KHS&index=35&t=3s&pp=iAQB"
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
    return exerciseName==""? Container(): InkWell(
      onTap: () async {
        String numberOfSeries = exerciseDetails[exerciseName]?["séries"] ?? "0";
        String reps = exerciseDetails[exerciseName]?["répétitions"] ?? "0";
        print(numberOfSeries);
        String jourSelectionne = "Jour ${dayIndex}";
        String second = exerciseDetails[exerciseName]?["second"] ?? "0";

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? programGenerationDate = prefs.getString('programGenerationDate');
        print("{$dayIndex ; $exerciseIndex }");
        String videoUrl = exerciseDetails[exerciseName]!["lien_video"]!;
        print(videoUrl);

        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsSeancesFromSeancePerso(
          nomExo: exerciseName,
          nombreDeSerie: numberOfSeries,
          exerciceIndex : "$exerciseIndex",
          jourIndex : "$dayIndex",
          nombreDeRepetition: reps,
          second: int.parse(second),
          videoUrls:  videoUrl,
          combinaisonId: "",
          jourSelectionne: jourSelectionne,
        )));
        // Action lorsque l'utilisateur clique sur l'exercice
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
                  radius: 25,
                  child: Center(
                    child: TextComponent(
                      text: "$progress%",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      size: 15,
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
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextComponent(
                      text: "Progression: $progress%",
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700]!,
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