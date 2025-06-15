import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'i9.dart';

class I8 extends StatefulWidget {
  String nom;
  String motivation;
  String sexe;
  String objectif;
  String morphologie;
  String age;

  I8({required this.nom, required this.motivation, required this.sexe, required this.objectif, required this.morphologie, required this.age});

  @override
  State<I8> createState() => _I8State();
}

class _I8State extends State<I8> {

  DateTime _selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: CupertinoDatePicker(
            initialDateTime: _selectedDate,
            minimumYear: 2000,
            maximumYear: 2100,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  int _selectedSizeIndex = 6; // Index du taille sélectionnée
  final List<String> _sizes = List.generate(101, (index) => '${150 + index} cm'); // Taille de 150 à 250 cm
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
              child: TextComponent(text: "Étapes 2 : Connaitre votre corps",color: Colors.white,size: 15,fontWeight: FontWeight.bold,),
            ),
          ),
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: const TextComponent(text: "Quelle est votre taille   ?",fontWeight: FontWeight.bold,size: 15,)),

            SizedBox(
              height: 250, // Ajuster la hauteur selon vos besoins
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: _selectedSizeIndex),
                itemExtent: 32.0, // Hauteur de chaque élément
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _selectedSizeIndex = index;
                    print(_sizes[_selectedSizeIndex]);
                  });
                },
                children: List<Widget>.generate(_sizes.length, (int index) {
                  return Center(
                    child: Text(
                      _sizes[index],
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }),
              ),
            ),

            h(50),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>I9(
                      objectif: widget.objectif,
                      sexe: widget.sexe,
                      motivation: widget.motivation,
                      nom: widget.nom,
                      morphologie: widget.morphologie,
                      age: widget.age,
                    taille: _sizes[_selectedSizeIndex],
                  ),));
                },
                child: ButtonComponent(label: "Suivant",size: 15,)),
          ],
        ),
      )
    );
  }
}