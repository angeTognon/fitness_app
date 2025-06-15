import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import 'i7.dart';

class I6 extends StatefulWidget {
  String nom;
  String motivation;
  String sexe;
  String objectif;

  I6({required this.nom, required this.motivation, required this.sexe, required this.objectif});

  @override
  State<I6> createState() => _I6State();
}

class _I6State extends State<I6> {
  double _currentValue = 3.0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    print(widget.objectif);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onSliderChanged(double value) {
    setState(() {
      _currentValue = value;
    });

    // Calculer la position du conteneur et faire défiler
    double scrollPosition = (value * 160) - 80; // Ajuster pour centrer
    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<String> img = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
    "assets/images/6.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: Container(
            padding: const EdgeInsets.only(top: 50),
            height: 120,
            color: mainColor,
            child: const Center(
              child: TextComponent(text: "Étapes 1 : Vos Objectfis",color: Colors.white,size: 16,fontWeight: FontWeight.bold,),
            ),
          ),
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: const TextComponent(text: "Quelle est votre\nmorphologie Souhaitée  ?",fontWeight: FontWeight.bold,size: 14,textAlign: TextAlign.center,)),
            h(20),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    // Calculer l'échelle et l'opacité
                    double scale = index == _currentValue.toInt() ? 1.0 : 0.7;
                    double opacity = index == _currentValue.toInt() ? 1.0 : 0.6;

                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          // color: mainColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: mainColor,width: 4),
                          image: DecorationImage(image: AssetImage(img[index]),fit: BoxFit.cover)
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            h(30),
            TextComponent(text:
            _currentValue.toInt()==1?'Masse Grasse (10%-15%)':
            _currentValue.toInt()==2?'Masse Grasse (16%-21%)':
            _currentValue.toInt()==3?'Masse Grasse (22%-27%)':
            _currentValue.toInt()==4?'Masse Grasse (28%-35%)':
            _currentValue.toInt()==5?'Masse Grasse (36%-45%)':
            'Masse Grasse (>45%)',
              fontWeight: FontWeight.bold,
              size: 14,

            ),
            SizedBox(
              height: 50, // Hauteur augmentée du Slider
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 6.0, // Hauteur de la piste
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10), // Taille du pouce
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0), // Taille de l'overlay
                ),
                child: Slider(
                  value: _currentValue,
                  min: 0,
                  activeColor: null,
                  thumbColor: null,
                  inactiveColor: null,
                  max: 5,
                  divisions: 5,
                  onChanged: _onSliderChanged,
                ),
              ),
            ),
            h(30),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => I7(
                    objectif: widget.objectif,
                    sexe: widget.sexe,
                    motivation: widget.motivation,
                    nom: widget.nom,
                    morphologie: _currentValue.toString(),

                  ),));
                },
                child: ButtonComponent(label: "Suivant",size: 15,)),
          ],
        ),
      )
    );
  }
}