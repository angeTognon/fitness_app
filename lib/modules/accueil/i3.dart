import 'package:fitness_app/modules/accueil/i6.dart';
import 'package:fitness_app/modules/monCompte/controller/controller.dart';

import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import 'i4.dart';

class I3 extends StatefulWidget {
  final String motivation;
  final String nom;
  final String sexe;

  I3({required this.motivation, required this.sexe, required this.nom});

  @override
  State<I3> createState() => _I3State();
}

class _I3State extends State<I3> {
  final List<Objectif> objectifs = [
    Objectif(
      title: 'Perte de poids  (Femmes)',
      description: 'Transformez votre corps et retrouvez une silhouette plus légère et dynamique grâce à des séances adaptées pour brûler efficacement les calories.',
      icon: Icons.fitness_center,
    ),
    Objectif(
      title: 'Ventre plat et abdos définis  (Femmes)',
      description: 'Dites adieu au ventre rebondi! Travaillez vos abdominaux pour un ventre tonique et dessiné.',
      icon: Icons.spa,
    ),
    Objectif(
      title: 'Perte de graisse dans les bras (Femmes)',
      description: 'Affinez et tonifiez vos bras avec des exercices ciblés qui redéfiniront leur forme.',
      icon: Icons.fitness_center,
    ),
    Objectif(
      title: 'Sculpter cuisses, jambes et fessiers (Femmes)',
      description: 'Dessinez des jambes élégantes et des fessiers fermes en suivant des séances conçues pour transformer le bas de votre corps.',
      icon: Icons.directions_run,
    ),

    Objectif(
      title: 'Perte de poids (hommes)',
      description: 'Transformez votre corps et retrouvez une silhouette plus légère et dynamique grâce à des séances adaptées pour brûler efficacement les calories.',
      icon: Icons.fitness_center,
    ),
    Objectif(
      title: 'Développer la poitrine (hommes)',
      description: 'Boostez votre puissance et votre allure avec un buste bien dessiné.',
      icon: Icons.chair_alt,
    ),
    Objectif(
      title: 'Ventre plat et abdos définis (hommes)',
      description: 'Dites adieu au ventre rebondi! Travaillez vos abdominaux pour un ventre tonique et dessiné.',
      icon: Icons.spa,
    ),



    Objectif(
      title: 'Renforcement musculaire',
      description: 'Fortifiez tout votre corps avec des exercices qui vous donneront une base solide.',
      icon: Icons.build,
    ),
    Objectif(
      title: 'Soulager les douleurs lombaires',
      description: 'Libérez-vous des tensions ! Renforcez votre dos avec des mouvements doux et ciblés.',
      icon: Icons.healing,
    ),
    Objectif(
      title: 'Routine corps complet',
      description: 'Adoptez une approche équilibrée pour travailler chaque partie de votre corps.',
      icon: Icons.fitness_center,
    ),
  ];

  List<Objectif> filterObjectifs(List<Objectif> objectifs, String sexe) {
    return objectifs.where((objectif) {
      if (sexe == 'feminin') {
        return !objectif.title.toLowerCase().contains('(hommes)') || objectif.title.toLowerCase().contains('(femmes)');
      } else if (sexe == 'masculin') {
        return !objectif.title.toLowerCase().contains('(femmes)');
      }
      return true;
    }).toList();
  }

  int? selectedIndex;

  final List<Objectif> objectifsPowerbands = [
    Objectif(
      title: 'Affiner la silhouette (femmes)',
      description: 'Un programmePowerBand ciblé pour réduire la graisse, tonifier les bras, sculpter les fessiers, et obtenir un ventre plat. Idéal pour une silhouette harmonieuse.',
      icon: Icons.fitness_center,
    ),
    Objectif(
      title: 'Renforcement musculaire (hommes)',
      description: 'Perdez du poids, définissez vos abdos et gagnez en force avec des exercices qui renforcent tout le corps et boostent vos performances.',
      icon: Icons.spa,
    ),
    Objectif(
      title: 'Prise de masse et hypertrophie(hommes)',
      description: 'Un plan efficace pour développer du volume musculaire, augmenter la force et améliorer l’apparence physique',
      icon: Icons.fitness_center,
    ),
    Objectif(
      title: 'Soulagement des douleurs lombaires',
      description: 'Renforcez votre dos, améliorez votre posture et soulagez vos tensions avec des exercices doux et ciblés.',
      icon: Icons.directions_run,
    ),
  ];

