import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fitness_app/app/components/text_components.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExo.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../modules/monCompte/controller/controller.dart';
import '../../../utils/colors.dart';
import 'package:intl/date_symbol_data_local.dart';

const String _completedSessionsKey = 'completedSessions';
const String _dailyBadgesKey = 'dailyBadges';
const String _weeklyBadgesKey = 'weeklyBadges';
const String _monthlyBadgesKey = 'monthlyBadges';

class StepperSeancePersoProgrammePower extends StatefulWidget {
  final bool isReturningFromDetails;
  final List<String> joursSemaine;

  const StepperSeancePersoProgrammePower(
      {super.key,
      this.isReturningFromDetails = false,
      required this.joursSemaine});

  @override
  State<StepperSeancePersoProgrammePower> createState() =>
      _StepperSeancePersoProgrammePowerState();
}

class _StepperSeancePersoProgrammePowerState
    extends State<StepperSeancePersoProgrammePower> {
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

  Future<void> _loadAssignedDays() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDays = prefs.getStringList('assignedDays_pgpower_stepper');

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
      prefs.setStringList('assignedDays_pgpower_stepper', newAssignedDays);
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
        _prefs.getStringList('completedSessions_pgpower_stepper')?.toSet() ??
            {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList(
          'completedSessions_pgpower_stepper', _completedSessions.toList());
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
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Tirage Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Tirage Horizontal Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=eSHgAWBCCjI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=24&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Unilateral Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
        ),
        Exercice(
          titre: "Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 10),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
      ],
      // Séance 2
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 10),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "Triceps Tirage Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Unilateral Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
        ),
        Exercice(
          titre: "Biceps Tirage Horizontal Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=eSHgAWBCCjI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=24&pp=iAQB",
        ),
      ],
      // Séance 3
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Tirage Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Tirage Horizontal Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=eSHgAWBCCjI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=24&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Unilateral Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
        ),
        Exercice(
          titre: "Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
      ],
      // Séance 4
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 10),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "Triceps Tirage Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Unilateral Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
        ),
        Exercice(
          titre: "Biceps Tirage Horizontal Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=eSHgAWBCCjI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=24&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curls Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Rowing",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=vkQJadKk4VI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=29&pp=iAQB",
        ),
        Exercice(
          titre: "Renforcement des ischios",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
        Exercice(
          titre: "Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
      ],
      // Séance 2
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curls Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
        Exercice(
          titre: "Biceps Curls Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Renforcement des ischios",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
        Exercice(
          titre: "Rowing",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=vkQJadKk4VI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=29&pp=iAQB",
        ),
      ],
      // Séance 3
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curls Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Rowing",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=vkQJadKk4VI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=29&pp=iAQB",
        ),
        Exercice(
          titre: "Renforcement des ischios",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
        Exercice(
          titre: "Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
      ],
      // Séance 4
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curls Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
        Exercice(
          titre: "Biceps Curls Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "Renforcement des ischios",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
        Exercice(
          titre: "Rowing",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=vkQJadKk4VI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=29&pp=iAQB",
        ),
      ],

      [
        // Séance 1
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire Arrière",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM-L Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=j-iIsz5S8K4&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=2&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
        ),
      ],
      // Séance 2
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire Arrière",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
        Exercice(
          titre: "HM-L Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=j-iIsz5S8K4&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=2&pp=iAQB",
        ),
      ],
      // Séance 3
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire Arrière",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM-L Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=j-iIsz5S8K4&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=2&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
        ),
      ],
      // Séance 4
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire Arrière",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
        Exercice(
          titre: "HM-L Exercice Tirage Vertical Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=j-iIsz5S8K4&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=2&pp=iAQB",
        ),
      ],
      // Semaine 4
      [
        // Séance 1
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Fentes Arriere",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Tirage Unilateral Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=dQrV1R1N-cE&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM -C-Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/Gbjng5YUOAY",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
      ],
      // Séance 2
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-L- Exercice Fentes Arriere",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
        ),
        Exercice(
          titre: "HM -C-Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/Gbjng5YUOAY",
        ),
        Exercice(
          titre: "HM-L- Exercice Tirage Unilateral Poulie Basse",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=dQrV1R1N-cE&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      // Séance 3
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Fentes Arriere",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Tirage Unilateral Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=dQrV1R1N-cE&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM -C-Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/Gbjng5YUOAY",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
      ],
      // Séance 4
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-L- Exercice Fentes Arriere",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
        ),
        Exercice(
          titre: "HM -C-Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/Gbjng5YUOAY",
        ),
        Exercice(
          titre: "HM-L- Exercice Tirage Unilateral Poulie Basse",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=dQrV1R1N-cE&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=13&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],

