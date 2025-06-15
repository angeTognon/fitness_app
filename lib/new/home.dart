import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitness_app/new/presentation/presentationPowerfit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fitness_app/app/components/bouton_components.dart';
import 'package:fitness_app/app/components/text_components.dart';
import 'package:fitness_app/main.dart';
import 'package:fitness_app/modules/details/details.dart';
import 'package:fitness_app/modules/monCompte/connexion.dart';
import 'package:fitness_app/new/BibliothequeDexercice/bibliothequeCardioQuad.dart';
import 'package:fitness_app/new/BibliothequeDexercice/bibliothequePowerFit.dart';
import 'package:fitness_app/new/presentation/presentationPowerBand.dart';
import 'package:fitness_app/new/presentation/presentationStepper.dart';
import 'package:fitness_app/new/programmeCardio/programme.dart';
// import 'package:fitness_app/new/programme/programme.dart';
import 'package:fitness_app/new/programmePowerBand/programme.dart';
import 'package:fitness_app/new/programmePowerFit/programme.dart';
import 'package:fitness_app/new/programmeStepper/programme.dart';
import 'package:fitness_app/new/quizSeancePerso/powerbands.dart';
import 'package:fitness_app/new/quizSeancePerso/powerfit.dart';
import 'package:fitness_app/new/quizSeancePerso/stepper.dart';
import 'package:fitness_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modules/accueil/accueil.dart';
import 'BibliothequeDexercice/bibliothequePowerBands.dart';
import 'BibliothequeDexercice/bibliothequeStepper.dart';

class HomeH extends StatefulWidget {
  const HomeH({super.key});

  @override
  State<HomeH> createState() => _HomeHState();
}

