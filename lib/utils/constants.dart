import 'package:flutter/material.dart';

import '../app/components/text_components.dart';
import 'colors.dart';

h(double h){
  return SizedBox(
    height: h,
  );
}
w(double w){
  return SizedBox(
    width: w,
  );
}
x(){
  return const Expanded(child: SizedBox());
}


Erreur(){
  return Center(
    child: Container(
      height: 100,
      child: Column(
        children: [
          Icon(Icons.error,size: 45,color: main2,),
          h(10),
          TextComponent(
            text:  "Erreur de chargement\nVeuillez vérifier votre connexion internet",textAlign: TextAlign.center,),
        ],
      ),
    ),
  );
}

Vide(){
  return Column(
    children: [
      h(20),
      Icon(
        Icons.error,
        size: 100,
        color: main2,
      ),
      h(20),
      Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Text(
          "Oups, Aucune donnée pour l'instant ",
          style: TextStyle(fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}