import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/app/components/text_components.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExo.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../modules/monCompte/controller/controller.dart';
import '../../../utils/colors.dart';

const String _completedSessionsKey = 'completedSessions';
const String _dailyBadgesKey = 'dailyBadges';
const String _weeklyBadgesKey = 'weeklyBadges';
const String _monthlyBadgesKey = 'monthlyBadges';


class PerteDePoidsFemmeSeancePerso extends StatefulWidget {
  final bool isReturningFromDetails;
  final List<String> joursSemaine;

  const PerteDePoidsFemmeSeancePerso({
    super.key,
    this.isReturningFromDetails = false,
    required this.joursSemaine
  });

  @override
  State<PerteDePoidsFemmeSeancePerso> createState() => _PerteDePoidsFemmeSeancePersoState();
}

class _PerteDePoidsFemmeSeancePersoState extends State<PerteDePoidsFemmeSeancePerso> {
  late List<List<Exercice>> allWeeksExercices;
  int _currentDayIndex = 0;


  int _dailyBadgesCount = 0;
  int _weeklyBadgesCount = 0;
  int _monthlyBadgesCount = 0;
  bool _showDailyBadge = false;
  bool _showWeeklyBadge = false;
  bool _showMonthlyBadge = false;
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
  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadAssignedDays() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDays = prefs.getStringList('assignedDays');

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
      prefs.setStringList('assignedDays', newAssignedDays);
    });
  }

  String _getSessionDaysText(int week, int session) {
    if (!_daysInitialized) return "Chargement...";

    int index = week * 4 + session;
    if (index < _assignedDays.length) {
      return _assignedDays[index];
    }
    return widget.joursSemaine[0]; // Valeur par défaut
  }

  void _checkDailyBadge() async {
    if (_prefs == null) return;
    DateTime now = DateTime.now();
    String todayKey = '${now.year}-${now.month}-${now.day}';

    if (_prefs!.getBool('dailyBadge_$todayKey') ?? false) return;

    // Trouver toutes les sessions du jour
    int completedCount = 0;
    int totalCount = 0;

    String currentDay = DateFormat('EEEE').format(now);
    if (widget.joursSemaine.contains(currentDay)) {
      int dayIndex = widget.joursSemaine.indexOf(currentDay);
      int currentWeek = getCurrentWeek();

      // Parcourir toutes les semaines pour ce jour
      for (int week = 0; week < 12; week++) {
        int sessionIndex = week * 4 + (dayIndex % 4);
        if (sessionIndex < allWeeksExercices.length) {
          totalCount += allWeeksExercices[sessionIndex].length;

          // Vérifier chaque exercice
          for (int exoIndex = 0; exoIndex < allWeeksExercices[sessionIndex].length; exoIndex++) {
            if (_isSessionCompleted('semaine${week+1}_seance${(dayIndex%4)+1}_exo$exoIndex')) {
              completedCount++;
            }
          }
        }
      }
    }

    print('Daily badge check: completedCount=$completedCount, totalCount=$totalCount'); // Ajoutez ce log

    if (completedCount >= totalCount && totalCount > 0) {
      setState(() {
        _dailyBadgesCount++;
        _showDailyBadge = true;
        print('Daily badge awarded, setting state'); // Ajoutez ce log
      });
      await _prefs!.setInt(_dailyBadgesKey, _dailyBadgesCount);
      await _prefs!.setBool('dailyBadge_$todayKey', true);

      Future.delayed(Duration(seconds: 3), () {
        if (mounted) setState(() => _showDailyBadge = false);
      });
    } else {
      print('Daily badge not awarded'); // Ajoutez ce log
    }
  }
  int _getWeekNumber(DateTime date) {
    return ((date.day - date.weekday + 10) / 7).floor();
  }

  List<String> _getSessionsForDay(DateTime date) {
    String dayName = DateFormat('EEEE').format(date);
    if (!widget.joursSemaine.contains(dayName)) return [];

    int dayIndex = widget.joursSemaine.indexOf(dayName);
    int weekNumber = _getWeekNumber(date);
    int sessionIndex = (weekNumber * widget.joursSemaine.length + dayIndex) % allWeeksExercices.length;

    return allWeeksExercices[sessionIndex].map((e) => e.titre).toList();
  }

  List<String> _getCompletedSessionsForDay(DateTime date) {
    String dayName = DateFormat('EEEE').format(date);
    if (!widget.joursSemaine.contains(dayName)) return [];

    int dayIndex = widget.joursSemaine.indexOf(dayName);
    int weekNumber = _getWeekNumber(date);
    int sessionIndex = (weekNumber * widget.joursSemaine.length + dayIndex) % allWeeksExercices.length;

    List<String> completed = [];
    for (int exoIndex = 0; exoIndex < allWeeksExercices[sessionIndex].length; exoIndex++) {
      int semaine = (sessionIndex ~/ 4) + 1;
      int seance = (sessionIndex % 4) + 1;
      if (_isSessionCompleted('semaine${semaine}_seance${seance}_exo$exoIndex')) {
        completed.add(allWeeksExercices[sessionIndex][exoIndex].titre);
      }
    }
    return completed;
  }


  List<String> _getSessionsForWeek(DateTime date) {
    int weekNumber = _getWeekNumber(date);
    List<String> allSessions = [];

    for (int dayIndex = 0; dayIndex < widget.joursSemaine.length; dayIndex++) {
      int sessionIndex = (weekNumber * widget.joursSemaine.length + dayIndex) % allWeeksExercices.length;
      allSessions.addAll(allWeeksExercices[sessionIndex].map((e) => e.titre));
    }

    return allSessions;
  }

  List<String> _getCompletedSessionsForWeek(DateTime date) {
    int weekNumber = _getWeekNumber(date);
    List<String> completedSessions = [];

    for (int dayIndex = 0; dayIndex < widget.joursSemaine.length; dayIndex++) {
      int sessionIndex = (weekNumber * widget.joursSemaine.length + dayIndex) % allWeeksExercices.length;

      for (int exoIndex = 0; exoIndex < allWeeksExercices[sessionIndex].length; exoIndex++) {
        int semaine = (sessionIndex ~/ 4) + 1;
        int seance = (sessionIndex % 4) + 1;
        if (_isSessionCompleted('semaine${semaine}_seance${seance}_exo$exoIndex')) {
          completedSessions.add(allWeeksExercices[sessionIndex][exoIndex].titre);
        }
      }
    }

    return completedSessions;
  }

  List<String> _getSessionsForMonth(DateTime date) {
    List<String> allSessions = [];
    DateTime firstDay = DateTime(date.year, date.month, 1);
    DateTime lastDay = DateTime(date.year, date.month + 1, 0);

    for (DateTime day = firstDay; day.isBefore(lastDay); day = day.add(Duration(days: 1))) {
      allSessions.addAll(_getSessionsForDay(day));
    }

    return allSessions;
  }

  List<String> _getCompletedSessionsForMonth(DateTime date) {
    List<String> completedSessions = [];
    DateTime firstDay = DateTime(date.year, date.month, 1);
    DateTime lastDay = DateTime(date.year, date.month + 1, 0);

    for (DateTime day = firstDay; day.isBefore(lastDay); day = day.add(Duration(days: 1))) {
      String dayName = DateFormat('EEEE').format(day);
      if (!widget.joursSemaine.contains(dayName)) continue;

      int dayIndex = widget.joursSemaine.indexOf(dayName);
      int weekNumber = _getWeekNumber(day);
      int sessionIndex = (weekNumber * widget.joursSemaine.length + dayIndex) % allWeeksExercices.length;

      for (int exoIndex = 0; exoIndex < allWeeksExercices[sessionIndex].length; exoIndex++) {
        int semaine = (sessionIndex ~/ 4) + 1;
        int seance = (sessionIndex % 4) + 1;
        if (_isSessionCompleted('semaine${semaine}_seance${seance}_exo$exoIndex')) {
          completedSessions.add(allWeeksExercices[sessionIndex][exoIndex].titre);
        }
      }
    }

    return completedSessions;
  }
  void _checkWeeklyBadge() async {
    if (_prefs == null) return;
    DateTime now = DateTime.now();
    int weekNumber = _getWeekNumber(now);
    String weekKey = '${now.year}-$weekNumber';

    if (_prefs!.getBool('weeklyBadge_$weekKey') ?? false) return;

    int completedCount = 0;
    int totalCount = 0;

    // Parcourir tous les jours de la semaine actuelle
    for (int dayIndex = 0; dayIndex < widget.joursSemaine.length; dayIndex++) {
      int sessionIndex = (weekNumber * widget.joursSemaine.length + dayIndex) % allWeeksExercices.length;
      totalCount += allWeeksExercices[sessionIndex].length;

      int semaine = (sessionIndex ~/ 4) + 1;
      int seance = (sessionIndex % 4) + 1;

      for (int exoIndex = 0; exoIndex < allWeeksExercices[sessionIndex].length; exoIndex++) {
        if (_isSessionCompleted('semaine${semaine}_seance${seance}_exo$exoIndex')) {
          completedCount++;
        }
      }
    }

    print('Weekly badge check: completedCount=$completedCount, totalCount=$totalCount'); // Ajoutez ce log

    if (completedCount >= totalCount && totalCount > 0) {
      setState(() {
        _weeklyBadgesCount++;
        _showWeeklyBadge = true;
      });
      await _prefs!.setInt(_weeklyBadgesKey, _weeklyBadgesCount);
      await _prefs!.setBool('weeklyBadge_$weekKey', true);

      print('Weekly badge awarded'); // Ajoutez ce log

      Future.delayed(Duration(seconds: 3), () {
        if (mounted) setState(() => _showWeeklyBadge = false);
      });
    } else {
      print('Weekly badge not awarded'); // Ajoutez ce log
    }
  }
  @override
  void dispose() {
    // Arrêter le timer quand le widget est supprimé
    _progressTimer?.cancel();
    super.dispose();
  }

  void _checkMonthlyBadge() async {
    DateTime now = DateTime.now();
    String monthKey = '${now.year}-${now.month}';

    bool alreadyAwarded = _prefs.getBool('monthlyBadge_$monthKey') ?? false;
    if (alreadyAwarded) return;

    int sessionsForMonth = _getSessionsForMonth(now).length;
    int completedForMonth = _getCompletedSessionsForMonth(now).length;

    if (completedForMonth >= sessionsForMonth && sessionsForMonth > 0) {
      setState(() {
        _monthlyBadgesCount++;
        _showMonthlyBadge = true;
      });
      await _prefs.setInt(_monthlyBadgesKey, _monthlyBadgesCount);
      await _prefs.setBool('monthlyBadge_$monthKey', true);

      Future.delayed(Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showMonthlyBadge = false;
          });
        }
      });
    }
  }
  late SharedPreferences _prefs;
  final Set<String> _completedSessions = {};
  void _loadCompletedSessions() {
    Set<String> completedSessions = _prefs.getStringList('completedSessions')?.toSet() ?? {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList('completedSessions', _completedSessions.toList());
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
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM -C-BICEPS CURLS UNILATERAL",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- TIRAGE NUQUE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- TIRAGE HORIZONTAL BICEPS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=A5rhhzRluhc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=2&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Developper Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM -C- Exercice Air Squat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C-CRUNCH ELEVATION GENIUX V2",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM -C-BICEPS CURLS UNILATERAL",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- TIRAGE NUQUE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- TIRAGE HORIZONTAL BICEPS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=A5rhhzRluhc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=2&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Developper Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C-CRUNCH ELEVATION GENIUX V2",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "FM -C- Exercice Air Squat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
        ),
      ],
      // Semaine 2
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Elevation Laterale",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=A203KccHReo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=11&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=tTLHrF1ZFPA&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=5&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM -C-TIRAGE COUDE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE NUQUE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM -L- TIRAGE VERTICAL POITRINE",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=-RXu8V-hYxw&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=4&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Tirage horizontal fessier",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Kikback",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=sJWG3P1JkHg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=16&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tTLHrF1ZFPA&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=5&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-L- Exercice Elevation Laterale",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=A203KccHReo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=11&pp=iAQB",
        ),
        Exercice(
          titre: "FM -C-TIRAGE COUDE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE NUQUE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM -L- TIRAGE VERTICAL POITRINE",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=-RXu8V-hYxw&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=4&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Tirage horizontal fessier",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Kikback",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=sJWG3P1JkHg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=16&pp=iAQB",
        ),
      ],
      // Semaine 3
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- TIRAGE HORIZONTAL TRICEPS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- BICEPS CURLS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- Exercice Mini SQuat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tTLHrF1ZFPA&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=5&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM -C- Exercice Air Squat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Squat a Genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- TIRAGE HORIZONTAL TRICEPS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- BICEPS CURLS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- Exercice Mini SQuat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tTLHrF1ZFPA&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=5&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Squat a Genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB",
        ),
        Exercice(
          titre: "FM -C- Exercice Air Squat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
        ),
      ],
      // Semaine 4
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- TIRAGE HORIZONTAL TRICEPS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- TIRAGE HORIZONTAL BICEPS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=A5rhhzRluhc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=2&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Rowing Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation Laterale Jambes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=VwW_Tt7NplY&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=17&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Elevation Laterale",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=A203KccHReo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=11&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice ROWING",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C-CRUNCH ELEVATION GENIUX V2",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "FM -C-TIRAGE COUDE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- TIRAGE HORIZONTAL TRICEPS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- TIRAGE HORIZONTAL BICEPS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=A5rhhzRluhc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=2&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Rowing Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation Laterale Jambes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=VwW_Tt7NplY&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=17&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice rowing Buste penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=mR1ghqgyqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM -C-BICEPS CURLS UNILATERAL",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation Laterale Jambes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=VwW_Tt7NplY&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=17&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- BICEPS CURLS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-L- Exercice rowing Buste Penché Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=poxJClRBqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=14&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Kikback",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=sJWG3P1JkHg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=16&pp=iAQB",
        ),
      ],
      // Semaine 5
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Elevation Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=kPNmz30EQYc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=12&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- Exercice Squat a Genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Tirage horizontal fessier",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- TIRAGE HORIZONTAL TRICEPS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM -C- Exercice Air Squat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C-CRUNCH ELEVATION GENIUX V2",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-L- Exercice Elevation Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=kPNmz30EQYc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=12&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Squat a Genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Tirage horizontal fessier",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Developper Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- Exercice Tirage horizontal fessier",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Rowing Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
        ),
      ],
      // Semaine 6
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Elevation Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=kPNmz30EQYc&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=12&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice ROWING",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE NUQUE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
        ),
        Exercice(
          titre: "FM -C- Exercice Air Squat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Developper Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- Exercice Tirage horizontal fessier",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Rowing Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice rowing Buste penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=mR1ghqgyqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM -C-BICEPS CURLS UNILATERAL",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation Laterale Jambes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=VwW_Tt7NplY&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=17&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- BICEPS CURLS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-L- Exercice rowing Buste Penché Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=poxJClRBqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=14&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Kikback",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=sJWG3P1JkHg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=16&pp=iAQB",
        ),
      ],
      // Semaine 7
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- BICEPS CURLS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM -L- TIRAGE VERTICAL POITRINE",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=-RXu8V-hYxw&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=4&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE COUDE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE NUQUE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-L- Exercice Developper Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=4bDbWp3Qy2o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- Exercice Rowing Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
        ),
        Exercice(
          titre: "FM -C- Exercice Air Squat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=N2ZdRwxWDec&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=19&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- BICEPS CURLS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM -L- TIRAGE VERTICAL POITRINE",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=-RXu8V-hYxw&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=4&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE COUDE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE NUQUE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=osJCK0qh_2w&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=3&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice rowing Buste penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=mR1ghqgyqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM -C-BICEPS CURLS UNILATERAL",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation Laterale Jambes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=VwW_Tt7NplY&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=17&pp=iAQB",
        ),
      ],
      // Semaine 8
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice rowing Buste penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=mR1ghqgyqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM -C-BICEPS CURLS UNILATERAL",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation Laterale Jambes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=VwW_Tt7NplY&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=17&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- BICEPS CURLS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=AOCc6mDrQqM&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=3&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-L- Exercice rowing Buste Penché Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=poxJClRBqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=14&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Kikback",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=sJWG3P1JkHg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=16&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice rowing Buste penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=mR1ghqgyqwU&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM -C-BICEPS CURLS UNILATERAL",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=BLaEk1XwkwE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation Laterale Jambes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=VwW_Tt7NplY&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=17&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice ROWING",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Tirage horizontal fessier",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
        ),
      ],
      // Semaine 9
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice ROWING",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Tirage horizontal fessier",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- TIRAGE HORIZONTAL TRICEPS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Mini SQuat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- CRUNCH ELEVATION GENIUX V2",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE COUDE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- CRUNCH ELEVATION GENIUX V2",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE COUDE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
        ),
      ],
      // Semaine 10
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice ROWING",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE HORIZONTAL TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Mini SQuat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- TIRAGE HORIZONTAL TRICEPS",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hJCzdmSZDmQ&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Mini SQuat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=goAvB7ZoEZo&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice ROWING",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=xqhkiknXhoE&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Tirage horizontal fessier",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ETLtpTLjB7c&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=12&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- CRUNCH ELEVATION GENIUX V2",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE COUDE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
        ),
      ],
      // Semaine 11
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM -C-TIRAGE COUDE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- CRUNCH ELEVATION GENIUX V2",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=10mzFwAp7ko&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=9&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- TIRAGE COUDE TRICEPS",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=NIZjLxfiPQQ&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=1&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Mini SQuat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Squat a Genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB",
        ),
      ],
      // Semaine 12
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Squat a Genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=hdIZ5htHj1Q&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=13&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Elevation genoux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Y3mGaF-8PFg&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=18&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "FM Echauffement",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=RiSbk_eQgSM&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=20&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oCaC-ckIZ-o&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-L- Exercice Tirage Horizontal Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=Zfr1vGd9JFI&list=PL27ZZQGb4Vdyzeiq8jT20XOgDXouxvZ2l&index=6&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "FM-C- CRUNCH CROISé",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=wzWJIySzYXc&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=10&pp=iAQB",
        ),
        Exercice(
          titre: "FM-C- Exercice Mini SQuat",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=6GdMnOGWsNE&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=15&pp=iAQB",
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
    String? programGenerationDate = prefs!.getString('programGenerationDate');
    if (programGenerationDate == null) return 1; // Valeur par défaut si la date n'est pas définie

    DateTime startDate = DateTime.parse(programGenerationDate);
    int daysSinceStart = now.difference(startDate).inDays;
    return (daysSinceStart ~/ 7) + 1;
  }

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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        centerTitle: true,
        title: const Text(
          "Femme Perte de Poids",
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
    await prefs.setDouble('progressionGlobale', completionPercentage);

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