class _HomeHState extends State<HomeH> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // padding: EdgeInsets.all(14),
        child: Column(
          spacing: 15,
          children: [
            Container(
              height: 220,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 170,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft, // Début du dégradé
                        end: Alignment.bottomRight, // Fin du dégradé
                        colors: [
                          Color(0xFF333333), // Couleur initiale
                          Color(0xFF0A0D15), // Couleur intermédiaire
                          Color(0xFF434040), // Couleur finale
                        ],
                        stops: [0.0, 0.8, 10],
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextComponent(
                              text: eya
                                  ? "Bienvenue, \n$userName"
                                  : "Bienvenue sur fitness_app",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              size: 16,
                            ),
                            eya
                                ? Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.notifications,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Container(
                                                height: 250,
                                                width: Screen.width(context),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  spacing: 20,
                                                  children: [
                                                    Center(
                                                        child: TextComponent(
                                                      text:
                                                          "Informations Utilisateurs",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      size: 14,
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                                    Row(
                                                      children: [
                                                        TextComponent(
                                                          text:
                                                              "Nom et Prénoms : ",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          size: 14,
                                                          textAlign:
                                                              TextAlign.center,
                                                          color: mainColor,
                                                        ),
                                                        TextComponent(
                                                          text: "$userName",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          size: 14,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        TextComponent(
                                                          text: "Email : ",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          size: 14,
                                                          textAlign:
                                                              TextAlign.center,
                                                          color: mainColor,
                                                        ),
                                                        TextComponent(
                                                          text: "$user_email",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          size: 14,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                        onTap: () async {
                                                          final prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          eya = false;
                                                          prefs.setBool(
                                                              'isConnected',
                                                              eya);

                                                          user_email = "";

                                                          final userPref =
                                                              await SharedPreferences
                                                                  .getInstance();

                                                          userPref.setString(
                                                              'email', "");

                                                          Phoenix.rebirth(
                                                              context);
                                                        },
                                                        child: ButtonComponent(
                                                          label: "Déconnexion",
                                                          color: Colors
                                                              .red.shade400,
                                                        )),
                                                    InkWell(
                                                        onTap: () async {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: ButtonComponent(
                                                          label:
                                                              "Fermer la boîte",
                                                          color: mainColor,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                :
                            InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Connexion(),
                                          ));
                                    },
                                    child: Container(
                                      width: 100,
                                      child: ButtonComponent(
                                          label: "Se  Connecter"),
                                    ),
                                  )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 5,
                    right: 5,
                    bottom: 0,
                    child: CarouselSlider(
                      items: [
                        // Premier slide (votre contenu actuel)
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15,),
                                  TextComponent(text: '30% de réduction\nsur cet article',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    size: 16,

                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      launchUrl(Uri.parse(
                                          "https://wa.me/+2250768467786"));
                                    },
                                    child: Text('Achetez ici !'),
                                  ),
                                ],
                              ),
                              Container(
                                height: 120,width: 120,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("assets/images/ii.png"),fit: BoxFit.cover)
                                ),
                              )
                            ],
                          ),
                        ),

                        // Deuxième slide (exemple)
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                mainColor, // Autre couleur pour différencier
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15,),
                                  TextComponent(text: 'Nouvelle offre!\nPromotion spéciale',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    size: 16,

                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Autre action
                                    },
                                    child: Text('Découvrir'),
                                  ),
                                ],
                              ),
                              Container(
                                height: 120,width: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage("assets/images/stepper_removed.png"),fit: BoxFit.cover)
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                mainColor, // Autre couleur pour différencier
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15,),
                                  TextComponent(text: 'Nouvelle offre!\nPromotion spéciale',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    size: 16,

                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Autre action
                                    },
                                    child: Text('Découvrir'),
                                  ),
                                ],
                              ),
                              Container(
                                height: 120,width: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage("assets/images/stepper_removed2.png"),fit: BoxFit.cover)
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 150, // Ajustez selon vos besoins
                        autoPlay: true, // Défilement automatique
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        autoPlayInterval: Duration(seconds: 8),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Column(
                spacing: 15,
                children: [
                  Column(
                    spacing: 5,
                    children: [
                      Center(
                          child: TextComponent(
                        text: "Le PowerBands",
                        fontWeight: FontWeight.bold,
                        size: 14,
                      )),
                      OwnDivider(),
                    ],
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 10,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PresentationPowerBand(
                                                producName: "Le PowerBands",
                                                path: "power1.png")));
                              },
                              child: BoxProduitG("power1.png", "Détail du Produit",
                                  "Le PowerBands")),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BibliothequePowerBands(
                                              isFromAccueil: true,
                                            )));
                              },
                              child: BoxProduitD(
                                  "power2.png",
                                  "Exercices avec le PowerBands",
                                  "Le PowerBands")),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Programme(
                                              isLocked: true,
                                            )));
                              },
                              child: BoxProduitG("power3.png",
                                  "Programme d'entrainement", "Le PowerBands")),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PowerbandsForm()));
                              },
                              child: BoxProduitD("power4.png",
                                  "Séance Personnalisée", "Le PowerBands")),
                        ],
                      )),
                  Column(
                    spacing: 5,
                    children: [
                      Center(
                          child: TextComponent(
                        text: "Le PowerFit",
                        fontWeight: FontWeight.bold,
                        size: 14,
                      )),
                      OwnDivider(),
                    ],
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 10,
                        children: [
                          InkWell(
                            onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PresentationPowerfit(
                                                producName: "Le PowerFit",
                                                path: "newPowerbands.jpg")));
                              },
                            child: BoxProduitG(
                                "newPowerbands.jpg", "Détail du Produit", "Le PowerFit"),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BibliothequePowerFit(
                                              isFromAccueil: true,
                                            )));
                              },
                              child: BoxProduitD("powerfit2.png",
                                  "Exercices avec le PowerFit", "Le PowerFit")),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProgrammePowerFit(
                                              isLocked: true,
                                            )));
                              },
                              child: BoxProduitG("powerfit3.png",
                                  "Programme d'entrainement", "Le PowerFit")),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PowerFitForm()));
                              },
                              child: BoxProduitD("powerfit4.png",
                                  "Séance Personnalisée", "Le PowerFit")),
                        ],
                      )),
                  Column(
                    spacing: 5,
                    children: [
                      Center(
                          child: TextComponent(
                        text: "Le QuardioQuad",
                        fontWeight: FontWeight.bold,
                        size: 14,
                      )),
                      OwnDivider(),
                    ],
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 10,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Details(
                                            producName: "Cardio Quard",
                                            path: "stepper1.png")));
                              },
                              child: BoxProduitG("quardio1.png", "Détail du Produit",
                                  "Le QuardioQuad")),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BibliothequeCardioQuad(
                                              isFromAccueil: true,
                                            )));
                              },
                              child: BoxProduitD(
                                  "quardio2.png",
                                  "Exercices avec le QuardioQuad",
                                  "Le QuardioQuad")),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProgrammeCardio(
                                              isFromAccueil: true,
                                            )));
                              },
                              child: BoxProduitG(
                                  "quardio3.png",
                                  "Programme d'entrainement",
                                  "Le QuardioQuad")),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Accueil(
                                              nom: 'Cardio Quad',
                                            )));
                              },
                              child: BoxProduitD("quardio4.png",
                                  "Séance Personnalisée", "Le QuardioQuad")),
                        ],
                      )),
                  Column(
                    spacing: 5,
                    children: [
                      Center(
                          child: TextComponent(
                        text: "Le Stepper",
                        fontWeight: FontWeight.bold,
                        size: 14,
                      )),
                      OwnDivider(),
                    ],
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 10,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PresentationStepper(
                                                producName: "Le Stepper",
                                                path: "stepper1.jpg")));
                              },
                              child: BoxProduitG("stepper1.jpg", "Détail du Produit",
                                  "Le Stepper")),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BibliothequeStepper(
                                              isFromAccueil: true,
                                            )));
                              },
                              child: BoxProduitD("stepper2.png",
                                  "Exercices avec le Stepper", "Le Stepper")),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProgrammeStepper(
                                              isLocked: true,
                                            )));
                              },
                              child: BoxProduitG("stepper3.png",
                                  "Programme d'entrainement", "Le Stepper")),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StepperForm()));
                              },
                              child: BoxProduitD("stepper4.png",
                                  "Séance Personnalisée", "Le Stepper")),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget OwnDivider() {
    return Container(
      height: 4,
      width: 50,
      color: Color(0xFF0186A4),
    );
  }

  Widget BoxProduitG(String path, titre, txt) {
    return Container(
      width: 150,
      height: 130,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/$path"),
          fit: BoxFit.cover,
          alignment: Alignment.topRight,
        ),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.3)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Container(
              width: 90,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
                image: DecorationImage(
                    image: AssetImage("assets/images/$path"),
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft),
              ),
            ),
          ),
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            width: titre=="Détail du Produit"?85 :120,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
            ),
          ),
          Container(
            width: titre=="Détail du Produit"?70 : 105,
            height: 180,
            padding: EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.black.withOpacity(0.8)],
                // colors: [Colors.black, Colors.black.withOpacity(0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
            ),
            child: Center(
              child: TextComponent(
                text: titre,
                color: Colors.white,
                textAlign: TextAlign.start,
                size: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Positioned(
            bottom: 5,
            right: 5,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget BoxProduitD(String path, titre, txt) {
    return Container(
      width: 140,
      height: 130,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/$path"),
            fit: BoxFit.cover,
            alignment: Alignment.bottomRight),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.3)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 110,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(91),
                    topLeft: Radius.circular(91),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 104,
              padding: EdgeInsets.only(right: 5),
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black.withOpacity(0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(91),
                    topLeft: Radius.circular(91),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Center(
                child: TextComponent(
                  text: titre,
                  color: Colors.white,
                  textAlign: TextAlign.end,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