  final List<Objectif> objectifsPackStart = [
    Objectif(
      title: 'Polyvalence d\'exercice',
      description: 'Le kit de bandes de résistance avec barre cible tous les groupes musculaires.',
      icon: Icons.fitness_center,
    ),
    Objectif(
      title: 'Transportable',
      description: 'Compact et léger, il est facile à transporter et à utiliser partout.',
      icon: Icons.airport_shuttle,
    ),
    Objectif(
      title: 'Différentes résistances',
      description: 'Grâce aux différentes résistances, il s\'adapte à tous les niveaux.',
      icon: Icons.tune,
    ),
    Objectif(
      title: 'Renforcer les muscles stabilisateurs',
      description: 'Ciblez les muscles stabilisateurs pour améliorer votre équilibre et votre posture.',
      icon: Icons.balance,
    ),
  ];
  final List<Objectif> objectifsMasterFit = [
    Objectif(
      title: 'Entraînement multifonction',
      description: 'Ce banc d\'entraînement permet de travailler différents groupes musculaires (abdominaux, bras, jambes).',
      icon: Icons.build,
    ),
    Objectif(
      title: 'Économie d\'espace',
      description: 'Son design compact économise de l\'espace et s’adapte à tous les niveaux.',
      icon: Icons.space_bar,
    ),
    Objectif(
      title: 'Accessoires variés',
      description: 'S’adapte à tous les niveaux avec ses réglages et accessoires comme les bandes élastiques.',
      icon: Icons.accessibility,
    ),
    Objectif(
      title: 'Amélioration de la flexibilité',
      description: 'Optimisez votre flexibilité avec des exercices variés sur le banc.',
      icon: Icons.build,
    ),
  ];

  final List<Objectif> objectifsZR800 = [
    Objectif(
      title: 'Entraînement cardio efficace',
      description: 'Le vélo d\'appartement pliable offre un entraînement cardio tout en préservant le confort.',
      icon: Icons.bike_scooter,
    ),
    Objectif(
      title: 'Siège ergonomique',
      description: 'Il est doté d\'un siège ergonomique et d\'un support dorsal pour un meilleur confort.',
      icon: Icons.chair,
    ),
    Objectif(
      title: 'Design compact',
      description: 'Son design compact et pliable le rend parfait pour les petits espaces.',
      icon: Icons.folder_open,
    ),
    Objectif(
      title: 'Suivi de la performance',
      description: 'Évaluez vos performances avec des fonctionnalités de suivi intégrées.',
      icon: Icons.assessment,
    ),
  ];

