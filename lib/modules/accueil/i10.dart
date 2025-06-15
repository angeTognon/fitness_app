import 'dart:math';
import 'package:fitness_app/modules/choisir_seance.dart';
import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import 'package:flutter/material.dart';

class I10 extends StatefulWidget {
  final String nom;
  final String motivation;
  final String sexe;
  final String objectif;
  final String morphologie;
  final String age;
  final String taille;
  final String poidsActu;
  final String poidsCible;

  I10({
    required this.nom,
    required this.motivation,
    required this.sexe,
    required this.objectif,
    required this.morphologie,
    required this.age,
    required this.taille,
    required this.poidsActu,
    required this.poidsCible,
  });

  @override
  State<I10> createState() => _I10State();
}

class _I10State extends State<I10> {
  final Random _random = Random();

  // Fonction pour calculer le temps nécessaire en jours
  int calculateTimeRequired(String motivation, double poidsActu, double poidsCible) {
    double weightDifference = (poidsCible - poidsActu).abs();
    double motivationFactor;

    switch (motivation) {
      case 'Évacuer Mon Stress':
        motivationFactor = 1.2;
        break;
      case 'Améliorer Ma Santé':
        motivationFactor = 1.0;
        break;
      case 'Se Modeler':
        motivationFactor = 0.9;
        break;
      case 'Avoir Un Meilleur Physique':
        motivationFactor = 0.8;
        break;
      case 'Gagner en Confiance':
        motivationFactor = 0.7;
        break;
      default:
        motivationFactor = 1.0;
    }

    return (weightDifference * motivationFactor * 30).toInt(); // Estimation en jours
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();

    // Use the provided target weight from the widget
    double poidsCible = double.parse(widget.poidsCible);
    double poidsActu = double.parse(widget.poidsActu);

    // Calculate the number of days required based on the provided target weight
    int daysRequired = calculateTimeRequired(widget.motivation, poidsActu, poidsCible);

    // Calculate the target date by adding the required days to the current date
    DateTime targetDate = today.add(Duration(days: daysRequired));

    // Display the target date
    String targetDateString = "${targetDate.day} ${_getMonthName(targetDate.month)} ${targetDate.year}";

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
              text: "Étapes 2 : Connaitre votre corps",
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: const TextComponent(
                text: "Selon vos réponses, vous serez à",
                fontWeight: FontWeight.bold,
                size: 14,
                textAlign: TextAlign.center,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextComponent(
                  text: "${widget.poidsCible} KG le  ",
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  size: 14,
                ),
                TextComponent(
                  text: targetDateString, // Display the full target date
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                  size: 14,
                ),
              ],
            ),
            const SizedBox(height: 25),
            Center(
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/xc.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChoisirSeances(
                      objectif: widget.objectif,
                      sexe: widget.sexe,
                      motivation: widget.motivation,
                      nom: widget.nom,
                      morphologie: widget.morphologie,
                      age: widget.age,
                      taille: widget.taille,
                      poidsActu: widget.poidsActu,
                      poidsCible: widget.poidsCible,
                        dateCible : targetDateString
                    ),
                  ),
                );
              },
              child: ButtonComponent(label: "Suivant", size: 15),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      "Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"
    ];
    return monthNames[month - 1]; // Renvoie le nom du mois
  }
}
