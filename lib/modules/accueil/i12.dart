import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fitness_app/modules/base/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../monCompte/controller/controller.dart';
import '../seance_personnalise.dart';
import 'package:http/http.dart' as http;

class I12 extends StatefulWidget {

  final int nbr;
  String nom;
  String motivation;
  String sexe;
  String objectif;
  String morphologie;
  String age;
  String taille;
  String poidsActu;
  String poidsCible;
  String jours;
  String dateCible;

  I12({
    required this.dateCible,
    required this.jours ,required this.nbr,required this.nom, required this.motivation, required this.sexe, required this.objectif, required this.morphologie, required this.age, required this.taille, required this.poidsActu, required this.poidsCible});


  @override
  State<I12> createState() => _I12State();
}

class _I12State extends State<I12> {


  int? selectedHour;
  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  bool show = false;

  update() async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/fitness_app/updateSeancePerso.php?id=$id&motivation=${widget.motivation}&sexe=${widget.sexe}&objectifPrincipal=${widget.objectif}&morphologieSouhaite=${widget.morphologie}&age=${widget.age}&taille=${widget.taille}&poids=${widget.poidsActu}&poidsCible=${widget.poidsCible}&nbrSeance=${widget.nbr}&jourSeance=${widget.jours}&heureEntrainemenent=${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}&dateCible=${widget.dateCible}";
    var response = await http.get(Uri.parse(url));
    print("*************************************response.body");
    print(response.body);
    print(response.statusCode);
    try{
      if (response.body == "OK") {

        showToast(context, "Veuillez patienter quelques secondes", Colors.green);
        Future.delayed(Duration(seconds: 3),(){
          Phoenix.rebirth(context);
        });

      } else {
        setState(() {
          show = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                response.body,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )));
        });
      }
    }
    catch (e){
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    print("recap********************************************");
    print(id);
    print(widget.poidsCible);
    print(widget.poidsActu);
    print(widget.motivation);
    print(widget.sexe);
    print(widget.jours);
    print(widget.nbr);
    print(widget.taille);
    print(widget.age);
    print(widget.morphologie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          height: 100,
          color: mainColor,
          child: const Center(
            child: TextComponent(
              text: "Étapes 3 : Vos Objectifs",
              color: Colors.white,
              size: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const TextComponent(
                text: "À quelle Heure souhaitez-vous\nvous entraîner ?",
                fontWeight: FontWeight.bold,
                size: 14,
                textAlign: TextAlign.center,
              ),
            ),
            h(15),
            Center(
              child: ElevatedButton(
                onPressed: () => _selectTime(context), // Appel au sélecteur d'heure
                child: Text(
                  selectedTime != null
                      ? "Heure sélectionnée: ${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}"
                      : "Sélectionner une heure",
                ),
              ),
            ),
            h(15),
            show?Center(
              child: CircularProgressIndicator(backgroundColor: mainColor,),
            ) :  InkWell(
              onTap: () {
                if( selectedTime == null){
                  showToast(context, "Veuillez choisir un élément !", Colors.red);
                }
                else{
                  update();
                  clearProgramAndDates();

                }
             /*   print(widget.poidsCible);
                print(widget.nom);
                print(widget.nbr);
                print(widget.morphologie);
                print(widget.age);
                print(widget.taille);
                print(widget.jours);
                print(widget.sexe);
                print(widget.motivation);
                print(widget.poidsActu);
                print(widget.objectif);*/
              },
              child: ButtonComponent(label: "Terminer", size: 14,),
            ),
          ],
        ),
      ),
    );
  }
  List<List<Map<String, double>>> _program = [];
  List<DateTime> datesAssociees = [];
  int _currentDayIndex = -1; // Current day index in the program
  List<bool> _daysCompleted = []; // Track completed days

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