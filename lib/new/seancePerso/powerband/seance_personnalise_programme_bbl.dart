import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fitness_app/app/components/text_components.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExo.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../modules/monCompte/controller/controller.dart';
import '../../../utils/colors.dart';
import 'package:intl/date_symbol_data_local.dart';

class PowerbandSeancePersonnaliseProgrammeBBL extends StatefulWidget {
  final bool isReturningFromDetails;
  final List<String> joursSemaine;

  const PowerbandSeancePersonnaliseProgrammeBBL({
    super.key,
    this.isReturningFromDetails = false,
    required this.joursSemaine
  });

  @override
  State<PowerbandSeancePersonnaliseProgrammeBBL> createState() => _PowerbandSeancePersonnaliseProgrammeBBLState();
}

class _PowerbandSeancePersonnaliseProgrammeBBLState extends State<PowerbandSeancePersonnaliseProgrammeBBL> {
  late List<List<Exercice>> allWeeksExercices;
  int _currentDayIndex = 0;


  int _dailyBadgesCount = 0;
  int _weeklyBadgesCount = 0;
  int _monthlyBadgesCount = 0;
  Timer? _progressTimer;
  void _startProgressTimer() {
    // Exécuter immédiatement une première fois
    _showStats(false);
    // Puis toutes les 2 secondes
    _progressTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted) {
        _showStats(false);
      } else {
        timer.cancel();
      }
    });
  }

  late List<String> _assignedDays = [];
  bool _daysInitialized = false;

  @override
  void initState() {
    super.initState();
    _startProgressTimer();
    initializeDateFormatting('fr_FR', null).then((_) {
      // Les données de localisation sont maintenant disponibles
      if (mounted) setState(() {});
    });
    _initializeExercices();
    _initializePreferences().then((_) {
      _loadCompletedSessions();
      _loadAssignedDays(); // Charger les jours assignés
      // _loadBadgeCounts();
      // _checkForNewBadges();
    });
  }
  Future<void> _loadAssignedDays() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDays = prefs.getStringList('assignedDays_pgbbl_powerband');

    if (savedDays != null && savedDays.isNotEmpty) {
      setState(() {
        _assignedDays = savedDays;
        _daysInitialized = true;
      });
    } else {
      _initializeAssignedDays();
    }
  }
  void _initializeAssignedDays() {
    List<String> newAssignedDays = [];

    for (int week = 0; week < 12; week++) {
      for (int session = 0; session < 4; session++) {
        int dayIndex = (week * 4 + session) % widget.joursSemaine.length;
        newAssignedDays.add(widget.joursSemaine[dayIndex]);
      }
    }

    setState(() {
      _assignedDays = newAssignedDays;
      _daysInitialized = true;
    });

    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList('assignedDays_pgbbl_powerband', newAssignedDays);
    });
  }
  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  late SharedPreferences _prefs;
  final Set<String> _completedSessions = {};
  void _loadCompletedSessions() {
    Set<String> completedSessions = _prefs.getStringList('completedSessions_pgbbl_powerband')?.toSet() ?? {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList('completedSessions_pgbbl_powerband', _completedSessions.toList());
    });
    print('Session marked as completed: $sessionName'); // Ajoutez ce log
  }

  bool _isSessionCompleted(String sessionName) {
    bool isCompleted = _completedSessions.contains(sessionName);
    print('Session completion check: $sessionName is completed=$isCompleted'); // Ajoutez ce log
    return isCompleted;
  }

  void _initializeExercices() {
    allWeeksExercices = [
      // Semaine 1
      [
        Exercice(
          titre: "Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Soulevé de terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kick",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
        ),
        Exercice(
          titre: "Abduction",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
        ),
      ],
      // Semaine 1 - Bras, Epaules
      [
        Exercice(
          titre: "Développé Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 30),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB",
        ),
        Exercice(
          titre: "Élévations Latérales",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 10),
            SerieConfig(repetitions: 15, charge: 10),
            SerieConfig(repetitions: 15, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curls",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=zS1MBnRvSzk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl Prise Marteau",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 12, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tL0ihj9VtlM&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=23&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Kickback Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 10),
            SerieConfig(repetitions: 15, charge: 10),
            SerieConfig(repetitions: 12, charge: 10),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=fm2dGhQLGYY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=10&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      // Semaine 1 - Cardio & Abdos
      [
        Exercice(
          titre: "Crunch Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=DOLLrr_OaDU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=28&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Crunch Rameur",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 10),
            SerieConfig(repetitions: 15, charge: 10),
            SerieConfig(repetitions: 15, charge: 10),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=p7etPEUabZI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=27&pp=iAQB",
        ),
        Exercice(
          titre: "Mountain Climber",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 10),
            SerieConfig(repetitions: 15, charge: 10),
            SerieConfig(repetitions: 15, charge: 10),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=RJImXD9ySYY&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=2&pp=iAQB",
        ),
      ],
      // Semaine 1 - Ischio & Fessiers
      [
        Exercice(
          titre: "Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 30),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 10, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes Bulgares",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 20),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=XRe0TP4y6A4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=36&pp=iAQB",
        ),
        Exercice(
          titre: "Squat Sumo",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=YA8Mg099KMQ&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=18&pp=iAQB",
        ),
        Exercice(
          titre: "Soulevé de Terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kicks",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
        ),
      ],
      // Semaine 1 - Dos & Pecs
      [
        Exercice(
          titre: "Pompes",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 0),
            SerieConfig(repetitions: 10, charge: 0),
            SerieConfig(repetitions: 10, charge: 0),
            SerieConfig(repetitions: 10, charge: 0),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=6b6RwlYK5-8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=2&pp=iAQB",
        ),
        Exercice(
          titre: "Développé debout à la poulie",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 20),
            SerieConfig(repetitions: 12, charge: 20),
            SerieConfig(repetitions: 12, charge: 20),
            SerieConfig(repetitions: 12, charge: 20),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oWvRMrYblHU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=16&pp=iAQB",
        ),
        Exercice(
          titre: "Pull Over Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Suh9nmccD5o&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=20&pp=iAQB",
        ),
      ],
      // Semaine 2 - Focus Quadriceps
      [
        Exercice(
          titre: "Front Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Soulevé de terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Abduction",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "Adduction",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=T9Cy825h9VU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=8&pp=iAQB",
        ),
      ],
      // Semaine 2 - Bras & Epaules
      [
        Exercice(
          titre: "Biceps Curl",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 0, charge: 0),
            SerieConfig(repetitions: 0, charge: 0),
            SerieConfig(repetitions: 0, charge: 0),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl Poulie Basse",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=lJZqNu8jJEw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=30&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=zS1MBnRvSzk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Verticale",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 10),
            SerieConfig(repetitions: 15, charge: 10),
            SerieConfig(repetitions: 15, charge: 10),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=RbA_omOwd34&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=49&pp=iAQB",
        ),
        Exercice(
          titre: "Face Pull",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=-4RCM-1d8SI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=14&pp=iAQB",
        ),
      ],
      // Semaine 2 - Cardio & Abdo
      [
        Exercice(
          titre: "Crunch Bicyclette",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 10, charge: 10),
            SerieConfig(repetitions: 10, charge: 10),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=xKEC4lT4044&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=41&pp=iAQB",
        ),
        Exercice(
          titre: "Spider Man",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 0),
            SerieConfig(repetitions: 12, charge: 10),
            SerieConfig(repetitions: 12, charge: 10),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=E73ZGk7O_ag&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=5&pp=iAQB",
        ),
        Exercice(
          titre: "Flexion Latérale Oblique",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 20),
            SerieConfig(repetitions: 12, charge: 20),
            SerieConfig(repetitions: 12, charge: 20),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=6jlAeMmHico&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=11&pp=iAQB",
        ),
      ],
      // Semaine 2 - Ischios & fessiers
      [
        Exercice(
          titre: "Squat Sumo",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=YA8Mg099KMQ&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=18&pp=iAQB",
        ),
        Exercice(
          titre: "Squat Swing",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=sKPpu3KX4fM&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=17&pp=iAQB",
        ),
        Exercice(
          titre: "Hip Thrust",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 12, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=1vOQNPzXdZo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Leg Curl",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=YjzWXDSyUsI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=5&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kicks",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
        ),
      ],
      // Semaine 2 - Dos & Pecs
      [
        Exercice(
          titre: "Pompes",
          nombreTotalSerie: 2,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=6b6RwlYK5-8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=2&pp=iAQB",
        ),
        Exercice(
          titre: "Développé debout à la poulie",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 12, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=zAfnnw1-3rc&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Poulie Moyenne",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oWvRMrYblHU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=16&pp=iAQB",
        ),
      ],

      [
        Exercice(
          titre: "Front Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 2,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Fentes rebonds",
          nombreTotalSerie: 2,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hqgaIDAxNyg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=26&pp=iAQB",
        ),
        Exercice(
          titre: "Leg Extension",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Soulevé de terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Abduction",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 10, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Développé Militaire",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Menton",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ER1evvpKjPA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=43&pp=iAQB",
        ),
        Exercice(
          titre: "Élévation Frontale",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 10),
            SerieConfig(repetitions: 12, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=7KjhhHUtg8k&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=32&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Verticale",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=RbA_omOwd34&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=49&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps KickBack Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=fm2dGhQLGYY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=10&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Leg Raise",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 0),
            SerieConfig(repetitions: 12, charge: 10),
            SerieConfig(repetitions: 10, charge: 20),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=b-1IdDUyJho&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=33&pp=iAQB",
        ),
        Exercice(
          titre: "Crunch Rameur",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 0),
            SerieConfig(repetitions: 10, charge: 10),
            SerieConfig(repetitions: 10, charge: 20),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=p7etPEUabZI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=27&pp=iAQB",
        ),
        Exercice(
          titre: "Mountain Climber",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 0),
            SerieConfig(repetitions: 12, charge: 10),
            SerieConfig(repetitions: 12, charge: 20),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=RJImXD9ySYY&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=2&pp=iAQB",
        ),
        Exercice(
          titre: "Gainage",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 1),
            SerieConfig(repetitions: 1),
            SerieConfig(repetitions: 1),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=7xEOh4yZJ2Y&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=4&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Donkey Kicks",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes Bulgares",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=XRe0TP4y6A4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=36&pp=iAQB",
        ),
        Exercice(
          titre: "Hip Thrust",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 10, charge: 70),
            SerieConfig(repetitions: 10, charge: 70),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=1vOQNPzXdZo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Soulevé de Terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Leg Curl",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=YjzWXDSyUsI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=5&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Développé Debout à La Poulie",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 10, charge: 70),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Développé Joint",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 10, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=E8vgLRa-HU0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=25&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oWvRMrYblHU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=16&pp=iAQB",
        ),
        Exercice(
          titre: "Pull Over Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Suh9nmccD5o&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=20&pp=iAQB",
        ),
      ],

      [
        Exercice(
          titre: "Front Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Soulevé de terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Abduction",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "Adduction",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=T9Cy825h9VU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=8&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Biceps Curl",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=zS1MBnRvSzk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=VKZBNQCYebM&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=44&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Triceps KickBack Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 30),
            SerieConfig(repetitions: 10, charge: 30),
            SerieConfig(repetitions: 10, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=fm2dGhQLGYY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=10&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Oiseau",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=PQrxt7RCtQ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=21&pp=iAQB",
        ),
        Exercice(
          titre: "Élévations Latérales",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 30),
            SerieConfig(repetitions: 10, charge: 30),
            SerieConfig(repetitions: 10, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Crunch Bicyclette",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=xKEC4lT4044&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=41&pp=iAQB",
        ),
        Exercice(
          titre: "Spiderman",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=Muit-Ys3q5Y&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=19&pp=iAQB",
        ),
        Exercice(
          titre: "Flexion Latérale Oblique",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 30),
            SerieConfig(repetitions: 10, charge: 30),
            SerieConfig(repetitions: 10, charge: 30),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=6jlAeMmHico&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=11&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Squat Rythmé",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=HMYUk6zA56Q&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes Rebond",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Soulevé de Terre",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Leg Curl",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=YjzWXDSyUsI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=5&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kicks",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Développé Debout à la Poulie",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 70),
            SerieConfig(repetitions: 10, charge: 70),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Développé Joint",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 8, charge: 60),
            SerieConfig(repetitions: 8, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=E8vgLRa-HU0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=25&pp=iAQB",
        ),
        Exercice(
          titre: "Ecarté Unilatéral",
          nombreTotalSerie: 2,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=zAfnnw1-3rc&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 40),
            SerieConfig(repetitions: 8, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Poulie Moyenne",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 8, charge: 60),
            SerieConfig(repetitions: 8, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oWvRMrYblHU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=16&pp=iAQB",
        ),
        Exercice(
          titre: "Pull Over Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 10, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Suh9nmccD5o&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=20&pp=iAQB",
        ),
      ],
      // Semaine 6
      [
        Exercice(
          titre: "Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 9,
          seriesConfigs: [
            SerieConfig(repetitions: 2, charge: 50),
            SerieConfig(repetitions: 4, charge: 50),
            SerieConfig(repetitions: 6, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 6, charge: 50),
            SerieConfig(repetitions: 4, charge: 50),
            SerieConfig(repetitions: 2, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=LexBY5nXIqI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=12&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Soulevé de Terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Leg Extension",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 70),
            SerieConfig(repetitions: 10, charge: 70),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Abduction",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=r5LuwQwapJ4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=9&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Biceps Curl Poulie Basse",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=lJZqNu8jJEw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=30&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Triceps Extension Verticale",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=RbA_omOwd34&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=49&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 8, charge: 60),
            SerieConfig(repetitions: 8, charge: 60),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Barre au Front",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9aMKzSbLBf4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=50&pp=iAQB",
        ),
        Exercice(
          titre: "Développé Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB",
        ),
        Exercice(
          titre: "Face Pull",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=-4RCM-1d8SI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=14&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Leg Raise",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 20),
            SerieConfig(repetitions: 12, charge: 20),
            SerieConfig(repetitions: 12, charge: 20),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=b-1IdDUyJho&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=33&pp=iAQB",
        ),
        Exercice(
          titre: "Crunch Rameur",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=p7etPEUabZI&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=27&pp=iAQB",
        ),
        Exercice(
          titre: "Mountain Climber",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
            SerieConfig(repetitions: 10, charge: 20),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=RJImXD9ySYY&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=2&pp=iAQB",
        ),
        Exercice(
          titre: "Gainage",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 1),
            SerieConfig(repetitions: 1),
            SerieConfig(repetitions: 1),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=7xEOh4yZJ2Y&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=4&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Donkey Kick",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes Bulgares",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 10, charge: 50),
            SerieConfig(repetitions: 8, charge: 60),
            SerieConfig(repetitions: 8, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=XRe0TP4y6A4&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=36&pp=iAQB",
        ),
        Exercice(
          titre: "Hip Thrust",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=1vOQNPzXdZo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Squat Swing",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=sKPpu3KX4fM&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=17&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kick",
          nombreTotalSerie: 2,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=13&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Pompes",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=6b6RwlYK5-8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=2&pp=iAQB",
        ),
        Exercice(
          titre: "Développé Debout à la Poulie",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 90),
            SerieConfig(repetitions: 8, charge: 90),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=zAfnnw1-3rc&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oWvRMrYblHU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=16&pp=iAQB",
        ),
        Exercice(
          titre: "Pull Over Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Suh9nmccD5o&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=20&pp=iAQB",
        ),
      ],
    ];
  }




  bool _isTrainingDay() {
    DateTime now = DateTime.now();
    String currentDay = DateFormat('EEEE').format(now);
    return widget.joursSemaine.contains(currentDay);
  }

  int _getCurrentSessionIndex() {
    DateTime now = DateTime.now();
    String currentDay = DateFormat('EEEE').format(now);

    if (!widget.joursSemaine.contains(currentDay)) {
      return -1; // Aucune séance aujourd'hui
    }

    int dayIndex = widget.joursSemaine.indexOf(currentDay);

    return dayIndex % 4; // Adaptez cette logique à votre besoin
  }
  SharedPreferences? prefs;

  int getCurrentWeek() {
    if (prefs == null) return 1; // Valeur par défaut si prefs n'est pas initialisé

    DateTime now = DateTime.now();
    String? programGenerationDate = prefs!.getString('programGenerationDate_pgbbl_powerband');
    if (programGenerationDate == null) return 1; // Valeur par défaut si la date n'est pas définie

    DateTime startDate = DateTime.parse(programGenerationDate);
    int daysSinceStart = now.difference(startDate).inDays;
    return (daysSinceStart ~/ 7) + 1;
  }

