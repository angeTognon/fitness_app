import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/main.dart';
import 'package:fitness_app/modules/monCompte/controller/controller.dart';
import 'package:fitness_app/modules/stockageSeancePersoList/stockage.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_app/modules/details/details_seances_from_seance_perso.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/components/text_components.dart';
import '../../utils/colors.dart';

class RoutineCorpsComplet extends StatefulWidget {
  final bool isReturningFromDetails;
  List<String> joursSemaine;
  RoutineCorpsComplet({super.key, this.isReturningFromDetails = false, required this.joursSemaine});

  @override
  State<RoutineCorpsComplet> createState() => _RoutineCorpsCompletState();
}

class _RoutineCorpsCompletState extends State<RoutineCorpsComplet> {
  final List<String> _warmUpExercises = [
    "RS Echauffement 1",
    "RS Echauffement 2",
  ];

  final List<String> _mainExercises = [
    "RS Tirage Montant",
    "RS Rotation Russe",
    "RS Planche Gainage",
    "RS Flexion Laterale",
    "RS Elevation Laterale Epaules",
    "RS Elevation Genoux",
    "RS Tirage Horizontale 2",
    "RS Tirage Horizontale 1",
    "RS Tirage Frontale Biceps",
    "RS Rowing à la Poulie",
    "RS Elevation Frontale",
    "RS Elevation Frontale Gauche Droite",
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
    _initializePreferences().then((_) {
      _loadProgram();
      _timer = Timer.periodic(Duration(seconds: 2), (timer) {
        _loadProgram();
      });
      _getCurrentDayIndex();
      saveProgramGenerationDate();
    });
  }

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
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
          text: "Routine Corps complet",
          color: Colors.white,
          size: 15,
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
                    // SizedBox(height: 20),

                    Divider(color: Colors.grey[300], thickness: 1),
                    // SizedBox(height: 20),

                  ],
                ),
            ] else
              Center(child: CircularProgressIndicator()),

            /*if (_currentDayIndex != -1) ...[
              TextComponent(
                text: "Jour ${_currentDayIndex + 1}",
                fontWeight: FontWeight.bold,
                color: Colors.black,
                size: 14,
              ),
              ..._program[_currentDayIndex].asMap().entries.map((entry) {
                int exerciseIndex = entry.key;
                Map<String, double> exerciseMap = entry.value;
                String exerciseName = exerciseMap.keys.first;
                double progress = exerciseMap[exerciseName]!;

                return buildExerciseBox(exerciseName, _currentDayIndex, exerciseIndex, progress.toInt());
              }).toList(),
            ] else
              Center(child: CircularProgressIndicator()),*/
          ],
        ),
      ),
    );
  }
  final Map<String, Map<String, String>> exerciseDetails = {
    /*
    *  "",
    "RS Rotation Russe",
    "RS Planche Gainage",
    "RS Flexion Laterale",
    "RS Elevation Laterale Epaules",
    "RS Elevation Genoux",
    "RS Tirage Horizontale 2",
    "RS Tirage Horizontale 1",
    "RS Tirage Frontale Biceps",
    "RS Rowing à la Poulie",
    "RS Elevation Frontale",
    "RS Elevation Frontale Gauche Droite",
    * */
    "RS Tirage Montant": {
      "séries": "15",
      "second": "30",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=HTdmnGPF1hQ&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=1&t=6s&pp=iAQB"
    },
    "RS Rotation Russe": {
      "séries": "12",
      "second": "40",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=XIxBP1sDwCg&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=2&t=8s&pp=iAQB"
    },
    "RS Planche Gainage": {
      "séries": "1",
      "second": "20",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=62oSxc2yaVI&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=3&t=6s&pp=iAQB"
    },
    "RS Flexion Laterale": {
      "séries": "20",
      "second": "50",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=elt2FRzpd4E&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=5&t=7s&pp=iAQB"
    },
    "RS Elevation Laterale Epaules": {
      "séries": "15",
      "second": "50",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=F40I2pgIqJg&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=6&t=11s&pp=iAQB"
    },
    "RS Elevation Genoux": {
      "séries": "10",
      "second": "30",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=y4dDqsYyQb4&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=7&t=6s&pp=iAQB"
    },
    "RS Tirage Horizontale 2": {
      "séries": "15",
      "second": "55",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=3XatVJGA9ZQ&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=8&t=6s&pp=iAQB"
    },
    "RS Tirage Horizontale 1": {
      "séries": "20",
      "second": "60",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=OZFbiUih6vs&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=9&t=5s&pp=iAQB"
    },
    "RS Tirage Frontale Biceps": {
      "séries": "20",
      "second": "60",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=BJ3LxU-jDVI&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=10&pp=iAQB"
    },
    "RS Rowing à la Poulie": {
      "séries": "15",
      "second": "55",
      "répétitions": "5",
      "lien_video": "https://www.youtube.com/watch?v=IEtMWCnsKWs&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=11&pp=iAQB"
    },
    "RS Elevation Frontale": {
      "séries": "15",
      "second": "50",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=fGfF-7PckgY&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=12&t=5s&pp=iAQB"
    },
    "RS Elevation Frontale Gauche Droite": {
      "séries": "15",
      "second": "55",
      "répétitions": "4",
      "lien_video": "https://www.youtube.com/watch?v=zRSQJwptHfE&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=13&t=6s&pp=iAQB"
    },
    "RS Echauffement 2": {
      "séries": "10",
      "second": "30",
      "répétitions": "3",
      "lien_video": "https://www.youtube.com/watch?v=a4Jn5cJ_has&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=14&t=7s&pp=iAQB"
    },
    "RS Echauffement 1": {
      "séries": "1",
      "second": "10",
      "répétitions": "3",
      "lien_video": "https://www.youtube.com/watch?v=CaIJukDqUT8&list=PL9GsY7tWZQwGcpETJYxg5Xd8dALaZsZZL&index=15&pp=iAQB"
    },
  };
  double nbrManque = 0;
  SharedPreferences? prefs;
  int getCurrentWeek() {
    if (prefs == null) return 1; // Valeur par défaut si prefs n'est pas initialisé

    DateTime now = DateTime.now();
    String? programGenerationDate = prefs!.getString('programGenerationDate');
    if (programGenerationDate == null) return 1; // Valeur par défaut si la date n'est pas définie

    DateTime startDate = DateTime.parse(programGenerationDate);
    int daysSinceStart = now.difference(startDate).inDays;
    return (daysSinceStart ~/ 7) + 1;
  }

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
        print(numberOfSeries);
        String jourSelectionne = "Jour ${dayIndex + 1}";

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? programGenerationDate = prefs.getString('programGenerationDate');
        print("{$dayIndex ; $exerciseIndex }");
        print("************************${exerciseName}*****************************");
        String videoUrl = exerciseDetails[exerciseName]!["lien_video"]!;
        print(videoUrl);
        print("************************FIN*****************************");

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
          : (){
        String jourSelectionne = "Jour ${dayIndex + 1}";
        showToast(context, "Veuillez attendre le jour $jourSelectionne avant de faire cet Exercice", Colors.red);},
      child: Card(
        color: isCurrentWeek && isCurrentDay ? Colors.white : Colors.redAccent.withOpacity(0.1),
        elevation: isCurrentWeek && isCurrentDay ? 3 :0,
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