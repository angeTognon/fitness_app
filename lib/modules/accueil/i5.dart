import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import 'i6.dart';

class I5 extends StatefulWidget {
  const I5({super.key});

  @override
  State<I5> createState() => _I5State();
}

class _I5State extends State<I5> {
  double _currentValue = 3.0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    _onSliderChanged(_currentValue);

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
    double scrollPosition = (_currentValue * 160) - 80; // Ajuster pour centrer
    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: Container(
            padding: const EdgeInsets.only(top: 50),
            height: 130,
            color: mainColor,
            child: const Center(
              child: TextComponent(text: "Étapes 1 : Vos Objectfis",color: Colors.white,size: 20,fontWeight: FontWeight.bold,),
            ),
          ),
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextComponent(text: "Quelle est votre\nmorphologie Actuelle ?",fontWeight: FontWeight.bold,size: 18,),
            h(40),
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
        
                    return Opacity(
                      opacity: opacity,
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 150,
                          height: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: mainColor,
                          /*  image: DecorationImage(image: AssetImage(
                                _currentValue.toInt()==0?"assets/images/1.png":
                                _currentValue.toInt()==1?"assets/images/2.png":
                                _currentValue.toInt()==2?"assets/images/3.png":
                                _currentValue.toInt()==3?"assets/images/4.png":
                                _currentValue.toInt()==4?"assets/images/5.png":
                                "assets/images/5.png"

                            ),fit: BoxFit.cover),*/
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Image${index + 1} à mettre',
                              style: const TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            h(30),
            TextComponent(text:
            _currentValue.toInt()==0?'Masse Grasse (10%-15%)':
            _currentValue.toInt()==1?'Masse Grasse (16%-21%)':
            _currentValue.toInt()==2?'Masse Grasse (22%-27%)':
            _currentValue.toInt()==3?'Masse Grasse (28%-35%)':
            _currentValue.toInt()==4?'Masse Grasse (36%-45%)':
            'Masse Grasse (>45%)',
              fontWeight: FontWeight.bold,
              size: 17,

            ),
            SizedBox(
              height: 60, // Hauteur augmentée du Slider
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 8.0, // Hauteur de la piste
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15), // Taille du pouce
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
            h(50),
            InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const I6(),));
                },
                child: ButtonComponent(label: "Suivant",size: 17,)),
          ],
        ),
      )
    );
  }
}