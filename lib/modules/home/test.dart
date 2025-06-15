
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fitness_app/main.dart';
import 'package:fitness_app/modules/monCompte/connexion.dart';
import 'package:fitness_app/modules/monCompte/controller/controller.dart';

import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../app/components/text_form_component.dart';
import '../../modules/details/details.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:http/http.dart' as http;

import '../accueil/accueil.dart';
import '../seance_libre.dart';


class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  TextEditingController codEquipement = TextEditingController();
  getUserData() async {
    var url =
        "https://zoutechhub.com/pharmaRh/fitness_app/getUserData.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  bool show = false;

  update(String id,idApp) async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/fitness_app/updateCode.php?id=$id&idApp=$idApp";
    var response = await http.post(Uri.parse(url));

    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      show = false;
      showToast(context, "Ajout Réussie.", Colors.green);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => Base(),
      //     ));
    } else {
      setState(() {
        show = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur : Il semble que cette adresse mail a déjà été utilisée ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: const TextComponent(text: "Mode d'utilisation de nos équipements",size: 14,color: Colors.black)),
            h(20),
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                runSpacing: 8.0,
                children: [
                  /*SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 25, // Ajustez la largeur pour deux éléments par ligne
                    child: NosEquipement("assets/images/MasterFit.webp", "MasterFit",),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 25,
                    child: NosEquipement("assets/images/ZR.jpg", "ZR - 800",),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 25,
                    child: NosEquipement("assets/images/Stepper.jpg", "Stepper",),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 25,
                    child: NosEquipement("assets/images/Pack.jpg", "Pack Start", ),
                  ),*/
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2),
                    child: NosEquipement("assets/images/cardio.jpg", "CardioQuad 23", ),
                  ),
                  /*SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 25,
                    child: NosEquipement("assets/images/power.png", "PowerBands",),
                  ),*/
                ],
              ),
            ),
          ]
      ),
      ),
    );
  }
  
  String deviceId = '';

  Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.id; // Utilisez 'id' pour obtenir l'ID de l'appareil

    return deviceId;
  }

  NosEquipement(String path, txt){
    return InkWell(
      onTap: () {
        if(txt != "CardioQuad 23"){
          showToast(context, "Équipement non disponible pour l'instant", Colors.red);
        }else {
          showModalBottomSheet(context: context, builder: (context) {
          return Container(
            height: 240,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            padding: EdgeInsets.only(top: 20,left: 5,right: 5),
            child: Column(
              spacing: 10,
              children: [
                Center(child: TextComponent(text: 'Menu fitness_app', fontWeight: FontWeight.bold,size: 14,)),
                Container(
                  height: 3,width: 100,
                  color: mainColor,
                ),
                h(20),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        isTrialActive?
                        Navigator.push(
                        context,
                       MaterialPageRoute(builder: (context) => Details(producName: txt, path: path))
                      ):
                        showToast(context, "Votre période d'essaie a expiré. Veuillez vous connecter à votre compte.", Colors.red);
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          height: 100,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(color: mainColor,width: 2.2),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: TextComponent(text: "Présentation de l'appareil",textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),InkWell(
                      onTap: () {
                        isTrialActive?

                        Navigator.push(context, MaterialPageRoute(builder: (context) => SeanceLibre(),)) :
                        showToast(context, "Votre période d'essaie a expiré. Veuillez vous connecter à votre compte.", Colors.red);
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5,right: 10,left: 10),
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: main2,width: 2.2),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: TextComponent(text: "Séance\nlibre",textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Connexion(),));
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          height: 100,
                          width: 113,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green,width: 2.2),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: TextComponent(text: "Séance Personnalisée",textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },);
        }
       /* showDialog(
          useSafeArea: true,
          context: context, builder: (context) {
          return AlertDialog(
            title: const TextComponent(text: "Veuillez saisir le code secret à 6 charactères de l'équipement",
              textAlign: TextAlign.center,size: 16, fontWeight: FontWeight.bold,
            color: mainColor,
            ),
            actions: [
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(child: InkWell(
                onTap: () {
          Navigator.pop(context);
          },
                        child: ButtonComponent(label: "Annuler",color: Colors.redAccent,))),
                    w(20), Expanded(child: InkWell(
                        onTap: () {
                          setState(() {
                            // Vérifie si le code entré par l'utilisateur est correct
                            if (codEquipement.text != code) {
                              showToast(context, "Mauvais code !", Colors.red);
                              getDeviceId();
                              print(deviceId);  // Affiche l'ID du dispositif pour débogage
                            } else {
                              // Si le code est correct, on vérifie si l'appareil est associé à l'utilisateur
                              if (idApp.isEmpty) {
                                // Si l'idApp est vide, cela signifie qu'il n'y a pas de lien avec un appareil précédent
                                getDeviceId(); // Récupère l'ID du dispositif actuel
                                update(id, deviceId); // Met à jour l'appareil avec l'ID actuel
                                Navigator.pop(context); // Ferme la fenêtre actuelle
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Details(producName: txt, path: path)),
                                ); // Navigue vers la page de détails
                              } else {
                                // Si l'idApp n'est pas vide, on vérifie si l'utilisateur tente d'utiliser un autre appareil
                                if (idApp != deviceId) {
                                  // Si l'ID de l'application ne correspond pas à l'ID de l'appareil actuel, affichage d'un message d'erreur
                                  showToast(
                                    context,
                                    "Vous ne pouvez pas utiliser ce code sur un autre appareil. Veuillez vous connecter sur votre téléphone principal !",
                                    Colors.red,
                                  );
                                } else {
                                  // Si l'ID de l'appareil correspond à l'ID de l'application, on autorise l'accès aux détails
                                  Navigator.pop(context); // Ferme la fenêtre actuelle
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Details(producName: txt, path: path)),
                                  ); // Navigue vers la page de détails
                                }
                              }
                            }
                          });

                        },
                        child: ButtonComponent(label: "Valider",color: mainColor,))),
                  ],
                ),
              ),
            ],
            content: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
              ),
              height: 150,width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    child: TextFormComponent(controller: codEquipement,
                    hintText: "Cliquez ici pour saisir le code",),
                  )
                ],
              ),
            ),
          );
        },);
        */// Navigator.push(context, MaterialPageRoute(builder: (context) => const CodeEquipement(),));
      },
      child: Column(
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image:  DecorationImage(
                      colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken),
                      image: AssetImage(path),fit: BoxFit.cover)
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: const TextComponent(text: "Consulter",color: Colors.white,size: 12,),
                  ),
                  Expanded(child: h(0),),

                ],
              ),
            ),
          ),
          h(5),
          TextComponent(text: txt,size: 13,fontWeight: FontWeight.bold,textAlign: TextAlign.start,),
        ],
      ),
    );
  }
}

