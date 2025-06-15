import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fitness_app/app/components/text_components.dart';
import 'package:fitness_app/new/LectureVideoExo/lectureVideosExo.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../modules/monCompte/controller/controller.dart';
import '../../../utils/colors.dart';
import 'package:intl/date_symbol_data_local.dart';

class PowerbandSeancePersonnaliseProgrammePower extends StatefulWidget {
  final bool isReturningFromDetails;
  final List<String> joursSemaine;

  const PowerbandSeancePersonnaliseProgrammePower({
    super.key,
    this.isReturningFromDetails = false,
    required this.joursSemaine
  });

  @override
  State<PowerbandSeancePersonnaliseProgrammePower> createState() => _PowerbandSeancePersonnaliseProgrammePowerState();
}

class _PowerbandSeancePersonnaliseProgrammePowerState extends State<PowerbandSeancePersonnaliseProgrammePower> {
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
    final savedDays = prefs.getStringList('assignedDays_pgpower_powerband');

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
      prefs.setStringList('assignedDays_pgpower_powerband', newAssignedDays);
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
    Set<String> completedSessions = _prefs.getStringList('completedSessions_pgpower_powerband')?.toSet() ?? {};
    setState(() {
      _completedSessions.addAll(completedSessions);
    });
  }

  void _markSessionAsCompleted(String sessionName) {
    setState(() {
      _completedSessions.add(sessionName);
      _prefs.setStringList('completedSessions_pgpower_powerband', _completedSessions.toList());
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
          titre: "Developpé Debout à la Poulie",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 140),
            SerieConfig(repetitions: 8, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=31&pp=iAQB",
        ),
        Exercice(
          titre: "OVERHEAD PRESS",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 60),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
        ),
        Exercice(
          titre: "Elevations Laterales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=28&pp=iAQB",
        ),
        Exercice(
          titre: "Ecarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Soulevé de Terre",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 6, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 70),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Oiseau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Front Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 8, charge: 120),
            SerieConfig(repetitions: 6, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
        ),
        Exercice(
          titre: "Leg Extension Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kicks",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 8, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Développé Incliné",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 120),
            SerieConfig(repetitions: 8, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Développé Militaire Assis",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Elevations Laterales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 20, charge: 30),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Pull Over",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Prise Large",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 12, charge: 100),
            SerieConfig(repetitions: 10, charge: 110),
            SerieConfig(repetitions: 8, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
        ),
        Exercice(
          titre: "Face Pull au sol",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
      ],

      //semaine 2

      [
        Exercice(
          titre: "Développé Debout à la Poulie",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 140),
            SerieConfig(repetitions: 8, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
        ),
        Exercice(
          titre: "OVERHEAD PRESS",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 60),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
        ),
        Exercice(
          titre: "Elevations Laterales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Soulevé de Terre",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 6, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 70),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Oiseau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Front Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 8, charge: 120),
            SerieConfig(repetitions: 6, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
        ),
        Exercice(
          titre: "Leg Extension Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kicks",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 8, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Pull Over",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Prise Large",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 12, charge: 100),
            SerieConfig(repetitions: 10, charge: 110),
            SerieConfig(repetitions: 8, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
        ),
        Exercice(
          titre: "Face Pull au sol",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes Rebonds",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 6, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Soulevé de terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 6, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Hip Thrust",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 12, charge: 240),
            SerieConfig(repetitions: 12, charge: 240),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 1,
          seriesConfigs: [
            SerieConfig(repetitions: 100, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],

      [
        Exercice(
          titre: "Développé Debout à la Poulie",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 140),
            SerieConfig(repetitions: 8, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
        ),
        Exercice(
          titre: "OVERHEAD PRESS",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 60),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
        ),
        Exercice(
          titre: "Elevations Laterales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Soulevé de Terre",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 6, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 70),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Oiseau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Front Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 8, charge: 120),
            SerieConfig(repetitions: 6, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
        ),
        Exercice(
          titre: "Leg Extension Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kicks",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 8, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Développé Incliné",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 120),
            SerieConfig(repetitions: 8, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Développé Militaire Assis",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Elevations Laterales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 20, charge: 30),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      // Semaine 4
      [
        Exercice(
          titre: "Développé Incliné",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 120),
            SerieConfig(repetitions: 8, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Développé Militaire Assis",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Elevations Laterales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 20, charge: 30),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Pull Over",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Prise Large",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 12, charge: 100),
            SerieConfig(repetitions: 10, charge: 110),
            SerieConfig(repetitions: 8, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
        ),
        Exercice(
          titre: "Face Pull au sol",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes Rebonds",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 6, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Soulevé de terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 6, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Hip Thrust",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 12, charge: 240),
            SerieConfig(repetitions: 12, charge: 240),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 1,
          seriesConfigs: [
            SerieConfig(repetitions: 100, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],
      // Semaine 5
      [
        Exercice(
          titre: "Développé Incliné",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 120),
            SerieConfig(repetitions: 8, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Développé Militaire Assis",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Elevations Laterales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 20, charge: 30),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Pull Over",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Prise Large",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 12, charge: 100),
            SerieConfig(repetitions: 10, charge: 110),
            SerieConfig(repetitions: 8, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
        ),
        Exercice(
          titre: "Face Pull au sol",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes Rebonds",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 6, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Soulevé de terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 6, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Hip Thrust",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 12, charge: 240),
            SerieConfig(repetitions: 12, charge: 240),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 1,
          seriesConfigs: [
            SerieConfig(repetitions: 100, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Soulevé de Terre",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 6, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 70),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Oiseau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
        ),
      ],
      // Semaine 6

      [
        Exercice(
          titre: "Développé Incliné",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 120),
            SerieConfig(repetitions: 8, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Développé Militaire Assis",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Elevations Laterales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 20, charge: 30),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Pull Over",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Prise Large",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 12, charge: 100),
            SerieConfig(repetitions: 10, charge: 110),
            SerieConfig(repetitions: 8, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
        ),
        Exercice(
          titre: "Face Pull au sol",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes Rebonds",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 6, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Soulevé de terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 6, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Hip Thrust",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 12, charge: 240),
            SerieConfig(repetitions: 12, charge: 240),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 1,
          seriesConfigs: [
            SerieConfig(repetitions: 100, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Développé Debout à la Poulie",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 140),
            SerieConfig(repetitions: 8, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
        ),
        Exercice(
          titre: "OVERHEAD PRESS",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 60),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
        ),
        Exercice(
          titre: "Elevations Laterales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Front Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 8, charge: 120),
            SerieConfig(repetitions: 6, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
        ),
        Exercice(
          titre: "Leg Extension Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kicks",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 8, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],

      //semaine 7
      [
        Exercice(
          titre: "Développé Debout à la Poulie",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 140),
            SerieConfig(repetitions: 8, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
        ),
        Exercice(
          titre: "OVERHEAD PRESS",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 60),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
        ),
        Exercice(
          titre: "Elevations Laterales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Soulevé de Terre",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 6, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Unilateral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 70),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Oiseau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Front Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 8, charge: 120),
            SerieConfig(repetitions: 6, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
        ),
        Exercice(
          titre: "Leg Extension Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kicks",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 8, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Développé Incliné",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 120),
            SerieConfig(repetitions: 8, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Développé Militaire Assis",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Elevations Laterales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Ecarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 20, charge: 30),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Pull Over",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
            SerieConfig(repetitions: 20, charge: 40),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=m_qWQjduveo&list=PL27ZZQGb4VdwLx8Co-YZKW-Z2pk1X15xA&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Prise Large",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 12, charge: 100),
            SerieConfig(repetitions: 10, charge: 110),
            SerieConfig(repetitions: 8, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=a-CZ_XVV8yg&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=40&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl Prise Marteau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=ssobgaOeNmA&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=29&pp=iAQB",
        ),
        Exercice(
          titre: "Face Pull au sol",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=g7_9dPjXbI4&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=36&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
      ],

      //semaine 8

      [
        Exercice(
          titre: "Développé Debout à la Poulie",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 140),
            SerieConfig(repetitions: 8, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
        ),
        Exercice(
          titre: "Overhead Press",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 60),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
        ),
        Exercice(
          titre: "Élévations Latérales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=28&pp=iAQB",
        ),
        Exercice(
          titre: "Écarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Soulevé de Terre",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 6, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Unilatéral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 70),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Oiseau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Front Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 8, charge: 120),
            SerieConfig(repetitions: 6, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
        ),
        Exercice(
          titre: "Leg Extension Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kicks",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 8, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes Rebonds",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 6, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Soulevé de terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 6, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Hip Thrust",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 12, charge: 240),
            SerieConfig(repetitions: 12, charge: 240),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 1,
          seriesConfigs: [
            SerieConfig(repetitions: 100, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],

      // semaine 9

      [
        Exercice(
          titre: "Développé Debout à la Poulie",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 140),
            SerieConfig(repetitions: 8, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=4uo_CMqRwa0&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=46&pp=iAQB",
        ),
        Exercice(
          titre: "Overhead Press",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 8, charge: 50),
            SerieConfig(repetitions: 8, charge: 60),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=Wr82oq7BDiw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=20&t=7s&pp=iAQB",
        ),
        Exercice(
          titre: "Élévations Latérales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=28&pp=iAQB",
        ),
        Exercice(
          titre: "Écarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
            SerieConfig(repetitions: 15, charge: 50),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Soulevé de Terre",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 6, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Rowing Buste Penché",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 8, charge: 70),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=QbHiDT2n9ak&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=1&pp=iAQB",
        ),
        Exercice(
          titre: "Tirage Horizontal Unilatéral",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 70),
            SerieConfig(repetitions: 8, charge: 80),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=6KVKMIbUH-Y&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=15&pp=iAQB",
        ),
        Exercice(
          titre: "Biceps Curl",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 15, charge: 60),
            SerieConfig(repetitions: 12, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=oVGTI_Iy9-g&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=47&pp=iAQB",
        ),
        Exercice(
          titre: "Oiseau",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=tXwuVFuukkU&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=12&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Front Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=SfaDn_UBXUw&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=35&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 80),
            SerieConfig(repetitions: 8, charge: 120),
            SerieConfig(repetitions: 6, charge: 160),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=bMghA7DYexI&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=25&pp=iAQB",
        ),
        Exercice(
          titre: "Leg Extension Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 12, charge: 50),
            SerieConfig(repetitions: 10, charge: 60),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=IZ76TKTlZMo&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Donkey Kicks",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 20),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 8, charge: 40),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tKYN8Z7ecxw&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=8&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
            SerieConfig(repetitions: 15, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
        ),
      ],
      [
        Exercice(
          titre: "Développé Incliné",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 12, charge: 120),
            SerieConfig(repetitions: 10, charge: 120),
            SerieConfig(repetitions: 8, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=A5ihvpIpM7w&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=26&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Développé Militaire Assis",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 12, charge: 60),
            SerieConfig(repetitions: 10, charge: 80),
            SerieConfig(repetitions: 8, charge: 100),
            SerieConfig(repetitions: 8, charge: 100),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=f2-zHyZBFH8&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=24&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Élévations Latérales",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
            SerieConfig(repetitions: 20, charge: 20),
          ],
          repos: 45,
          linkVideo: "https://www.youtube.com/watch?v=9xgOBbFmSYE&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=45&pp=iAQB0gcJCYUJAYcqIYzv",
        ),
        Exercice(
          titre: "Écarté Poulie Haute",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 15, charge: 30),
            SerieConfig(repetitions: 20, charge: 30),
          ],
          repos: 30,
          linkVideo: "https://www.youtube.com/watch?v=uBAb_bZ2Yt8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=38&pp=iAQB",
        ),
        Exercice(
          titre: "Triceps Extension Poulie Haute",
          nombreTotalSerie: 5,
          seriesConfigs: [
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 12, charge: 30),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 10, charge: 40),
            SerieConfig(repetitions: 8, charge: 50),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=OKr0saA8AXs&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=43&pp=iAQB0gcJCYQJAYcqIYzv",
        ),
      ],
      [
        Exercice(
          titre: "Squat",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 20, charge: 80),
            SerieConfig(repetitions: 15, charge: 100),
            SerieConfig(repetitions: 10, charge: 140),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=3TnTyNycFiU&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=7&pp=iAQB",
        ),
        Exercice(
          titre: "Fentes Rebonds",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 8, charge: 80),
            SerieConfig(repetitions: 6, charge: 120),
          ],
          repos: 90,
          linkVideo: "https://www.youtube.com/watch?v=7mT3UyhXfHk&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=37&pp=iAQB",
        ),
        Exercice(
          titre: "Soulevé de terre",
          nombreTotalSerie: 3,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 40),
            SerieConfig(repetitions: 10, charge: 60),
            SerieConfig(repetitions: 6, charge: 100),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=h8wZ-17TY3I&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=6&pp=iAQB",
        ),
        Exercice(
          titre: "Hip Thrust",
          nombreTotalSerie: 4,
          seriesConfigs: [
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 15, charge: 200),
            SerieConfig(repetitions: 12, charge: 240),
            SerieConfig(repetitions: 12, charge: 240),
          ],
          repos: 60,
          linkVideo: "https://www.youtube.com/watch?v=tNdf22BExfY&list=PL27ZZQGb4Vdx5_B92jJXP0oarRXPp5J_1&index=34&pp=iAQB",
        ),
        Exercice(
          titre: "Extension Mollet Unilatéral",
          nombreTotalSerie: 1,
          seriesConfigs: [
            SerieConfig(repetitions: 100, charge: 0),
          ],
          repos: 0,
          linkVideo: "https://www.youtube.com/watch?v=uMMv5GdkLV8&list=PL27ZZQGb4VdxOai2h3x24ZeM3Xy5Aovym&index=4&pp=iAQB",
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
    String? programGenerationDate = prefs!.getString('programGenerationDate_pgpower_powerband');
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
    await prefs.setDouble('progressionGlobale_pgpower_powerband', completionPercentage);

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

