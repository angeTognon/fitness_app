import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fitness_app/app/components/text_components.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExo.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../modules/monCompte/controller/controller.dart';
import '../../../utils/colors.dart';
import 'package:intl/date_symbol_data_local.dart';

class StepperSeancePersoProgrammeBBL extends StatefulWidget {
  final bool isReturningFromDetails;
  final List<String> joursSemaine;

  const StepperSeancePersoProgrammeBBL(
      {super.key,
      this.isReturningFromDetails = false,
      required this.joursSemaine});

  @override
  State<StepperSeancePersoProgrammeBBL> createState() =>
      _StepperSeancePersoProgrammeBBLState();
}

class _StepperSeancePersoProgrammeBBLState
    extends State<StepperSeancePersoProgrammeBBL> {
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
    final savedDays = prefs.getStringList('assignedDays_pgbbl_stepper');

    if (savedDays != null && savedDays.isNotEmpty) {
      setState(() {
        _assignedDays = savedDays;
        _daysInitialized = true;
      });
    } else {
      // Initialiser pour la première fois
      _initializeAssignedDays();
    }
  }

  void _initializeAssignedDays() {
    List<String> newAssignedDays = [];

    for (int week = 0; week < 12; week++) {
      for (int session = 0; session < 4; session++) {
        // Prend le jour suivant dans l'ordre de la liste joursSemaine
        int dayIndex = (week * 4 + session) % widget.joursSemaine.length;
        newAssignedDays.add(widget.joursSemaine[dayIndex]);
      }
    }

    setState(() {
      _assignedDays = newAssignedDays;
      _daysInitialized = true;
    });

    // Sauvegarder
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList('assignedDays_pgbbl_stepper', newAssignedDays);
    });
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    // Arrêter le timer quand le widget est supprimé
    _progressTimer?.cancel();
    super.dispose();
  }

  late SharedPreferences _prefs;
  final Set<String> _completedSessions = {};
  void _loadCompletedSessions() {
    Set<String> completedSessions =
        _prefs.getStringList('completedSessions_pgbbl_stepper')?.toSet() ??
            {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList(
          'completedSessions_pgbbl_stepper', _completedSessions.toList());
    });
    print('Session marked as completed: $sessionName'); // Ajoutez ce log
  }

  bool _isSessionCompleted(String sessionName) {
    bool isCompleted = _completedSessions.contains(sessionName);
    print(
        'Session completion check: $sessionName is completed=$isCompleted'); // Ajoutez ce log
    return isCompleted;
  }

  void _initializeExercices() {
    allWeeksExercices = [
      // Semaine 1
        // Séance 1
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=uOIDhnX1U0U&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=12&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Rowing",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=uOIDhnX1U0U&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=12&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Rowing",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
        ],
        // Séance 4
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
        ],
        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
          Exercice(
            titre: "SF Fente Arrière",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jF5QMvvRA1w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=24&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Rotation Oblique",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=bzCKZ961VgU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=3&pp=iAQB",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
          Exercice(
            titre: "SF Gainage",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
          Exercice(
            titre: "SF Fente Arrière",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jF5QMvvRA1w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=24&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Rotation Oblique",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=bzCKZ961VgU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=3&pp=iAQB",
          ),
        ],
        // Séance 4
        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
          Exercice(
            titre: "SF Gainage",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
          ),
        ],
        // Séance 1
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Menton",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Elevation Frontale",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
          ),
          Exercice(
            titre: "SF Rowing Buste Penché",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=MUkMFCKwuOQ&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=26&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Menton",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
        ],
        // Séance 4
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Frontale",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
          ),
          Exercice(
            titre: "SF Rowing Buste Penché",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=MUkMFCKwuOQ&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=26&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
        ],
        // Séance 1
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Rowing",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
          Exercice(
            titre: "SF Fente Arriere Pieds Flechis",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=DBy_d7jeT-w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=18&pp=iAQB",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
          Exercice(
            titre: "SF Fente Arrière",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jF5QMvvRA1w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=24&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Rowing",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
          Exercice(
            titre: "SF Fente Arriere Pieds Flechis",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=DBy_d7jeT-w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=18&pp=iAQB",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
        ],
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
          Exercice(
            titre: "SF Fente Arrière",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jF5QMvvRA1w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=24&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
        ],
        // Séance 1
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
          Exercice(
            titre: "SF Squat",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
          ),
          Exercice(
            titre: "SF Gainage",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Menton",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Squat en Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=NERG2rQHUIw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=8&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Rotation Oblique",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=bzCKZ961VgU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=3&pp=iAQB",
          ),
          Exercice(
            titre: "SF Rowing",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
          Exercice(
            titre: "SF Squat",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
        ],
        // Séance 4
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Menton",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Fente Arrière Pieds Tendus",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=fodKg2BEUHY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=17&pp=iAQB",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
        ],
        // Séance 1
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Rowing",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Frontale",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Rowing",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
        ],
        // Séance 4
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Frontale",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
          ),
        ],
        // Séance 1
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
          Exercice(
            titre: "SF Squat",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Menton",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Fente Arrière Pieds Tendus",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=fodKg2BEUHY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=17&pp=iAQB",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
          Exercice(
            titre: "SF Squat",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
        ],
        // Séance 4
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Menton",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Fente Arrière Pieds Tendus",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=fodKg2BEUHY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=17&pp=iAQB",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
        ],
        // Séance 1
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
          Exercice(
            titre: "SF Crunch Abdominal",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=N_fcDK2sBes&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=23&pp=iAQB",
          ),
          Exercice(
            titre: "SF Fente Arriere Pieds Flechis",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=DBy_d7jeT-w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=18&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Frontale",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
          ),
          Exercice(
            titre: "SF Gainage",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
          Exercice(
            titre: "SF Crunch Abdominal",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=N_fcDK2sBes&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=23&pp=iAQB",
          ),
          Exercice(
            titre: "SF Fente Arriere Pieds Flechis",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=DBy_d7jeT-w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=18&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
        ],
        // Séance 4
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
          Exercice(
            titre: "SF Crunch Abdominal",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=N_fcDK2sBes&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=23&pp=iAQB",
          ),
          Exercice(
            titre: "SF Fente Arriere Pieds Flechis",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=DBy_d7jeT-w&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=18&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
        ],
        // Séance 1
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
          Exercice(
            titre: "SF Rowing",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Soulever de Terre Roumain",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=isj192K-UYw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=9&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
        ],
        // Séance 4
        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Leg Extension Lateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=jqU53o7Y-mM&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=16&pp=iAQB",
          ),
          Exercice(
            titre: "SF Rowing",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
        ],
        // Séance 1
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Menton",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Rowing",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "SF Echauffement",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=Cy_AQAGSdCU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=20&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=uOIDhnX1U0U&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=12&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Menton",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Rowing",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=9DlNRZGY8x8&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=10&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
        ],
        // Séance 4
        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Horizontal (Dos)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=E-NDyy3hWc0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=6&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=uOIDhnX1U0U&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=12&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
        ],

        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Crunch Abdominal",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=N_fcDK2sBes&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=23&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Menton",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Gainage",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=-fsrdBfIDto&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=21&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Frontale",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Crunch Abdominal",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=N_fcDK2sBes&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=23&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Menton",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=czCxqc21fnA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=5&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
        ],
        // Séance 4
        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Crunch Abdominal",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=N_fcDK2sBes&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=23&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Frontale",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
        ],
        // Séance 1
        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Fente Arrière Pieds Tendus",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=fodKg2BEUHY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=17&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Frontale",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
        ],
        // Séance 2
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Squat",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
        ],
        // Séance 3
        [
          Exercice(
            titre: "SF Etirements",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=M9iXeU2VQ6M&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=22&pp=iAQB0gcJCYUJAYcqIYzv",
          ),
          Exercice(
            titre: "SF Fente Arrière Pieds Tendus",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=fodKg2BEUHY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=17&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Frontale",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=efAU4yDCC-k&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=11&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Marteau Concentré",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=jroqW8byqi0&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=13&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Vertical Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=WVtyCpuztAw&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=2&pp=iAQB",
          ),
        ],
        // Séance 4
        [
          Exercice(
            titre: "Séance Cardio",
            nombreTotalSerie: 1,
            seriesConfigs: [SerieConfig(repetitions: 1)],
            repos: 0,
            linkVideo: "https://www.youtube.com/watch?v=0kKXMOalSiY&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=14&pp=iAQB",
          ),
          Exercice(
            titre: "SF Squat",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=_CZT-WRjG_g&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=7&pp=iAQB",
          ),
          Exercice(
            titre: "SF Elevation Unilateral",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 20)),
            repos: 60,
            linkVideo: "https://www.youtube.com/watch?v=87iyGBXYzH4&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=19&pp=iAQB",
          ),
          Exercice(
            titre: "SF Biceps Curls Supination (Concentré)",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=S7qSv0Z0rzA&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=25&pp=iAQB",
          ),
          Exercice(
            titre: "SF Tirage Nuque Triceps",
            nombreTotalSerie: 5,
            seriesConfigs: List.generate(5, (index) => SerieConfig(repetitions: 15)),
            repos: 45,
            linkVideo: "https://www.youtube.com/watch?v=FvDYVoEEsUU&list=PL27ZZQGb4Vdwexf_AvWD9UOiK_LKIpfgp&index=4&pp=iAQB",
          ),
        ],
    ];
  }

  SharedPreferences? prefs;

  int getCurrentWeek() {
    if (prefs == null)
      return 1; // Valeur par défaut si prefs n'est pas initialisé

    DateTime now = DateTime.now();
    String? programGenerationDate = prefs!.getString('programGenerationDate');
    if (programGenerationDate == null)
      return 1; // Valeur par défaut si la date n'est pas définie

    DateTime startDate = DateTime.parse(programGenerationDate);
    int daysSinceStart = now.difference(startDate).inDays;
    return (daysSinceStart ~/ 7) + 1;
  }

  Widget _buildExerciseBox(String exerciseName, int dayIndex, int exerciseIndex,
      int semaine, int seance) {
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
          ? () => _navigateToSessionDetails(
              dayIndex, exerciseIndex, semaine, seance)
          : () {
              showToast(
                  context,
                  "Veuillez attendre le $assignedDay avant de faire cet Exercice",
                  Colors.red);
            },
      child: Card(
        color:
            isCurrentWeek && isAssignedDayToday ? Colors.white : Colors.red[50],
        elevation: isCurrentWeek && isAssignedDayToday ? 3 : 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                  _isSessionCompleted(
                          'semaine${semaine}_seance${seance}_exo$exerciseIndex')
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  color: _isSessionCompleted(
                          'semaine${semaine}_seance${seance}_exo$exerciseIndex')
                      ? Colors.green
                      : Colors.red,
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

  void _navigateToSessionDetails(
      int dayIndex, int exerciseIndex, semaine, seance) {
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
            onComplete: () => _markSessionAsCompleted(
                'semaine${semaine}_seance${seance}_exo$exerciseIndex'),
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
          "Programme BBL - Stepper",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
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

            for (int week = 0; week < 12; week++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(
                      text: "Semaine ${week + 1}",
                      fontWeight: FontWeight.bold,
                      size: 16),
                  SizedBox(height: 10),
                  for (int session = 0; session < 4; session++)
                    if ((week * 4 + session) < allWeeksExercices.length)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TextComponent(
                                  text: "Séance ${session + 1} - ",
                                  fontWeight: FontWeight.w600
                                  // style: TextStyle(),
                                  ),
                              TextComponent(
                                  text: _getSessionDaysText(week, session),
                                  fontWeight: FontWeight.w600)
                            ],
                          ),
                          SizedBox(height: 5),
                          ...allWeeksExercices[week * 4 + session]
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            Exercice ex = entry.value;
                            return _buildExerciseBox(
                                ex.titre,
                                week * 4 + session,
                                index,
                                week + 1,
                                session + 1);
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


  Future<void> _showStats(bool show) async {
    int totalExercices =
        allWeeksExercices.fold(0, (sum, session) => sum + session.length);
    int completedExercices = _completedSessions.length;
    double completionPercentage = (completedExercices / totalExercices) * 100;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(
        'progressionGlobale_pgbbl_stepper', completionPercentage);

    show
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Vos Récompenses'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Progression globale: ${completionPercentage.toStringAsFixed(1)}%'),
                  LinearProgressIndicator(value: completionPercentage / 100),
                  SizedBox(height: 20),
                  _buildStatItem('Badges journaliers', _dailyBadgesCount,
                      Icons.calendar_today),
                  _buildStatItem('Badges hebdomadaires', _weeklyBadgesCount,
                      Icons.date_range),
                  _buildStatItem('Badges mensuels', _monthlyBadgesCount,
                      Icons.calendar_month),
                ],
              ),
            ),
          )
        : null;
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
          Text(count.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
