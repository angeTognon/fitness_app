import 'dart:async';
import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fitness_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitness_app/modules/after_splash/after_splash.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'modules/base/base2.dart';
import 'modules/splash/view/splash.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestExactAlarmPermission() async {
  if (await Permission.scheduleExactAlarm.isDenied) {
    await Permission.scheduleExactAlarm.request();
  }
}
bool isFirstRun = false;
bool isFirstCall = false;
bool isTrialActive = false;

String currentUserId = "";
bool eya = false;
bool clientC = false;
bool etatCompte = false;
String currentUserEmail = "";
String userName = "";
String imagPath = "";
String user_email = "";

String id = "";
String objectif = "";
String motivation = "";
String poidsActu = "0.0";
String poidsCible = "0.0";
String nbrSeance = "";
String dateCible = "";
String jourSeance = "";
String heure = "";

String powerbandProgram = "";
String powerbandFrequence = "";
String powerbanddays = "";
String stepperProgram = "";
String stepperFrequence = "";
String stepperdays = "";
String powerfitProgram = "";
String powerfitFrequence = "";
String powerfitdays = "";
String nomPrenom="";


/*class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("token: $fCMToken");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}*/


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> _initializeNotifications() async {
  // Initialisation des paramètres Android
  const AndroidInitializationSettings androidInitSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  // Paramètres d'initialisation globaux
  final InitializationSettings initSettings = InitializationSettings(
    android: androidInitSettings,
  );

  // Initialisation des notifications locales
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  // Initialisation des fuseaux horaires
  tz.initializeTimeZones();

  // Initialisation du fuseau horaire local pour Casablanca
  tz.setLocalLocation(tz.getLocation('Africa/Casablanca'));

  // L'initialisation est maintenant prête pour d'autres actions.
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isConnected = prefs.getBool('isConnected') ?? false;

  final userPref = await SharedPreferences.getInstance();
  user_email = userPref.getString('email') ?? "";

  eya = isConnected;
  print(user_email);
  // await Firebase.initializeApp();
  // await FirebaseApi().initNotification();
  runApp(Phoenix(child: MyApp(isConnected: isConnected)));

  /*_initializeNotifications().then((_) {
  });*/
}

final darkNotifier = ValueNotifier<bool>(false);
bool isDark = darkNotifier.value;

class MyApp extends StatefulWidget {
  final isConnected;
  MyApp({required this.isConnected});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _checkFirstRun() async {
    // verifier si l'utlisateur est connecté ou pas

    bool ifr = await IsFirstRun.isFirstRun();
    setState(() {
      isFirstRun = ifr;
    });
  }

  void _checkFirstCall() async {
    bool ifc = await IsFirstRun.isFirstCall();
    setState(() {
      isFirstCall = ifc;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print(heure);
    requestPermissions();
    _checkFirstRun();
    _checkFirstCall();
    getUserData();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted) {
        getUserData();
      } else {
        timer.cancel();
      }
    });
    super.initState();
  }
  Timer? timer;


  void requestPermissions() async {
    await Permission.notification.request();
  }
  
  // String nomPrenom = "";

  getUserData() async {
    var url =
        "https://zoutechhub.com/pharmaRh/gofitnext/getUserData.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body) as List;
      if (jsonResponse.isNotEmpty) {
        setState(() {
          userName = jsonResponse[0]['nomPrenom'] ?? 'vide';
          objectif = jsonResponse[0]['objectifPrincipal'] ?? 'vide';
          motivation = jsonResponse[0]['motivation'] ?? 'vide';
          poidsActu = jsonResponse[0]['poids'] ?? 'vide';
          poidsCible = jsonResponse[0]['poidsCible'] ?? 'vide';
          nbrSeance = jsonResponse[0]['nbrSeance'] ?? 'vide';
          jourSeance = jsonResponse[0]['jourSeance'] ?? 'vide';
          heure = jsonResponse[0]['heureEntrainemenent'] ?? 'vide';

          powerbandProgram = jsonResponse[0]['powerbandProgram'] ?? 'vide';
          powerbandFrequence = jsonResponse[0]['powerbandFrequence'] ?? 'vide';
          powerbanddays = jsonResponse[0]['powerbanddays'] ?? 'vide';

          stepperProgram = jsonResponse[0]['stepperProgram'] ?? 'vide';
          stepperFrequence = jsonResponse[0]['stepperFrequence'] ?? 'vide';
          stepperdays = jsonResponse[0]['stepperdays'] ?? 'vide';

          powerfitProgram = jsonResponse[0]['powerfitProgram'] ?? 'vide';
          powerfitFrequence = jsonResponse[0]['powerfitFrequence'] ?? 'vide';
          powerfitdays = jsonResponse[0]['powerfitdays'] ?? 'vide';

          id = jsonResponse[0]['id'] ?? '0';
          dateCible = jsonResponse[0]['dateCible'] ?? '0';
        });
      } else {
        print('La liste est vide.');
      }
      print(response.body);
      return pub;
    }
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ValueListenableBuilder<bool>(
        valueListenable: darkNotifier,
        builder: (BuildContext context, bool isDark, Widget? child) {
          return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              theme: ThemeData(primaryColor: mainColor),
              home: Splash());
        });
  }


  DateTime _nextInstanceOfDay(String day, TimeOfDay time) {
    final now = DateTime.now();
    int daysToAdd = 0;

    switch (day) {
      case 'Lundi':
        daysToAdd = DateTime.monday - now.weekday;
        break;
      case 'Mardi':
        daysToAdd = DateTime.tuesday - now.weekday;
        break;
      case 'Mercredi':
        daysToAdd = DateTime.wednesday - now.weekday;
        break;
      case 'Jeudi':
        daysToAdd = DateTime.thursday - now.weekday;
        break;
      case 'Vendredi':
        daysToAdd = DateTime.friday - now.weekday;
        break;
      case 'Samedi':
        daysToAdd = DateTime.saturday - now.weekday;
        break;
      case 'Dimanche':
        daysToAdd = DateTime.sunday - now.weekday;
        break;
    }

    if (daysToAdd <= 0) {
      daysToAdd += 7;
    }

    final nextDate = now.add(Duration(days: daysToAdd));
    return DateTime(nextDate.year, nextDate.month, nextDate.day, time.hour, time.minute);
  }
}

class Objectif {
  final String title;
  final String description;
  final IconData icon;

  Objectif({required this.title, required this.description, required this.icon});
}
