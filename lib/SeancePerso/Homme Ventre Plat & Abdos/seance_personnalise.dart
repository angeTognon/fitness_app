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

class VentrePlatEtAbdosHomme extends StatefulWidget {
  final bool isReturningFromDetails;
  List<String> joursSemaine;
  VentrePlatEtAbdosHomme({super.key, this.isReturningFromDetails = false, required this.joursSemaine});

  @override
  State<VentrePlatEtAbdosHomme> createState() => _VentrePlatEtAbdosHommeState();
}

class _VentrePlatEtAbdosHommeState extends State<VentrePlatEtAbdosHomme> {
  final List<String> _warmUpExercises = [
    "Exercice Echauffement 2",
    "Exercice Echauffement 1",
  ];

  final List<String> _mainExercises = [
    "Exercice Sit Up",
    "Exercice Side Twist",
    "Exercice Rocking",
    "Exercice Side Crunch",
    "Exercice Side Crunch 2",
    "Exercice Crunch Oblique",
    "Exercice Crunch Au Sol",
    "Exercice Appui Costral",
    "Exercice Gainage",
    "Exercice Flexion Oblique au banc Lombaire",
    "Exercice Extension Jambes",
    "Exercice Enchainement",
    "Exercice Elevation du Corps",
    "Exercice Push up",
    "Exercice Planche Lateral",
    "Exercice Leg Raise",
    "Exercice Kicks Hooks",
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
          text: "Ventre PLat et Abdos",
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
    "Exercice Sit Up": {
      "séries": "10",
      "second": "30",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=fXPKEoIw33s&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=1&pp=iAQB"
    },
    "Exercice Side Twist": {
      "séries": "20",
      "second": "55",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=3mmLJVX6Qks&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=2&pp=iAQB"
    },
    "Exercice Rocking": {
      "séries": "15",
      "second": "30",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=nDnEe5tb7NI&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=3&t=7s&pp=iAQB"
    },
    "Exercice Side Crunch": {
      "séries": "15",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=QTJcl8BAuQw&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=4&pp=iAQB"
    },
    "Exercice Side Crunch 2": {
      "séries": "10",
      "second": "40",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=Ts9rPM7k984&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=5&pp=iAQB"
    },
    "Exercice Crunch Oblique": {
      "séries": "10",
      "second": "50",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=Q_F-Gycmy_A&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=6&pp=iAQB"
    },
    "Exercice Crunch Au Sol": {
      "séries": "15",
      "second": "30",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=tk7sNKix2bk&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=7&pp=iAQB"
    },
    "Exercice Appui Costral": {
      "séries": "10",
      "second": "50",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=HAMWwe79N_M&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=8&t=2s&pp=iAQB"
    },
    "Exercice Gainage": {
      "séries": "5",
      "second": "50",
      "répétitions": "1",
      "lien_video": "https://www.youtube.com/watch?v=ZiJ4VLa0Grc&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=9&t=4s&pp=iAQB"
    },
    "Exercice Flexion Oblique au banc Lombaire": {
      "séries": "5",
      "second": "10",
      "répétitions": "3",
      "lien_video": "https://www.youtube.com/watch?v=DsT8Q5LuJS4&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=10&t=2s&pp=iAQB"
    },
    "Exercice Extension Jambes": {
      "séries": "15",
      "second": "45",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=JoUpSdZq05Y&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=11&pp=iAQB"
    },
    "Exercice Enchainement": {
      "séries": "4",
      "second": "30",
      "répétitions": "6",
      "lien_video": "https://www.youtube.com/watch?v=y2N5NW_Ijto&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=12&t=2s&pp=iAQB"
    },
    "Exercice Elevation du Corps": {
      "séries": "10",
      "second": "30",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=KpQM46oGvUo&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=13&t=3s&pp=iAQB"
    },
    "Exercice Echauffement 2": {
      "séries": "10",
      "second": "30",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=_4GN3WwFtoI&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=14&t=2s&pp=iAQB"
    },
    "Exercice Echauffement 1": {
      "séries": "3",
      "second": "30",
      "répétitions": "2",
      "lien_video": "https://www.youtube.com/watch?v=MD5TBspP868&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=15&t=3s&pp=iAQB"
    },
    "Exercice Push up": {
      "séries": "5",
      "second": "30",
      "répétitions": "1",
      "lien_video": "https://www.youtube.com/watch?v=f3NHeHYaid8&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=16&t=2s&pp=iAQB"
    },
    "Exercice Planche Lateral": {
      "séries": "1",
      "second": "10",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=vTgE8FLCBto&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=17&pp=iAQB"
    },
    "Exercice Leg Raise": {
      "séries": "5",
      "second": "20",
      "répétitions": "1",
      "lien_video": "https://www.youtube.com/watch?v=KhBVOba50Jg&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=18&t=4s&pp=iAQB"
    },
    "Exercice Kicks Hooks": {
      "séries": "1",
      "second": "10",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=slx8b9JwMt0&list=PL9GsY7tWZQwFMyOqE7bb5VwpJyYjvqrqy&index=19&t=1s&pp=iAQB"
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