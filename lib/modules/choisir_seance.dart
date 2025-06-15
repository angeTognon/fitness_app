import 'package:flutter/material.dart';
import 'package:fitness_app/modules/accueil/i11.dart';
import 'package:fitness_app/modules/monCompte/controller/controller.dart';

import '../app/components/bouton_components.dart';
import '../app/components/text_components.dart';
import '../utils/colors.dart';

class ChoisirSeances extends StatefulWidget {
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

  ChoisirSeances({
    required this.dateCible,
    required this.nom, required this.motivation, required this.sexe, required this.objectif, required this.morphologie, required this.age, required this.taille, required this.poidsActu, required this.poidsCible});

  @override
  _ChoisirSeancesState createState() => _ChoisirSeancesState();
}

class _ChoisirSeancesState extends State<ChoisirSeances> {
  int selectedSessions=0; // Variable pour stocker le nombre de séances sélectionnées

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
          child:  Center(
            child: TextComponent(
              text: "Choisissez le nombre de séances",
              color: Colors.white,
              size: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 1; i <= 4; i++) // Boucle pour créer les Container
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSessions = i; // Mettre à jour la variable avec le nombre de séances
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: selectedSessions == i ? Colors.blue : Colors.grey[300], // Changer la couleur si sélectionné
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: TextComponent(text:
                        "$i Séance${i > 1 ? 's' : ''} par semaine", // Texte dynamique
                        color: selectedSessions == i ? Colors.white : Colors.black,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 50,),
              InkWell(
                onTap: () {
                  if(selectedSessions==0){
                    showToast(context, "Veuillez choisir un élément !", Colors.red);
                  }
                  else
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  I11(
                      objectif: widget.objectif,
                      sexe: widget.sexe,
                      motivation: widget.motivation,
                      nom: widget.nom,
                      morphologie: widget.morphologie,
                      age: widget.age,
                      taille: widget.taille,
                      poidsActu: widget.poidsActu,
                      poidsCible: widget.poidsCible,
                      nbr : selectedSessions,
                      dateCible : widget.dateCible
                  ),));
                },
                child: ButtonComponent(label: "Suivant",size: 15,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}