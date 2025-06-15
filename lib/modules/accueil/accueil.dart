import 'package:flutter/material.dart';
import 'package:fitness_app/modules/monCompte/controller/controller.dart';

import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'i2.dart';

class Accueil extends StatefulWidget {
  String nom;
  Accueil({required this.nom});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  bool b1=false;
  bool b2=false;
  bool b3=false;
  bool b4=false;
  bool b5=false;

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
          children: [
            Center(child: const TextComponent(text: "Qu'est-ce qui vous motive\nle plus ?",fontWeight: FontWeight.bold,size: 14,textAlign: TextAlign.center,)),
            h(20),
            InkWell(
              onTap: () {
                setState(() {
                  b1=true;
                  b2=b3=b4=b5=false;
                });
                },
              child:  Card(
                color: b1? mainColor:null,
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Icon(Icons.star,size: 30,color: b1?Colors.white:Colors.black),
                      w(10),
                      Expanded(
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextComponent(text: "Gagner en Confiance",size: 14,color: b1? Colors.white:null,fontWeight: b1? FontWeight.bold:null,),
                            InkWell(
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: b1?main2 : const Color(0xFFE3E3E3),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),h(15),
            InkWell(
                onTap: () {
                  setState(() {
                    b2=true;
                    b1=b3=b4=b5=false;
                  });
                },
                child:  Card(
                  color: b2? mainColor:null,
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          height: 30,width: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(b2?  "assets/images/b2_white.png":  "assets/images/b2_black.png"),fit: BoxFit.cover)
                          ),
                        ),
                        w(10),
                        Expanded(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextComponent(text: "Avoir Un Meilleur Physique",size: 14,color: b2? Colors.white:null,fontWeight: b2? FontWeight.bold:null,),
                              InkWell(
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: b2?main2 : const Color(0xFFE3E3E3),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),h(15),
            InkWell(
                onTap: () {
                  setState(() {
                    b3=true;
                    b1=b2=b4=b5=false;
                  });
                },
                child:  Card(
                  color: b3? mainColor:null,
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          height: 30,width: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(b3?  "assets/images/b3_white.png":  "assets/images/b3_black.png"),fit: BoxFit.cover)
                          ),
                        ), w(10),
                        Expanded(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextComponent(text: "Se Modeler",size: 14,color: b3? Colors.white:null,fontWeight: b3? FontWeight.bold:null,),
                              InkWell(
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: b3?main2 : const Color(0xFFE3E3E3),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),h(15),
            InkWell(
                onTap: () {
                  setState(() {
                    b4=true;
                    b1=b2=b3=b5=false;
                  });
                },
                child:  Card(
                  color: b4? mainColor:null,
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          height: 30,width: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(b4?  "assets/images/b4_white.png":  "assets/images/b4_black.png"),fit: BoxFit.cover)
                          ),
                        ), w(10),
                        Expanded(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextComponent(text: "Améliorer Ma Santé",size: 14,color: b4? Colors.white:null,fontWeight: b4? FontWeight.bold:null,),
                              InkWell(
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: b4?main2 : const Color(0xFFE3E3E3),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),h(15),
            InkWell(
                onTap: () {
                  setState(() {
                    b5=true;
                    b1=b2=b3=b4=false;
                  });
                },
                child:  Card(
                  color: b5? mainColor:null,
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          height: 30,width: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(b5?  "assets/images/b5_white.png":  "assets/images/b5_black.png"),fit: BoxFit.cover)
                          ),
                        ),   w(10),
                        Expanded(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextComponent(text: "Évacuer Mon Stress",size: 14,color: b5? Colors.white:null,fontWeight: b5? FontWeight.bold:null,),
                              InkWell(
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: b5?main2 : const Color(0xFFE3E3E3),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),h(30),

            InkWell(
                onTap: () {
                  if(b1==false && b2==false && b3==false && b4==false && b5==false){
                    showToast(context, "Veuillez choisir au moins un élément", Colors.red);
                  }
                  else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => I2(
                      nom: widget.nom,
                        motivation:
                        b1?"Gagner en Confiance":
                        b2?"Avoir Un Meilleur Physique":
                        b3?"Se Modeler":
                        b4? "Améliorer Ma Santé":
                        "Évacuer Mon Stress"
                    ),));
                  }

                },
                child: ButtonComponent(size: 14,label: "Suivant"))
          ],
        ),
      ),
    );
  }
  Box(String txt, Icon icon){
    return Card(
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
    );
  }
}