  final List<Objectif> objectifsStepper = [
    Objectif(
      title: 'Entraînement cardio à domicile',
      description: 'Ce mini-stepper est idéal pour un entraînement cardio à domicile. Il est compact et facile à ranger.',
      icon: Icons.directions_run,
    ),
    Objectif(
      title: 'Tonification des jambes',
      description: 'Il permet de tonifier les muscles des jambes, des cuisses et des fessiers tout en améliorant l\'endurance.',
      icon: Icons.fitness_center,
    ),
    Objectif(
      title: 'Renforcement du haut du corps',
      description: 'Grâce aux élastiques intégrés, il offre également un renforcement du haut du corps, rendant l\'exercice complet.',
      icon: Icons.spa,
    ),
    Objectif(
      title: 'Brûler des calories',
      description: 'Idéal pour brûler des calories rapidement et améliorer votre métabolisme.',
      icon: Icons.local_fire_department,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Objectif> filteredObjectifs = widget.nom == "MasterFit"
        ? filterObjectifs(objectifs, widget.sexe)
        : widget.nom == "ZR - 800"
        ? filterObjectifs(objectifs, widget.sexe)
        : widget.nom == "Stepper"
        ? filterObjectifs(objectifs, widget.sexe)
        : widget.nom == "Pack Start"
        ? filterObjectifs(objectifs, widget.sexe)
        : widget.nom == "CardioQuad 23"
        ? filterObjectifs(objectifs, widget.sexe)
        : filterObjectifs(objectifs, widget.sexe);


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
              text: "Étapes 1 : Vos Objectifs",
              color: Colors.white,
              size: 16,
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
              child:  TextComponent(
                text: "Quel est votre objectif principal ?",
                fontWeight: FontWeight.bold,
                size: 14,
              ),
            ),
            h(20),
            for (int index = 0; index < filteredObjectifs.length; index++) ...[
              InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = selectedIndex == index ? null : index;
                    print(selectedIndex);
                  });
                },
                child: Column(
                  children: [
                    Card(
                      color: selectedIndex == index ? mainColor : null,
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  TextComponent(
                                    text: filteredObjectifs[index].title.replaceAll(RegExp(r' *\(hommes\)| *\(Femmes\)'), '').trim(),
                                    size: 13,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : null,
                                    fontWeight: selectedIndex == index
                                        ? FontWeight.bold
                                        : null,
                                    overflow: TextOverflow.ellipsis,
                                    maxLine: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (selectedIndex == index) ...[
                      h(10),
                      Card(
                        color: Colors.white,
                        child: IntrinsicHeight(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Icon(
                                  filteredObjectifs[index].icon,
                                  size: 30,
                                ),
                                w(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 220,
                                      child: TextComponent(
                                        text: filteredObjectifs[index]
                                            .description,
                                        size: 12,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              h(15),
            ],
            InkWell(
              onTap: () {
               /* switch (selectedIndex){
                  case 0:
                    showToast(context, filteredObjectifs[0].title, mainColor);
                    break;
                  case 1:
                    showToast(context, filteredObjectifs[1].title, mainColor);
                    break;
                  case 2:
                    showToast(context, filteredObjectifs[2].title, mainColor);
                    break;
                  case 3:
                    showToast(context, filteredObjectifs[3].title, mainColor);
                    break;
                  case 4:
                    showToast(context, filteredObjectifs[4].title, mainColor);
                    break;
                  case 5:
                    showToast(context, filteredObjectifs[5].title, mainColor);
                    break;
                  case 6:
                    showToast(context, filteredObjectifs[6].title, mainColor);
                    break;
                  default:
                    showToast(context, filteredObjectifs[7].title, mainColor);
                    break;
                }*/
                if(selectedIndex==null){
                  showToast(context, "Veuillez choisir un objectif !", Colors.red);
                }else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => I6(
                          motivation:widget.motivation,
                          nom:widget.nom,
                          sexe:widget.sexe,
                          objectif:
                          selectedIndex==0?filteredObjectifs[0].title :
                          selectedIndex==1?filteredObjectifs[1].title :
                          selectedIndex==2?filteredObjectifs[2].title :
                          selectedIndex==3?filteredObjectifs[3].title :
                          selectedIndex==4?filteredObjectifs[4].title :
                          selectedIndex==5?filteredObjectifs[5].title :
                          selectedIndex==6?filteredObjectifs[6].title :
                          filteredObjectifs[7].title
                      ),
                    ),
                  );
                }
              },
              child: ButtonComponent(
                label: "Suivant",
                size: 15,
              ),
            ),
            h(100)
          ],
        ),
      ),
    );
  }
}

class Objectif {
  final String title;
  final String description;
  final IconData icon;

  Objectif({
    required this.title,
    required this.description,
    required this.icon,
  });
}
