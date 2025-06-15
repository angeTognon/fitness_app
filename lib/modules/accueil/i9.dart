import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import 'package:flutter/material.dart';

import 'i10.dart';

class I9 extends StatefulWidget {
  String nom;
  String motivation;
  String sexe;
  String objectif;
  String morphologie;
  String age;
  String taille;

  I9({required this.nom, required this.motivation, required this.sexe, required this.objectif, required this.morphologie, required this.age, required this.taille});

  @override
  State<I9> createState() => _I9State();
}

class _I9State extends State<I9> {
  double _selectedWeight = 70.0; // Poids actuel par défaut
  double _targetWeight = 70.0; // Poids cible par défaut
  late ScrollController _scrollController;
  late ScrollController _targetScrollController;
  final double height = 1.75; // Taille de l'utilisateur en mètres

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _targetScrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double initialScrollPosition = (_selectedWeight - 40) * 54 - 100; // Ajuster pour centrer
      _scrollController.jumpTo(initialScrollPosition);

      double targetInitialScrollPosition = (_targetWeight - 40) * 54 - 100; // Ajuster pour centrer le poids cible
      _targetScrollController.jumpTo(targetInitialScrollPosition);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _targetScrollController.dispose();
    super.dispose();
  }

  double calculateBMI(double weight) {
    return weight / (height * height); // Calcul de l'IMC
  }

  String getBMIDescription(double bmi) {
    if (bmi < 18.5) {
      return "Insuffisance pondérale";
    } else if (bmi < 24.9) {
      return "Poids normal";
    } else if (bmi < 29.9) {
      return "Surpoids";
    } else {
      return "Obésité";
    }
  }

  String getSilhouetteDescription(double bmi) {
    if (bmi < 18.5) {
      return "Vous êtes plutôt mince.";
    } else if (bmi < 24.9) {
      return "Vous avez une silhouette équilibrée.";
    } else if (bmi < 29.9) {
      return "Vous avez une silhouette un peu plus pleine.";
    } else {
      return "Vous avez une silhouette plus ronde.";
    }
  }

  String getHealthAdvice(double targetWeight) {
    double targetBMI = calculateBMI(targetWeight);
    if (targetBMI < 18.5) {
      return "Votre objectif IMC est considéré comme insuffisant. Cela peut conduire à des problèmes de santé tels que la fatigue ou une immunité réduite.";
    } else if (targetBMI < 24.9) {
      return "Votre objectif IMC est dans la plage normale. C'est idéal pour votre santé globale.";
    } else if (targetBMI < 29.9) {
      return "Votre objectif IMC est considéré comme surpoids. Cela peut augmenter le risque de maladies cardiaques et de diabète.";
    } else {
      return "Votre objectif IMC est considéré comme obèse. Cela peut entraîner des problèmes de santé graves tels que des maladies cardiovasculaires et des troubles métaboliques.";
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI(_selectedWeight); // Calcule l'IMC
    String bmiDescription = getBMIDescription(bmi); // Obtenir la description de l'IMC
    String silhouetteDescription = getSilhouetteDescription(bmi); // Obtenir la description de la silhouette
    String healthAdvice = getHealthAdvice(_targetWeight); // Obtenir les conseils de santé

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: const TextComponent(
                text: "Quelle est votre poids ?",
                fontWeight: FontWeight.bold,
                size: 14,
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: SizedBox(
                height: 70, // Hauteur de la zone de sélection
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 111, // Plage de poids de 40 à 150 kg
                  itemBuilder: (context, index) {
                    double weight = index.toDouble() + 40; // Poids de l'élément commençant à 40
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedWeight = weight; // Met à jour le poids sélectionné
                          _targetWeight = weight; // Met à jour le poids cible pour le synchroniser
                          print(_selectedWeight);
                        });
                      },
                      child: Container(
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: weight == _selectedWeight ? mainColor : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "$weight\nKg",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'PRegular',
                            fontSize: 14,
                            color: weight == _selectedWeight ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextComponent(
              text: "IMC Correspondant à votre Poids : ${bmi.toStringAsFixed(2)}",
              fontWeight: FontWeight.bold,
              size: 14,
            ),
            const SizedBox(height: 10),
            TextComponent(
              text: bmiDescription,
              fontWeight: FontWeight.bold,
              size: 14,
              color: mainColor,
            ),
            const SizedBox(height: 10),
            TextComponent(
              text: silhouetteDescription,
              fontWeight: FontWeight.bold,
              size: 14,
              color: mainColor,
            ),
            const SizedBox(height: 20),
            Center(
              child: const TextComponent(
                text: "Quel est votre poids cible ?",
                fontWeight: FontWeight.bold,
                size: 14,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: 70, // Hauteur de la zone de sélection
                child: ListView.builder(
                  controller: _targetScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 111, // Plage de poids de 40 à 150 kg
                  itemBuilder: (context, index) {
                    double targetWeight = index.toDouble() + 40; // Poids de l'élément commençant à 40
                    bool isInRange =
                        (_selectedWeight <= targetWeight && targetWeight <= _targetWeight) ||
                            (_selectedWeight >= targetWeight && targetWeight >= _targetWeight);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _targetWeight = targetWeight; // Met à jour le poids cible
                          print(_targetWeight);
                        });
                      },
                      child: Container(
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: targetWeight == _targetWeight ? Colors.green : (isInRange ? Colors.redAccent : Colors.grey[300]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "$targetWeight\nKg",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'PRegular',
                            fontSize: 14,
                            color: targetWeight == _targetWeight ? Colors.white : (isInRange ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextComponent(
              text: "Poids cible : ${_targetWeight.round()} Kg",
              fontWeight: FontWeight.bold,
              size: 14,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            TextComponent(
              text: healthAdvice, // Afficher le texte d'indication de santé
              size: 14,
              fontWeight: FontWeight.bold,
              color: Colors.red[500],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => I10(
                  objectif: widget.objectif,
                  sexe: widget.sexe,
                  motivation: widget.motivation,
                  nom: widget.nom,
                  morphologie: widget.morphologie,
                  age: widget.age,
                  taille: widget.taille,
                  poidsActu: "$_selectedWeight",
                  poidsCible: "$_targetWeight",
                ),));
              },
              child: ButtonComponent(label: "Suivant",size: 15,),
            ),
          ],
        ),
      ),
    );
  }
}