// Modifiez _buildExerciseBox comme ceci :
  Widget _buildExerciseBox(String exerciseName, int dayIndex, int exerciseIndex, int semaine, int seance) {
    int currentWeek = getCurrentWeek();
    bool isCurrentWeek = (dayIndex ~/ 4) + 1 == currentWeek;

    // Vérifie si c'est le jour assigné à cette séance
    String assignedDay = _getSessionDaysText(semaine - 1, seance - 1);
    DateTime now = DateTime.now();
    String currentDay = DateFormat('EEEE', 'fr_FR').format(now).toLowerCase();

    // Normaliser les chaînes pour comparaison
    bool isAssignedDayToday = assignedDay.toLowerCase() == currentDay;

    print("Assigned day: $assignedDay");
    print("Current day: $currentDay");
    print("Is assigned day today: $isAssignedDayToday");

    return InkWell(
      onTap: isCurrentWeek && isAssignedDayToday
          ? () => _navigateToSessionDetails(dayIndex, exerciseIndex, semaine, seance)
          : () {
        showToast(context, "Veuillez attendre le $assignedDay avant de faire cet Exercice", Colors.red);
      },
      child: Card(
        color: isCurrentWeek && isAssignedDayToday ? Colors.white : Colors.red[50],
        elevation: isCurrentWeek && isAssignedDayToday ? 3 : 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(_isSessionCompleted('semaine${semaine}_seance${seance}_exo$exerciseIndex')
                  ? Icons.check_circle : Icons.check_circle_outline,
                  color: _isSessionCompleted('semaine${semaine}_seance${seance}_exo$exerciseIndex')
                      ? Colors.green : Colors.red,
                  size: 35),
              SizedBox(width: 12),
              Expanded(
                child: TextComponent(
                  text: exerciseName,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              if (!(isCurrentWeek && isAssignedDayToday))
                Icon(Icons.lock, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ),
    );
  }



  void _navigateToSessionDetails(int dayIndex, int exerciseIndex, semaine, seance) {
    if (dayIndex >= allWeeksExercices.length) return;

    final exercices = allWeeksExercices[dayIndex];

    if (exerciseIndex >= 0 && exerciseIndex < exercices.length) {
      final exercice = exercices[exerciseIndex];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Lecturevideosexo(
            repos: exercice.repos,
            linkVideo: exercice.linkVideo,
            seriesConfigs: exercice.seriesConfigs,
            nombreTotalSerie: exercice.nombreTotalSerie,
            onComplete: () => _markSessionAsCompleted('semaine${semaine}_seance${seance}_exo$exerciseIndex'),

          ),
        ),
      );
    }
  }

  String _getSessionDaysText(int week, int session) {
    if (!_daysInitialized) return "Chargement...";

    int index = week * 4 + session;
    if (index < _assignedDays.length) {
      return _assignedDays[index];
    }
    return widget.joursSemaine[0]; // Valeur par défaut
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        centerTitle: true,
        title: const Text(
          "Programme BBL - Powerband",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    /*  floatingActionButton: FloatingActionButton(
        onPressed:() =>  _showStats(true),
        child: Icon(Icons.emoji_events),
        backgroundColor: mainColor,
      ),*/
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/images/ventre_plat_et_abdos.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Programme complet
            for (int week = 0; week < 12; week++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(
                    text: "Semaine ${week + 1}",
                      fontWeight: FontWeight.bold, size: 16
                  ),
                  SizedBox(height: 10),

                  for (int session = 0; session < 4; session++)
                    if ((week * 4 + session) < allWeeksExercices.length)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TextComponent(text: "Séance ${session + 1} - ",
                                  fontWeight: FontWeight.w600
                                // style: TextStyle(),
                              ),
                              TextComponent(text: _getSessionDaysText(week, session),
                                  fontWeight: FontWeight.w600
                              )
                            ],
                          ),
                          SizedBox(height: 5),

                          ...allWeeksExercices[week * 4 + session].asMap().entries.map((entry) {
                            int index = entry.key;
                            Exercice ex = entry.value;
                            return _buildExerciseBox(
                              ex.titre,
                              week * 4 + session,
                              index,
                                week + 1,
                                session + 1
                            );
                          }),
                          SizedBox(height: 15),
                        ],
                      ),
                  Divider(height: 30, color: Colors.grey[300]),
                ],
              ),
          ],
        ),
      ),
    );
  }
  Widget _buildBadgeAlert(String title, String message, IconData icon, Color color) {
    return Center(
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 5),
              Text(message, style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showStats(bool show) async {
    int totalExercices = allWeeksExercices.fold(0, (sum, session) => sum + session.length);
    int completedExercices = _completedSessions.length;
    double completionPercentage = (completedExercices / totalExercices) * 100;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('progressionGlobale_pgbbl_powerband', completionPercentage);

    show? showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Vos Récompenses'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Progression globale: ${completionPercentage.toStringAsFixed(1)}%'),
            LinearProgressIndicator(value: completionPercentage / 100),
            SizedBox(height: 20),
            _buildStatItem('Badges journaliers', _dailyBadgesCount, Icons.calendar_today),
            _buildStatItem('Badges hebdomadaires', _weeklyBadgesCount, Icons.date_range),
            _buildStatItem('Badges mensuels', _monthlyBadgesCount, Icons.calendar_month),
          ],
        ),
      ),
    ):null;
  }


  Widget _buildStatItem(String label, int count, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: mainColor),
          SizedBox(width: 10),
          Text(label, style: TextStyle(fontSize: 16)),
          Spacer(),
          Text(count.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class Exercice {
  final String titre;
  final int nombreTotalSerie;
  final List<SerieConfig> seriesConfigs;
  final int repos;
  final String linkVideo;

  Exercice({
    required this.titre,
    required this.nombreTotalSerie,
    required this.seriesConfigs,
    required this.repos,
    required this.linkVideo,
  });
}

