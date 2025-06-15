import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'i8.dart';

class I7 extends StatefulWidget {
  String nom;
  String motivation;
  String sexe;
  String objectif;
  String morphologie;

  I7({required this.nom, required this.motivation, required this.sexe, required this.objectif, required this.morphologie,});

  @override
  State<I7> createState() => _I7State();
}

class _I7State extends State<I7> {

  DateTime _selectedDate = DateTime.now();


  final int _selectedSizeIndex = 0; // Index du taille sélectionnée
  final List<String> _sizes = List.generate(101, (index) => '${150 + index} cm'); // Taille de 150 à 250 cm
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: Container(
            padding: const EdgeInsets.only(top: 50),
            height: 100,
            color: mainColor,
            child: const Center(
              child: TextComponent(text: "Étapes 2 : Connaitre votre corps",color: Colors.white,size: 15,fontWeight: FontWeight.bold,),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: const TextComponent(text: "Quelle âge avez vous  ?",fontWeight: FontWeight.bold,size: 15,)),
            h(20),
            const TextComponent(text: "Cela nous permettra de mieux choisir l'entraînement qui conviendra à votre âge ",size: 14,textAlign: TextAlign.center,),
            // Text(
            //   "Date sélectionnée: ${_selectedDate.toLocal()}".split(' ')[0],
            //   style: TextStyle(fontSize: 20),
            // ),
            // SizedBox(height: 20),
            SizedBox(
              height: 400, // Ajuster la hauteur selon vos besoins
              child: CupertinoDatePicker(
                initialDateTime: _selectedDate,
                minimumYear: 1950,
                maximumYear: DateTime.now().year, // Use the current year as maximum
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                    print(_selectedDate);
                  });
                },
              ),
            ),
            h(50),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => I8(
                      objectif: widget.objectif,
                      sexe: widget.sexe,
                      motivation: widget.motivation,
                      nom: widget.nom,
                    morphologie: widget.morphologie,
                    age: "$_selectedDate"
                  ),));
                },
                child: ButtonComponent(label: "Suivant",size: 15,)),
          ],
        ),
      )
    );
  }
}