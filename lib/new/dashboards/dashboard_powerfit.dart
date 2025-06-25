import 'dart:async';
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fitness_app/SeancePerso/Douleur%20Lombaire/seance_personnalise.dart';
import 'package:fitness_app/SeancePerso/Femme%20Cuisse%20Jambe%20Fessier/seance_personnalise.dart';
import 'package:fitness_app/SeancePerso/Femme%20Ventre%20Plat%20et%20Abdos/seance_personnalise.dart';
import 'package:fitness_app/SeancePerso/Homme%20D%C3%A9veloppement%20Poitrine/seance_personnalise.dart';
import 'package:fitness_app/SeancePerso/Homme%20Perte%20de%20Poids/seance_personnalise.dart';
import 'package:fitness_app/SeancePerso/Homme%20Ventre%20Plat%20&%20Abdos/seance_personnalise.dart';
import 'package:fitness_app/SeancePerso/Perte%20de%20Graisse%20Bras%20Femme/seance_personnalise.dart';
import 'package:fitness_app/SeancePerso/Renforcement/seance_personnalise.dart';
import 'package:fitness_app/SeancePerso/Routine%20Corps%20complet/seance_personnalise.dart';
import 'package:fitness_app/main.dart';
import 'package:fitness_app/modules/monCompte/controller/controller.dart';
import 'package:fitness_app/modules/seance_personnalise.dart';
import 'package:fitness_app/new/quizSeancePerso/powerfit.dart';
import 'package:fitness_app/new/seancePerso/powerfit/seance_personnalise_programme_perte_de_poids.dart';
import 'package:fitness_app/new/seancePerso/powerfit/seance_personnalise_programme_power.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../SeancePerso/Femme Perte De Poids/seance_personnalise.dart';
import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../app/components/text_form_component.dart';
import '../../modules/details/details.dart';
import '../BibliothequeDexercice/bibliothequeCardioQuad.dart';
import '../BibliothequeDexercice/bibliothequePowerFit.dart';
import '../BibliothequeDexercice/bibliothequeStepper.dart';
import '../presentation/presentationStepper.dart';
import '../programmeCardio/programme.dart';
import '../programmePowerFit/programme.dart';
import '../programmeStepper/programme.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:http/http.dart' as http;

import '../../modules/accueil/accueil.dart';
import '../../modules/seance_libre.dart';
import '../../modules/stockageSeancePersoList/stockage.dart';


class DashboardPowerfit extends StatefulWidget {
  const DashboardPowerfit({super.key});

  @override
  State<DashboardPowerfit> createState() => _DashboardPowerfitState();
}

class _DashboardPowerfitState extends State<DashboardPowerfit> {

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // List<bool> _daysCompleted = List.filled(10, false); // Liste pour les jours terminés
  int _currentDay = 0; // Index du jour actuel
  int _remainingTime = 0; // Temps restant avant l'exercice suivant

  late List<String> joursSemaine;
  List<bool> _daysCompleted = List.filled(10, false);

