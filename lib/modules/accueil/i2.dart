import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import 'i3.dart';

class I2 extends StatefulWidget {
  String motivation;
  String nom;
   I2({required this.motivation, required this.nom});

  @override
  State<I2> createState() => _I2State();
}

class _I2State extends State<I2> {
  bool _isFirstContainerActive = true;
  String sexe="masculin";

  void _toggleContainer() {
    setState(() {
      sexe="masculin";
      _isFirstContainerActive = !_isFirstContainerActive;
      print(sexe);

    });
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
            child: TextComponent(text: "Étapes 1 : Vos Objectfis",color: Colors.white,size: 15,fontWeight: FontWeight.bold,),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: const TextComponent(text: "Quel est votre sexe ?",fontWeight: FontWeight.bold,size: 15,)),
            h(40),
            Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: _toggleContainer,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: _isFirstContainerActive ? 150 : 100,
                          height: _isFirstContainerActive ? 270 : 150,
                          decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage("assets/images/m.jpg")
                                ,fit: BoxFit.cover),
                           // color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              if (_isFirstContainerActive)
                                const BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 7,
                                  offset: Offset(0, 5),
                                ),
                            ],
                          ),
                        ),
                      ),
                      h(20),
                      TextComponent(text: "Homme",size:14
                          ,fontWeight: FontWeight.bold,)
                    ],
                  ),
                  const SizedBox(width: 20), // Espace entre les conteneurs
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sexe="feminin";
                            _isFirstContainerActive = false; // Réinitialiser si le deuxième est cliqué
                            print(sexe);
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: _isFirstContainerActive ? 100 : 150,
                          height: _isFirstContainerActive ? 150 : 270,
                          decoration: BoxDecoration(
                              image: const DecorationImage(image: AssetImage("assets/images/f.jpg")
                                  ,fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              if (!_isFirstContainerActive)
                                const BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 10,
                                  offset: Offset(0, 10),
                                ),
                            ],
                          ),
                        ),
                      ),
                      h(20),
                      TextComponent(text: "Femme",size:14
                        ,fontWeight: FontWeight.bold,)
                    ],
                  ),
                ],
              ),
            ),
            h(40),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  I3(
                    nom: widget.nom,
                    motivation: widget.motivation,
                    sexe: sexe,
                  ),));
                },
                child: ButtonComponent(label: "Suivant",size: 14,))
          ],
        ),
      ),
    );
  }
  Box(String txt, Icon icon){
    return InkWell(
      onTap: () {

      },
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15)
          ),
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
             icon,
              w(10),
              Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(text: txt,size: 16,),
                    const InkWell(
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xFFE3E3E3),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
