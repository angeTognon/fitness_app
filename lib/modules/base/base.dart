import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fitness_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../app/components/text_components.dart';
import '../../modules/boutique/boutique.dart';
import '../../modules/home/home.dart';
import '../../modules/settings/settings.dart';
import '../../new/home.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../new/dashboards/dashboard_cardio_quad.dart';
import '../home/test.dart';
import '../monCompte/connexion.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {

  int index = 0;
  Duration remainingTime = Duration.zero; // Durée restante de la période d'essai
  Timer? timer;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }


  tz.TZDateTime _nextInstanceOfTenAM(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
  @override
  void initState() {
    super.initState();
    print("**********************************objectif");
    print(objectif);
    _initializeNotifications();
    getUserData();
    _checkTrialPeriod();
  }

  Future<void> _checkTrialPeriod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime? installationDate = DateTime.tryParse(prefs.getString('installation_date') ?? '');

    if (installationDate == null) {
      installationDate = DateTime.now();
      await prefs.setString('installation_date', installationDate.toIso8601String());
    }

    final trialDuration = Duration(days: 5);
    if (DateTime.now().isBefore(installationDate.add(trialDuration))) {
      setState(() {
        isTrialActive = true;
        remainingTime = installationDate!.add(trialDuration).difference(DateTime.now());
      });
      _startTimer();
    }
  }

  getUserData() async {
    var url =
        "https://zoutechhub.com/pharmaRh/fitness_app/getUserData.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(
          response.body) as List; // Décodez en tant que liste
      if (jsonResponse.isNotEmpty) {
        // Vérifiez que la liste n'est pas vide
        setState(() {
          userName = jsonResponse[0]['nomPrenom'] ?? 'vide'; // Récupérez le nom
          objectif = jsonResponse[0]['objectifPrincipal'] ?? 'vide'; // Récupérez le nom
          motivation = jsonResponse[0]['motivation'] ?? 'vide'; // Récupérez le nom
          poidsActu = jsonResponse[0]['poids'] ?? 'vide'; // Récupérez le nom
          poidsCible = jsonResponse[0]['poidsCible'] ?? 'vide'; // Récupérez le nom
          nbrSeance = jsonResponse[0]['nbrSeance'] ?? 'vide'; // Récupérez le nom
          jourSeance = jsonResponse[0]['jourSeance'] ?? 'vide'; // Récupérez le nom
          heure = jsonResponse[0]['heureEntrainemenent'] ?? 'vide'; // Récupérez le nom
          id = jsonResponse[0]['id'] ?? '0'; // Récupérez le nom
        });
      } else {
        print('La liste est vide.');
      }
      print(response.body);
      return pub;
    }
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = remainingTime - Duration(seconds: 1);
        if (remainingTime.isNegative) {
          isTrialActive = false;
          remainingTime = Duration.zero; // Arrêtez le compte à rebours
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Assurez-vous d'annuler le timer lorsque le widget est détruit
    super.dispose();
  }

  String formatRemainingTime(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '$days jours $hours h $minutes min $seconds s';
  }

  final istrial= [
    HomeH(),
    // Test(),
    Boutique(),
    Connexion(),
    Settings()
  ];

   final eyaa= [
     HomeH(),
     // Dashboard(),
     // Home(),
     Home(),
     Boutique(),
     Settings()
   ];
   final eyaa2= [
     HomeH(),
     Home(),
     Boutique(),
     Settings()
   ];

   final pages= [
     HomeH(),
     Boutique(),
     Connexion(),
     Settings()
   ];

  @override
  Widget build(BuildContext context) {

    final pages = [
      // isTrialActive ? Test() : Home(),
      const Boutique(),
      const Connexion(),
      const Settings(),
    ];


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: index==0?2 :40,
        backgroundColor: mainColor,
        automaticallyImplyLeading: false,
        title:   TextComponent(text: index==0? "" : "fitness_app",color: Colors.white,size: 15,fontWeight: FontWeight.bold,),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(fontFamily: "PRegular",color:  (Theme.of(context).brightness == Brightness.dark)
              ? Colors.white
              : Colors.black,),
          selectedItemColor: mainColor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold,fontFamily: "PRegular",fontSize: 13),

          unselectedItemColor: (Theme.of(context).brightness == Brightness.dark)
              ? Colors.white
              : Colors.black,
          onTap: (i) => setState(() {
            index = i;
          }),
          currentIndex: index,
          items:
          isTrialActive && !eya? [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
            // BottomNavigationBarItem(icon: Icon(Icons.attractions), label: "Mode Test"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Boutique"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Connexion"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Paramètres"),
          ]:
          eya && objectif!="vide"?
         [
           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
             BottomNavigationBarItem(icon: Icon(Icons.dashboard), label : "DashBoard"),
            // BottomNavigationBarItem(icon: Icon(Icons.attractions), label : "Mes entraînements"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Boutique"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Paramètres"),
          ]:
          eya && objectif=="vide"?
          [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label : "DashBoard"),
            // BottomNavigationBarItem(icon: Icon(Icons.attractions), label : "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Boutique"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Paramètres"),
          ]:
          [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Boutique"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Connexion"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Paramètres"),
          ]

      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: isTrialActive && !eya?istrial[index] :
        eya && objectif!="vide"? eyaa[index] :
        eya && objectif=="vide"?  eyaa2[index] :
        pages[index],
      ),
    );
  }
}