  Future<void> _loadDaysStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _daysCompleted = List.generate(10, (index) => prefs.getBool('day_$index') ?? false);
      _currentDay = prefs.getInt('current_day') ?? 0; // Récupérer le jour actuel
      _remainingTime = prefs.getInt('remaining_time') ?? 0; // Récupérer le temps restant
    });
  }
  double nbrManque =0;
  Future<void> _getNbrManque() async {
    nbrManque = await getNbrManqueFromSharedPreferences();
    setState(() {}); // Met à jour l'interface utilisateur après la récupération
  }
  Future<double> getNbrManqueFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('nbrManque') ?? 0.0; // Retourne 0.0 si la valeur n'existe pas
  }

  TextEditingController codEquipement = TextEditingController();
  getUserData() async {
    var url =
        "https://zoutechhub.com/pharmaRh/gofitnext/getUserData.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    print(response.body);
    return pub;
  }

  bool show = false;

  update(String id,idApp) async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/gofitnext/updateCode.php?id=$id&idApp=$idApp";
    var response = await http.post(Uri.parse(url));

    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      show = false;
      showToast(context, "Ajout Réussie.", Colors.green);

    } else {
      setState(() {
        show = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur : Il semble que cette adresse mail a déjà été utilisée ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }
  Future<void> _getProgressionGlobale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? progression = powerfitProgram=="Programme Perte de Poids"? prefs.getDouble('progressionGlobale') :  prefs.getDouble('progressionGlobale_pgpower_powerfit');

    if (progression != null) {
      progress=progression;
      print('Progression récupérée: $progression%');
      // Utilise-la selon ton besoin, par ex. dans un setState()
    }
  }

  Timer? _progressTimer;

  double progress=0;
  @override
  void initState() {
    // TODO: implement initState
    // Parsing la chaîne jourSeance
    _startProgressTimer();
    // poidActu_=double.parse(poidsActu);
    // poidCible_=double.parse(poidsCible);
    _loadDaysStatus();
    jourSeance = '{${powerfitdays.split(',').map((j) => j.trim()).join(', ')}}';

    joursSemaine = jourSeance
        .replaceAll(RegExp(r'[{}]'), '') // Enlever les accolades
        .split(', ')
        .map((jour) => jour.trim())
        .toList();
    _getNbrManque(); // Met à jour l'interface utilisateur après la récupération
    super.initState();
  }

  @override
  void dispose() {
    // Arrêter le timer quand le widget est supprimé
    _progressTimer?.cancel();
    super.dispose();
  }

  void _startProgressTimer() {
    // Exécuter immédiatement une première fois
    _getProgressionGlobale();

    // Puis toutes les 2 secondes
    _progressTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted) {
        _getProgressionGlobale();
      } else {
        timer.cancel();
      }
    });
  }

  void trierJours() {
    // Dictionnaire de traduction des jours
    Map<String, String> joursFr = {
      'Monday': 'Lundi',
      'Tuesday': 'Mardi',
      'Wednesday': 'Mercredi',
      'Thursday': 'Jeudi',
      'Friday': 'Vendredi',
      'Saturday': 'Samedi',
      'Sunday': 'Dimanche',
    };

    // Obtenir le jour actuel en anglais
    String jourAujourdHui = DateFormat('EEEE').format(DateTime.now());

    // Convertir le jour actuel en français
    String jourActuelFr = joursFr[jourAujourdHui] ?? jourAujourdHui;

    // Liste des jours de la semaine en français dans l'ordre
    List<String> joursOrdre = [
      'Lundi',
      'Mardi',
      'Mercredi',
      'Jeudi',
      'Vendredi',
      'Samedi',
      'Dimanche'
    ];

    if (!joursSemaine.contains(jourActuelFr)) {
      print("Erreur : Le jour actuel n'est pas dans la liste joursSemaine.");
      return;
    }

    // Créer une nouvelle liste avec le jour actuel en premier
    List<String> joursFinal = [jourActuelFr];

    // Trouver l'index du jour actuel dans l'ordre de la semaine
    int indexJourActuel = joursOrdre.indexOf(jourActuelFr);

    // Créer une liste des jours restants dans l'ordre de la semaine, en commençant après le jour actuel
    List<String> joursRestants = [];
    for (int i = indexJourActuel + 1; i < joursOrdre.length; i++) {
      if (joursSemaine.contains(joursOrdre[i])) {
        joursRestants.add(joursOrdre[i]);
      }
    }
    for (int i = 0; i < indexJourActuel; i++) {
      if (joursSemaine.contains(joursOrdre[i])) {
        joursRestants.add(joursOrdre[i]);
      }
    }

    // Ajouter les jours restants triés à la liste finale
    joursFinal.addAll(joursRestants);

    // Mettre à jour la liste originale
    setState(() {
      joursSemaine = joursFinal;
      print(joursSemaine); // Afficher la liste triée
      print(jourActuelFr); // Afficher le jour actuel en français
    });
  }

  // Récupérer les dates de la semaine actuelle
  List<DateTime> _getCurrentWeekDays() {
    DateTime now = DateTime.now();
    int startOfWeek = now.weekday - 1; // Lundi comme premier jour
    return List.generate(7, (index) {
      return now.subtract(Duration(days: startOfWeek - index));
    });
  }

  Color? _getDayColor(DateTime day) {
    List<DateTime> currentWeekDays = _getCurrentWeekDays();
    String jourSemaine = _formatDay(day);

    // Colorer les jours spécifiés dans jourSeance et qui sont dans la semaine actuelle
    if (currentWeekDays.contains(day) && joursSemaine.contains(jourSemaine)) {
      return Colors.green; // Couleur pour les jours de séance
    }
    return null; // Couleur par défaut
  }
  double poidActu_=0;
  double poidCible_=0;


  String _formatDay(DateTime day) {
    switch (day.weekday) {
      case 1:
        return 'Lundi';
      case 2:
        return 'Mardi';
      case 3:
        return 'Mercredi';
      case 4:
        return 'Jeudi';
      case 5:
        return 'Vendredi';
      case 6:
        return 'Samedi';
      case 7:
        return 'Dimanche';
      default:
        return '';
    }
  }


  // Liste des exercices pour chaque jour
  final List<String> _exercises = [
    "Squat Sumo",
    "Kick Squat",
    "Gainage",
    "Etirements",
    "Etirement v2",
    "Elevation Bassin",
    "CJF Echauffement",
    "Crunch Latéral",
    "Crunch Abdominal",
    "Crunch Abdominal V2",
    // Ajout d'un 11ème exercice pour le jour 11
    "Crunch Abdominal Suspendu",
  ];

  Widget BoxProduitG(String path, titre, txt){
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/$path"),fit: BoxFit.cover,alignment: Alignment.bottomLeft),
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.7), Colors.black.withOpacity(0.3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            width: 140,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20),topRight: Radius.circular(91), bottomRight: Radius.circular(91)),
            ),
          ),
          Container(
            width: 125,
            height: 180,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.black.withOpacity(0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20),topRight: Radius.circular(91), bottomRight: Radius.circular(91)),
            ),
            child: Center(
              child: TextComponent(text: titre,color: Colors.white,textAlign: TextAlign.start,fontWeight: FontWeight.bold,),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              ],
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: CircleAvatar(
              backgroundColor: Colors.white,

              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget OwnDivider(){
    return Container(
      height: 4,
      width: 50,
      color: Color(0xFF0186A4),
    );
  }
  Widget BoxProduitD(String path, titre,txt){
    return Container(
      width: 150,
      // width: 180,
      height: 150,

      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/$path"),fit: BoxFit.cover,alignment: Alignment.bottomRight),
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.7), Colors.black.withOpacity(0.3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 140,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(91), topLeft: Radius.circular(91),topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 125,
              height: 150,
              padding: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black.withOpacity(0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(91), topLeft: Radius.circular(91),topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
              ),
              child: Center(
                child: TextComponent(text: titre,color: Colors.white,textAlign: TextAlign.end,fontWeight: FontWeight.bold,),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              ],
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: CircleAvatar(
              backgroundColor: Colors.white,

              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final badge = _getBadgeForProgression(progress);

    return objectif.isEmpty? Center(
      child: Column(
        children: [
          Icon(Icons.error,color: Colors.red,size: 50,),
          TextComponent(text: "text")
        ],
      ),
    ):  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: TextComponent(text: "fitness_app",fontWeight: FontWeight.bold,color: Colors.white,size: 15,),
        
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: AnimationConfiguration.synchronized(
            duration: const Duration(milliseconds: 3000),
      
            child: ScaleAnimation(
              scale: 1.0,
              child: FadeInAnimation(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TextComponent(text: "Heureux de vous revoir",size: 15,),
                    Center(child: TextComponent(text: "Tableau de bord du PowerFit",size: 15,fontWeight: FontWeight.bold,)),
                    // TextComponent(text: "$userName !",size: 15,fontWeight: FontWeight.bold,),
                    h(20),
                    IntrinsicHeight(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          // color: Colors.black,
                          image: DecorationImage(
                            image: AssetImage('assets/images/h.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.srgbToLinearGamma(),
                          ),
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextComponent(
                                      text: "Mission Cible",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      size: 12,
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: TextComponent(
                                  text: powerfitProgram,
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  size: 14,
                                ),
                              ),

                              SizedBox(height: 10),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextComponent(
                                    text: powerfitFrequence,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    h(10),
                    Column(spacing: 10,
                      children: [
                        Center(child: TextComponent(text: "Menu du PowerFit", fontWeight: FontWeight.bold,size: 14,color: mainColor,)),
                        OwnDivider(),
                      ],
                    ),
                    h(10),
                    Center(
                      child: Wrap(
                        spacing: 15,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        runSpacing: 15,
                        children: [
                          BoxProduitG("powerfit1.png", "Présentations","Le PowerFit"),
                          InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BibliothequePowerFit(isFromAccueil: false,)));
                              },
                              child: BoxProduitD("powerfit2.png", "Exercices avec le PowerFit","Le PowerFit")),
                          InkWell(
                              onTap : (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProgrammePowerFit(isLocked: false,)));
                              },
                              child: BoxProduitG("powerfit3.png", "Programme d'entrainement","Le PowerFit")),
                          InkWell(
                              onTap : (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PowerFitForm()));
                              },
                              child: BoxProduitD("powerfit4.png", "Séance Personnalisée","Le PowerFit")),
                        ],
                      ),
                    ),

                    h(20),

                    InkWell(
                      onTap: () {
                        String today = _formatDay(DateTime.now());
                        if (!joursSemaine.contains(today)) {
                          // Afficher un message d'erreur
                          showToast(context, "Erreur : Aujourd'hui n'est pas un jour d'entraînement.Si vous désirez vous entrainer aujourd'hui, veuillez modifier votre séance personnalisée", Colors.red);

                        } else {
                          trierJours();
                          // clearProgramFromSharedPreferences();  // Naviguer vers la page de séance
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>
                          powerfitProgram=="Programme Perte de Poids"?PerteDePoidsFemmeSeancePerso(isReturningFromDetails: false,joursSemaine: joursSemaine,):
                          PowerSeancePerso(isReturningFromDetails: false,joursSemaine: joursSemaine,)
                          ));
                        }
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 3,
                        child: ButtonComponent(label: "Continuer l'entraînement",color: main2,)
                        /*Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: _daysCompleted[0]? Colors.green : Colors.red.shade200, width: 3),
                                  ),
                                  child: Center(
                                    child: TextComponent(
                                      text: "${_daysCompleted[0] ? '100%' : '0%'}", // Affichage du pourcentage
                                      fontWeight: FontWeight.bold,
                                      color: _daysCompleted[0] ? Colors.green : Colors.red,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 5,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextComponent(
                                          text: "Jour 1 d'entraînement",
                                          fontWeight: FontWeight.w200,
                                        ),
                                        w(70),
                                        TextComponent(
                                          text: "5min", // Durée fixe pour l'exemple
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      spacing: 45,
                                      children: [
                                        TextComponent(
                                          text: _exercises[0], // Nom de l'exercice pour le jour 1
                                          fontWeight: FontWeight.bold,
                                          size: 15,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),*/
                      ),
                    ),
                    h(15),
                    Card(
                      color: Colors.white.withOpacity(0.8),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        height: 250,width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(spacing: 10,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child:  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 5,
                                    children: [
                                      TextComponent(text: "Vos jours d'entrainements", fontWeight: FontWeight.bold,size: 13,textAlign: TextAlign.center,color: Colors.black54,),
                                      TextComponent(text: powerfitdays, fontWeight: FontWeight.bold,size: 13,textAlign: TextAlign.center,color: mainColor,),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    height: 100,width: 110,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      spacing: 5,
                                      children: [
                                        Container(
                                          height: 60,width: 60,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.green,width: 3),
                                            borderRadius: BorderRadius.circular(150),
                                          ),
                                          child: Center(
                                            child: TextComponent(text: "${progress.toStringAsFixed(2)}%",size: 14,fontWeight: FontWeight.bold,),
                                          ),
                                        ),
                                        TextComponent(text: "Progression", fontWeight: FontWeight.bold,size: 13,color: Colors.black.withOpacity(0.7),),
                                      ],
                                    ),
                                  ),
                                ),
      
                              ],
                            ),

                            h(10),

                            Container(
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      badge['image']!,
                                      scale: 9,
                                    ),
                                  ),
                                  TextComponent(
                                    text: badge['title']!,
                                    fontWeight: FontWeight.bold,
                                    size: 12,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    h(10),
      
                ]
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Fonction qui retourne le badge et son titre en fonction de la progression
  Map<String, String> _getBadgeForProgression(double progress) {
    if (progress < 25) {
      return {
        'image': 'assets/images/badge_debutant.png',
        'title': 'Badge\ndébutant'
      };
    } else if (progress < 50) {
      return {
        'image': 'assets/images/badge_intermediaire.png',
        'title': 'Badge\nintermédiaire'
      };
    } else if (progress < 75) {
      return {
        'image': 'assets/images/badge_avance.png',
        'title': 'Badge\navancé'
      };
    } else {
      return {
        'image': 'assets/images/badge_expert.png',
        'title': 'Badge\nexpert'
      };
    }
  }

  
  String deviceId = '';

  Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.id; // Utilisez 'id' pour obtenir l'ID de l'appareil

    return deviceId;
  }

  NosEquipement(String path, txt,code,id,idApp){
    return InkWell(
      onTap: () {
        showModalBottomSheet(context: context, builder: (context) {
          return Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white
            ),
            padding: EdgeInsets.only(top: 20,left: 5,right: 5),
            child: Column(
              spacing: 10,
              children: [
                TextComponent(text: 'Que voulez-vous faire ?', fontWeight: FontWeight.bold,size: 16,),
                Container(
                  height: 3,width: 100,
                  color: mainColor,
                ),
                h(20),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Details(producName: txt, path: path)),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(color: mainColor,width: 2.2),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: TextComponent(text: "Présentation de l'appareil",textAlign: TextAlign.center,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ),
                    ),InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SeanceLibre(),));
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(color: main2,width: 2.2),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: TextComponent(text: "Séance libre",textAlign: TextAlign.center,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ),
                    ),InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil(nom: txt,),));
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green,width: 2.2),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: TextComponent(text: "Séance Personnalisée",textAlign: TextAlign.center,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },);
      },
      child: Column(
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 200,width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image:  DecorationImage(
                      colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken),
                      image: AssetImage(path),fit: BoxFit.cover)
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const TextComponent(text: "Consulter",color: Colors.white,fontWeight: FontWeight.bold,),
                  ),
                  Expanded(child: h(0),),

                ],
              ),
            ),
          ),
          h(5),
          TextComponent(text: txt,size: 16,color: Colors.black,fontWeight: FontWeight.bold,textAlign: TextAlign.start,),
        ],
      ),
    );
  }
}