// Semaine 5
      [
        // Séance 1
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Squat Sumo",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=WT76YmmXjvg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=18&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Triceps Tirage Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Tirage Unilatéral Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/X4d6ibnRgW0",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontal Unilateral Assis",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
        ),
      ],
      // Séance 2
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontal Unilateral Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
        ),
        Exercice(
          titre: "HM-L- Exercice Squat Sumo",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=WT76YmmXjvg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=18&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Tirage Unilatéral Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/X4d6ibnRgW0",
        ),
        Exercice(
          titre: "HM-L- Exercice Triceps Tirage Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
        ),
      ],
      // Séance 3
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Squat Sumo",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=WT76YmmXjvg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=18&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Triceps Tirage Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Tirage Unilatéral Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/X4d6ibnRgW0",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontal Unilateral Assis",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
        ),
      ],
      // Séance 4
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontal Unilateral Assis",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/HxuQGqInF0M",
        ),
        Exercice(
          titre: "HM-L- Exercice Squat Sumo",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=WT76YmmXjvg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=18&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Tirage Unilatéral Poulie Haute",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/X4d6ibnRgW0",
        ),
        Exercice(
          titre: "HM-L- Exercice Triceps Tirage Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=4XKUe5Q8ngg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=4&pp=iAQB",
        ),
      ],
      // Semaine 6
      [
        // Séance 1
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM -L- Exercice Biceps Curls Poulie Basse Tirage Vertical",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=feqR6E9eUfY&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=42&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Biceps Curls Pronation",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=C7J4RIXxR7o&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=26&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Vertical Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/T7Wd17_Sr_8",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage sur les adducteurs",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/V3KoSgDUYRM",
        ),
      ],
      // Séance 2
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage sur les adducteurs",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/V3KoSgDUYRM",
        ),
        Exercice(
          titre: "HM -L- Exercice Biceps Curls Poulie Basse Tirage Vertical",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=feqR6E9eUfY&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=42&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Vertical Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/T7Wd17_Sr_8",
        ),
        Exercice(
          titre: "HM-L- Exercice Biceps Curls Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=C7J4RIXxR7o&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=26&pp=iAQB",
        ),
      ],
      // Séance 3
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM -L- Exercice Biceps Curls Poulie Basse Tirage Vertical",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=feqR6E9eUfY&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=42&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Biceps Curls Pronation",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=C7J4RIXxR7o&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=26&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Vertical Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/T7Wd17_Sr_8",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage sur les adducteurs",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/V3KoSgDUYRM",
        ),
      ],
      // Séance 4
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage sur les adducteurs",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/V3KoSgDUYRM",
        ),
        Exercice(
          titre: "HM -L- Exercice Biceps Curls Poulie Basse Tirage Vertical",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=feqR6E9eUfY&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=42&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Vertical Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/T7Wd17_Sr_8",
        ),
        Exercice(
          titre: "HM-L- Exercice Biceps Curls Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=C7J4RIXxR7o&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=26&pp=iAQB",
        ),
      ],
      // Semaine 8
      [
        // Séance 1
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire Arrière",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM-L- Exercice Biceps Curls Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
        ),
        Exercice(
          titre: "HM-C- Exercice Dos Tirage Vertical Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/WOGlNg2Pyvs",
        ),
      ],
      [
        // Séance 2
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Dos Tirage Vertical Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/WOGlNg2Pyvs",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire Arrière",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
        ),
        Exercice(
          titre: "HM-L- Exercice Biceps Curls Prise Marteau",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        // Séance 3
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire Arrière",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM-L- Exercice Biceps Curls Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
        ),
        Exercice(
          titre: "HM-C- Exercice Dos Tirage Vertical Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/WOGlNg2Pyvs",
        ),
      ],
      [
        // Séance 4
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Dos Tirage Vertical Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/WOGlNg2Pyvs",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire Arrière",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Ewj0kpNSPbI&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=34&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
        Exercice(
          titre: "HM-C- Exercice Triceps Tirage Nuque Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/C1KoDbTe2s8",
        ),
        Exercice(
          titre: "HM-L- Exercice Biceps Curls Prise Marteau",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=j5KxgTeDDLg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=27&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],

      // Semaine 9
      [
        // Séance 1
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Tirage Vertical a la poulie",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=HMAG7U5fKLM&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=11&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=0dms4paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Oiseaux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/GI_U5Fu53dc",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontale Frontal",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
        ),
      ],
      [
        // Séance 2
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontale Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
        ),
        Exercice(
          titre: "HM-L- Exercice Tirage Vertical a la poulie",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=HMAG7U5fKLM&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=11&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Oiseaux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/GI_U5Fu53dc",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=0dms4paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
        ),
      ],
      [
        // Séance 3
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Tirage Vertical a la poulie",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=HMAG7U5fKLM&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=11&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=0dms4paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Oiseaux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/GI_U5Fu53dc",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontale Frontal",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
        ),
      ],
      [
        // Séance 4
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontale Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
        ),
        Exercice(
          titre: "HM-L- Exercice Tirage Vertical a la poulie",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=HMAG7U5fKLM&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=11&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Oiseaux",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/GI_U5Fu53dc",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=0dms4paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
        ),
      ],

      // Semaine 10
      [
        // Séance 1
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Trapeze Tirage Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Elévation Latérale",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-C- Exercice Renforcement des ischios",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
      ],
      [
        // Séance 2
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Renforcement des ischios",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
        Exercice(
          titre: "HM-L- Exercice Trapeze Tirage Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-L- Exercice Elévation Latérale",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
        ),
      ],
      [
        // Séance 3
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Trapeze Tirage Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Elévation Latérale",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-C- Exercice Renforcement des ischios",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
      ],
      [
        // Séance 4
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Renforcement des ischios",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
        Exercice(
          titre: "HM-L- Exercice Trapeze Tirage Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-L- Exercice Elévation Latérale",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
        ),
      ],
      // Semaine 10
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Trapeze Tirage Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Elévation Latérale",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-C- Exercice Renforcement des ischios",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
      ],
      // Séance 2 de la semaine 10
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Renforcement des ischios",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
        Exercice(
          titre: "HM-L- Exercice Trapeze Tirage Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-L- Exercice Elévation Latérale",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
        ),
      ],
      // Séance 3 de la semaine 10
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Trapeze Tirage Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Elévation Latérale",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-C- Exercice Renforcement des ischios",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
      ],
      // Séance 4 de la semaine 10
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Renforcement des ischios",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/4zZN3DTqNL4",
        ),
        Exercice(
          titre: "HM-L- Exercice Trapeze Tirage Frontal",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=ow_CgIczhwA&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-L- Exercice Elévation Latérale",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=lWXu8dKjIGk&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=16&pp=iAQB",
        ),
      ],

      // Semaine 11
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Fentes Arriere",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontale Frontal",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
      ],
      // Séance 2 de la semaine 11
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
        Exercice(
          titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontale Frontal",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
        ),
        Exercice(
          titre: "HM-L- Exercice Fentes Arriere",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
        ),
      ],
      // Séance 3 de la semaine 11
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Fentes Arriere",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontale Frontal",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
      ],
      // Séance 4 de la semaine 11
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps Curls Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/pBr3yREZXT4",
        ),
        Exercice(
          titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Horizontale Frontal",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/ZPeRD-KGzNM",
        ),
        Exercice(
          titre: "HM-L- Exercice Fentes Arriere",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=Rh1HTFK5Qy0&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=22&pp=iAQB",
        ),
      ],

      // Semaine 12
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=0dms4paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Vertical Deltoides Posterieur",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/HlH9r3INnGE",
        ),
      ],
      // Séance 2 de la semaine 12
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Vertical Deltoides Posterieur",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/HlH9r3INnGE",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=0dms4paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
        ),
      ],
      // Séance 3 de la semaine 12
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=0dms4paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
        ),
        Exercice(
          titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 75,
          linkVideo:
              "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Vertical Deltoides Posterieur",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/HlH9r3INnGE",
        ),
      ],
      // Séance 4 de la semaine 12
      [
        Exercice(
          titre: "HM Exercice Cardio",
          nombreTotalSerie: 1,
          seriesConfigs: [SerieConfig(repetitions: 1)],
          repos: 0,
          linkVideo:
              "https://www.youtube.com/watch?v=daV_AThidyg&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Tirage Vertical Deltoides Posterieur",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/HlH9r3INnGE",
        ),
        Exercice(
          titre: "HM-L- Exercice Développer Militaire",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 10),
            SerieConfig(repetitions: 8),
            SerieConfig(repetitions: 8),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=0dms4paNPww&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=33&pp=iAQB",
        ),
        Exercice(
          titre: "HM-C- Exercice Biceps tirage vertical Prise Pronation",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/shorts/-sBqiEni1c0",
        ),
        Exercice(
          titre: "HM-L- Biceps Tirage Vertical Poulie Basse",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15),
            SerieConfig(repetitions: 12),
            SerieConfig(repetitions: 12),
          ],
          repos: 60,
          linkVideo:
              "https://www.youtube.com/watch?v=JtGxOxTofCs&list=PL27ZZQGb4VdxSzlSFfgHSjFw-EIFmbomj&index=30&pp=iAQB",
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

// Modifiez _buildExerciseBox comme ceci :
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
          "Programme Power - Stepper",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _buildBadgeAlert(
      String title, String message, IconData icon, Color color) {
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
              Text(title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(height: 5),
              Text(message,
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
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
        'progressionGlobale_pgpower_stepper', completionPercentage);

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
