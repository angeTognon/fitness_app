import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart'; // Importez ce package pour la rotation de l'écran
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../app/components/bouton_components.dart';
import '../app/components/text_components.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import 'details/details_seances.dart';
import 'details/details_seances2.dart';
import 'details/details_seances_from_seance_libre.dart';

class SeanceLibre extends StatefulWidget {
  const SeanceLibre({super.key});

  @override
  State<SeanceLibre> createState() => _SeanceLibreState();
}

class _SeanceLibreState extends State<SeanceLibre> with SingleTickerProviderStateMixin{

  final List<String> _exercises = [
    "VP & A Hm Exercice Side Twist",
    "RS Tirage Montant",
    "VP & A Hm Exercice Side Crunch",
    "PGBF EXERCICE Triceps Tirage Poulie basse",
    "PGBF EXERCICE Tirage dans le Dos Poulie Basse",
    "PGBF EXERCICE Rowing à la Poulie Basse",
    "PGBF EXERCICE Rope Fly",
    "PGBF EXERCICE Curls Poulie Basse",
    "PGBF EXERCICE Triceps Poulie Basse Unilateral",
    "DPB EXERCICE Kick Back",
    "DPB EXERCICE Extension Triceps Incliné",
    "RS Elevation Laterale Epaules",
    "RS Elevation Genoux",
    "RS Tirage Horizontale 1",
    "CJF EXERCICE Kick Back Unilateral",
    "PPH Exercice Tirage à la Poulie Basse",
    "PPH Exercice Rotation de la hanche oblique",
    "PPH Exercice Air Squat",
    "PPH Exercice Triceps",
    "VP & A Hm Exercice Crunch Oblique",
    "VP & A Hm Exercice Elevation du Corps",
    "DPB EXERCICE Developper Assis",
    "DPB EXERCICE Developpé Unilateral Aux Halteres",
    "VP & A Hm Exercice Leg Raise",
  ];
  final List<String> nbrSerie = [
    "20",
    "15",
    "15",
    "15",
    "15",
    "15",
    "20",
    "15",
    "15",
    "15",
    "20",
    "15",
    "10",
    "20",
    "15",
    "15",
    "10",
    "10",
    "15",
    "10",
    "10",
    "15",
    "15",
    "5",
  ];



  final List<String> nbrRepetition = [
    "4",
    "4",
    "5",
    "5",
    "5",
    "5",
    "5",
    "5",
    "5",
    "5",
    "7",
    "4",
    "5",
    "5",
    "5",
    "5",
    "5",
    "5",
    "5",
    "4",
    "5",
    "7",
    "4",
    "20"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: const TextComponent(
            text: "Séances libres",
            color: Colors.white,
            size: 15,
            fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: AnimationLimiter(
          child: Column(
            spacing: 15,
            children: List.generate(_exercises.length, (index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 3000),
                child: ScaleAnimation(
                  scale: 1.0,
                  child: FadeInAnimation(
                    child: Box("${index + 1}", _exercises[index], nbrSerie[index], nbrRepetition[index]),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
  Box(String nbr, titre, nombreDeSerie, nbrRepetition){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsSeancesFromSeanceLibre(day: "$nbr",nombreDeSerie: nombreDeSerie,nombreDeRepetition: nbrRepetition,)));
      },
      child: Card(
        color: Colors.white ,
        elevation: 5,
        child: Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(spacing: 10,
                  children: [
                    Container(
                      height: 40,width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: mainColor,width: 2)
                      ),
                      child: Center(
                        child: Icon(Icons.sports,color: main2,),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: [
                        TextComponent(
                          text: "Exercice $nbr",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          size: 14,
                        ),

                        Container(
                          width: 200,
                          child: TextComponent(
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                            text: titre,
                            fontWeight: FontWeight.w300,
                            color:  Colors.black,
                            size: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 40,width: 40,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.remove_red_eye,color: Colors.white,)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
