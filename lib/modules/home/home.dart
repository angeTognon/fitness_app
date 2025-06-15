
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fitness_app/main.dart';
import 'package:fitness_app/modules/monCompte/controller/controller.dart';
import 'package:fitness_app/new/dashboards/dashboard_cardio_quad.dart';
import 'package:fitness_app/new/dashboards/dashboard_powerband.dart';
import 'package:fitness_app/new/dashboards/dashboard_powerfit.dart';
import 'package:fitness_app/new/dashboards/dashboard_stepper.dart';
import 'package:fitness_app/new/quizSeancePerso/powerbands.dart';
import 'package:fitness_app/new/quizSeancePerso/powerfit.dart';
import 'package:fitness_app/new/quizSeancePerso/stepper.dart';

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
import '../monCompte/connexion.dart';
import '../seance_libre.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController codEquipement = TextEditingController();
  getUserData() async {
    var url =
        "https://zoutechhub.com/pharmaRh/fitness_app/getUserData.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    print(response.body);
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
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: const TextComponent(text: "Tableau de Bord",size: 14,fontWeight: FontWeight.bold,color: Colors.black,)),
          h(10),
          Center(child: const TextComponent(text: "Liste de vos équipements achetés",size: 14,color: Colors.black,)),
          h(20),
          Container(
            height: Screen.height(context),
            child: Center(
              child: FutureBuilder(
                future: getUserData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Erreur();
                  }

                  if (snapshot.hasData) {
                    if (snapshot.data.isEmpty) {
                      return Vide();
                    }

                    List<Widget> equipements = [];

                    final data = snapshot.data[0];

                    if (data['codePowerBand'].isNotEmpty) {
                      equipements.add(
                        NosEquipement("assets/images/newPowerFit.jpg", "PowerBands", data['codePowerBand'], data['id'], data['idApp']),
                      );
                    }

                    if (data['codeCardio'].isNotEmpty) {
                      equipements.add(
                        NosEquipement("assets/images/cardio.jpg", "CardioQuad 23", data['codeCardio'], data['id'], data['idApp']),
                      );
                    }

                    if (data['codeMasterFit'].isNotEmpty) {
                      equipements.add(
                        NosEquipement("assets/images/newPowerbands.jpg", "PowerFit", data['codeMasterFit'], data['id'], data['idApp']),
                      );
                    }

                    if (data['codeZr'].isNotEmpty) {
                      equipements.add(
                        NosEquipement("assets/images/ZR.jpg", "ZR - 800", data['codeZr'], data['id'], data['idApp']),
                      );
                    }

                    if (data['codeStepper'].isNotEmpty) {
                      equipements.add(
                        NosEquipement("assets/images/stepper1.jpg", "Stepper", data['codeStepper'], data['id'], data['idApp']),
                      );
                    }

                    if (data['codePackStart'].isNotEmpty) {
                      equipements.add(
                        NosEquipement("assets/images/Pack.jpg", "Pack Start", data['codePackStart'], data['id'], data['idApp']),
                      );
                    }

                    return GridView.count(
                      crossAxisCount: 2,         // 2 colonnes
                      padding: const EdgeInsets.all(8),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: equipements.map((e) => SizedBox(
                        width: (MediaQuery.of(context).size.width / 2) - 24,
                        child: e,
                      )).toList(),
                    );
                  }

                  return Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(color: main2),
                    ),
                  );
                },
              ),
            ),
          )

          /*h(20),
          const TextComponent(text: "Suivi de vos performances de cette semaine",size: 16,fontWeight: FontWeight.bold,color: mainColor),
          SizedBox(
            height: 300,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: DChartBarO (
                    areaColor: (group, ordinalData, index) {
                      if (ordinalData == 10) {
                        mainColor;
                      }
                      return null;
                    },
                    groupList: ordinalGroup,
                  ),
                ),
              ],
            )
          )*/
    ]
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

  Future<Map<String, dynamic>> getPowerBandData() async {
    try {
      var url = "https://zoutechhub.com/pharmaRh/fitness_app/getPowerBandData.php?email=$user_email";
      var response = await http.get(Uri.parse(url));

      print('PowerBand API Response: ${response.body}'); // Ajout pour débogage

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {"error": "Server error", "isConfigured": false};
      }
    } catch (e) {
      print('PowerBand API Error: $e'); // Ajout pour débogage
      return {"error": e.toString(), "isConfigured": false};
    }
  }
  Future<Map<String, dynamic>> getStepperData() async {
    try {
      var url = "https://zoutechhub.com/pharmaRh/fitness_app/getStepperData.php?email=$user_email";
      var response = await http.get(Uri.parse(url));

      print('PowerBand API Response: ${response.body}'); // Ajout pour débogage

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {"error": "Server error", "isConfigured": false};
      }
    } catch (e) {
      print('PowerBand API Error: $e'); // Ajout pour débogage
      return {"error": e.toString(), "isConfigured": false};
    }
  }Future<Map<String, dynamic>> getPowerFitData() async {
    try {
      var url = "https://zoutechhub.com/pharmaRh/fitness_app/getPowerFitData.php?email=$user_email";
      var response = await http.get(Uri.parse(url));

      print('PowerBand API Response: ${response.body}'); // Ajout pour débogage

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {"error": "Server error", "isConfigured": false};
      }
    } catch (e) {
      print('PowerBand API Error: $e'); // Ajout pour débogage
      return {"error": e.toString(), "isConfigured": false};
    }
  }

  NosEquipement(String path, txt, code, id, idApp) {
    // Détermine quelle méthode appeler en fonction de l'équipement
    Future<Map<String, dynamic>> getEquipmentData() {
      if (txt == "PowerBands") {
        return getPowerBandData();
      } else if (txt == "Stepper") {
        return getStepperData();
      }else if (txt == "PowerFit") {
        return getPowerFitData();
      }
      // Pour les autres équipements, retourne une Future vide
      return Future.value({"isConfigured": true});
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: getEquipmentData(), // Appel la méthode appropriée
      builder: (context, snapshot) {
        bool isConfigured = true; // Par défaut vrai pour les équipements sans configuration

        if (txt == "PowerBands" || txt == "Stepper" || txt=="PowerFit") {
          // Seulement vérifier la configuration pour PowerBands et Stepper
          if (snapshot.hasData && snapshot.data != null) {
            isConfigured = snapshot.data!['isConfigured'] ?? false;
          }
        }

        return InkWell(
          onTap: () {
            if (eya == false) {
              showToast(context, "Veuillez d'abord Vous connecter", Colors.red);
            } else {
              if (txt == "PowerBands") {
                if (!isConfigured) {
                  showToast(context, "Veuillez d'abord configurer votre programme PowerBands", Colors.red);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PowerbandsForm(),));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPowerband(isLocked: false,)));
                }
              } else if (txt == "Stepper") {
                if (!isConfigured) {
                  showToast(context, "Veuillez d'abord configurer votre programme Stepper", Colors.red);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StepperForm(),));
                } else {
                  // print("Stepper configuré, navigation vers StepperScreen");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardStepper()));
                  // showToast(context, "Configuration Stepper OK", Colors.green);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => StepperScreen()));
                }
              } else if (txt == "PowerFit") {
                if (!isConfigured) {
                  showToast(context, "Veuillez d'abord configurer votre programme PowerFit", Colors.red);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PowerFitForm(),));
                } else {
                  print("PowerFit configuré, navigation vers PowerFitScreen");
                  // showToast(context, "Configuration PowerFit OK", Colors.green);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPowerfit()));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => PowerFitScreen()));
                }
              } else if (txt == "CardioQuad 23") {
                print("Navigation vers DashboardCardioQuad");
                Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardCardioQuad()));
              } else {
                print("Équipement non reconnu: $txt");
              }
            }
          },
          child: Container(
            child: Stack(

              children: [
                Column(
                  children: [
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 138,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            // colorFilter: const ColorFilter.mode(Colors.black45, BlendMode.luminosity),
                            image: AssetImage(path),
                            fit: BoxFit.cover,
                          ),
                        ),

                      ),
                    ),
                  ],
                ),

                Container(
                  height: 305,width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black54
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: mainColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextComponent(
                        text: txt,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        size: 13.5,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );

      },
    );
  }
}

