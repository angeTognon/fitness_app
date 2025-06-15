import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fitness_app/main.dart';
import 'package:fitness_app/new/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/components/text_components.dart';
import '../../modules/boutique/boutique.dart';
import '../../modules/home/home.dart';
import '../../modules/settings/settings.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../new/dashboards/dashboard_cardio_quad.dart';
import '../home/test.dart';
import '../monCompte/connexion.dart';

class Base2 extends StatefulWidget {
  const Base2({super.key});

  @override
  State<Base2> createState() => _Base2State();
}

class _Base2State extends State<Base2> {

  int index = 0;
  bool isTrialActive = false;
  Duration remainingTime = Duration.zero; // Durée restante de la période d'essai
  Timer? timer;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidInitSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  // Afficher une notification
  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'training_channel', // ID du canal
      'Entraînement', // Nom du canal
      channelDescription: 'Notification pour rappeler l\'heure d\'entraînement',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // ID unique de la notification
      'Rappel d\'entraînement',
      'C\'est l\'heure de s\'entraîner !',
      notificationDetails,
    );
  }

  @override
  void initState() {
    super.initState();
    print("**********************************objectif");
    print(objectif);
    _initializeNotifications();
    _showNotification();
   /* if(objectif.isEmpty){
      setState(() {
        vide=true;
      });
    }else{
      print("non vide");
      setState(() {
        vide=true;
      });
    }*/
    _checkTrialPeriod();
  }

  late bool vide;
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
      appBar: index==0?null: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          color: mainColor,
          height: 80,
          child: Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const TextComponent(text: "fitness_app",color: Colors.white,size: 16,fontWeight: FontWeight.bold,),
              isTrialActive && eya? h(0)/*InkWell(
                  onTap: () {
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 30,
                    decoration: BoxDecoration(
                        color: main2,
                        borderRadius: BorderRadius.circular(5)),
                    child:  Center(
                        child: TextComponent(text:  "La Période test expire dans ${formatRemainingTime(remainingTime)}",color: Colors.white,
                        )),)
              )*/:
              !isTrialActive && !eya?
              InkWell(
                  onTap: () {
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child:  Center(
                        child: TextComponent(text:  "La Période test a expiré ",color: Colors.white,
                        )),)
              ) : isTrialActive && !eya?
              InkWell(
                  onTap: () {
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child:  Center(
                      child: TextComponent(text:  "La Période test expire dans ${formatRemainingTime(remainingTime)}",color: Colors.white,
                        // child: TextComponent(text:  "La Période test a expiré ",color: Colors.white,
                        )),)
              )
                  : h(0),
              h(2)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,fontFamily: "PRegular",color:  (Theme.of(context).brightness == Brightness.dark)
              ? Colors.white
              : Colors.black,),
          selectedItemColor: mainColor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold,fontFamily: "PRegular",),

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
            // BottomNavigationBarItem(icon: Icon(Icons.attractions), label : "Mes entraînements"),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label : "DashBoard"),
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
