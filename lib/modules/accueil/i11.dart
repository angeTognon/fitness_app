import 'package:flutter/material.dart';
import 'package:fitness_app/modules/accueil/i12.dart';

import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../monCompte/controller/controller.dart';
import '../seance_personnalise.dart';

class I11 extends StatefulWidget {
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
  String dateCible;

  I11({
    required this.dateCible,
    required this.nbr,required this.nom, required this.motivation, required this.sexe, required this.objectif, required this.morphologie, required this.age, required this.taille, required this.poidsActu, required this.poidsCible});

  @override
  State<I11> createState() => _I11State();
}

class _I11State extends State<I11> {
  final List<String> daysOfWeek = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
  Set<String> _selectedDays = {};

  void _onDayTapped(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        if (_selectedDays.length < widget.nbr) {
          _selectedDays.add(day);
        } else {
          // Alerte si le nombre de jours sélectionnés dépasse le nombre de séances
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Vous pouvez sélectionner jusqu'à ${widget.nbr} jours."),
            ),
          );
        }
      }
    });
  }

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
                text: "À quelle fréquence souhaitez-vous\nvous entraîner ?",
                fontWeight: FontWeight.bold,
                size: 14,
                textAlign: TextAlign.center,
              ),
            ),
            h(20),
            Center(
              child: const TextComponent(
                text: "Veuillez choisir les jours de vos entraînements",
                size: 14,
                textAlign: TextAlign.center,
              ),
            ),
            h(20),
            Column(
              spacing: 10,
              children: daysOfWeek.map((day) {
                return GestureDetector(
                  onTap: () {
                    _onDayTapped(day);
                    print(_selectedDays);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(14),
                    width: MediaQuery.of(context).size.width,

                    decoration: BoxDecoration(
                      color: _selectedDays.contains(day) ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          color: _selectedDays.contains(day) ? Colors.white : Colors.black,
                          fontFamily: "PRegular",
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            h(15),
           /* const TextComponent(
              text: "À quelle heure ?",
              fontWeight: FontWeight.bold,
              size: 16,
            ),
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
            h(15),*/
            InkWell(
              onTap: () {
                if(_selectedDays.isEmpty){
                  showToast(context, "Veuillez choisir un élément !", Colors.red);
                }
                else
                Navigator.push(context, MaterialPageRoute(builder: (context) => I12(
                    objectif: widget.objectif,
                    sexe: widget.sexe,
                    motivation: widget.motivation,
                    nom: widget.nom,
                    morphologie: widget.morphologie,
                    age: widget.age,
                    taille: widget.taille,
                    poidsActu: widget.poidsActu,
                    poidsCible: widget.poidsCible,
                    nbr : widget.nbr,
                  jours: "$_selectedDays" ,
                    dateCible : widget.dateCible
                ),));
              },
              child: ButtonComponent(label: "Suivant", size: 14,),
            ),
          ],
        ),
      ),
    );
  }
}