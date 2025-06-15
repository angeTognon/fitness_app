import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fitness_app/app/components/bouton_components.dart';
import 'package:fitness_app/modules/monCompte/controller/controller.dart';
import 'package:fitness_app/modules/stockageSeancePersoList/stockage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/components/text_components.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../ServiceSupport/serviceSupport.dart';
import '../cgu/cgu.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
 /* late bool _isDarkMode = themeMode.value == ThemeMode.dark;
  bool notification = false;
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(child: TextComponent(text: "Paramètres", fontWeight: FontWeight.bold, size: 15)),
            h(15),
            Card(color: Colors.white,
              child: Container(
                child: Column(
                  children: [
                    /*InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const CGU(),));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person,color: mainColor,size: 35,),w(10),
                                const TextComponent(text: "Mon Profil",fontWeight: FontWeight.w700,size: 15,),
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios,color: mainColor,)
                          ],
                        )),
                      ),
                    ),*/
                    h(5),
                    InkWell(
                      onTap: () {
                        launchUrl(Uri.parse("https://wa.me/+2250768467786"));
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const ServiceSupport(),));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.support_agent,color: mainColor,size: 35,),w(10),
                                const TextComponent(text: "Service Support",fontWeight: FontWeight.w700,size: 13,),
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios,color: mainColor,)
                          ],
                        )),
                      ),
                    ),Divider(),
                   eya? InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Confirmation"),
                            content:  TextComponent(textAlign: TextAlign.justify,text: "Êtes-vous sûr de vouloir réinitialiser vos séances à zéro ? Toute vos progressions seront perdus et vous devriez reprendre jusqu'au jour 0"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Fermer le dialogue
                                },
                                child: const Text("Annuler"),
                              ),
                              TextButton(
                                onPressed: () {
                                  clearProgramAndDates();
                                  showToast(context, "Reinitialisation Terminé", Colors.green);
                                  // Ajoutez ici la logique pour réinitialiser les séances
                                  Navigator.of(context).pop(); // Fermer le dialogue
                                },
                                child: const Text("Confirmer"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.details, color: mainColor, size: 35),
                                  const SizedBox(width: 10),
                                  const TextComponent(
                                    text: "Réinitialiser mes progressions à zéro",
                                    fontWeight: FontWeight.w700,
                                    size: 13,
                                  ),
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios, color: mainColor),
                            ],
                          ),
                        ),
                      ),
                    ) : SizedBox(),Divider(),
                    
                    /*InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CGU(),));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.app_registration,color: mainColor,size: 35,),w(10),
                                Container(
                                    width: 270,
                                    child: const TextComponent(text: "Version Test disponible 5 jours et\ninvitation a réabonnement",fontWeight: FontWeight.w700,size: 15,overflow: TextOverflow.ellipsis,maxLine: 2,)),
                              ],
                            ),
                          ],
                        )),
                      ),
                    ),const Divider(),*/
                    /*Container(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.language,color: mainColor,size: 35,),w(10),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h(5),
                                  const TextComponent(text: "Langue",fontWeight: FontWeight.w700,size: 16,),
                                  h(5),
                                  const TextComponent(text: "Français",fontWeight: FontWeight.w700,color: Colors.black54,),
                                ],
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios,color: mainColor,)
                        ],
                      )),
                    ),
                    const Divider(),*/
                    Container(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.document_scanner,color: mainColor,size: 35,),w(10),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h(5),
                                  const TextComponent(text: "Version de l'application",fontWeight: FontWeight.w700,size: 14,),
                                  h(5),
                                  const TextComponent(text: "v : 1.0.365",fontWeight: FontWeight.w700,color: Colors.black54,),
                                  // const TextComponent(text: "Version Test disponible pendant 5 jours\net invitation a réabonnement",fontWeight: FontWeight.w700,color: Colors.black54,),
                                ],
                              ),
                            ],
                          ),
                          // const Icon(Icons.arrow_forward_ios,color: mainColor,)
                        ],
                      )),
                    ),
                    h(15),
                  ],
                ),
              ),
            ),
            h(5),
            // Card(
            //   child: Container(
            //     padding: EdgeInsets.all(15),
            //     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SwitchListTile(
            //           title: TextComponent(text:'Notification',size: 16,fontWeight: FontWeight.bold,),
            //           value: notification,
            //           onChanged: (value) {
            //             setState(() {
            //               notification = value;
            //             });
            //           },
            //         ),
            //         TextComponent(text: "En désactivant cette option, nous ne recevrez pas de notification",fontWeight: FontWeight.w700,color: Colors.black38,)
            //       ],
            //     ),
            //   ),
            // ),
            h(5),
           /* eya?Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.security,color: mainColor,size: 35,),w(10),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextComponent(text: "Changer le mot de passe",fontWeight: FontWeight.w700,),
                              ],
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,color: mainColor,)
                      ],
                    ),
                    h(5),
                    Divider(),
                    h(5),
                    InkWell(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        eya = false;
                        prefs.setBool('isConnected', eya);

                        user_email = "";

                        final userPref = await SharedPreferences.getInstance();

                        userPref.setString('email', "");

                        Phoenix.rebirth(context);
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.logout,color: Colors.red,size: 35,),w(10),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextComponent(text: "Deconnexion",fontWeight: FontWeight.w700,),
                                ],
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,async color: mainColor,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ) :w(0)
         */ 
          eya?InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                eya = false;
                prefs.setBool('isConnected', eya);

                user_email = "";

                final userPref = await SharedPreferences.getInstance();

                userPref.setString('email', "");

                Phoenix.rebirth(context);
              },
              child: ButtonComponent(label: "Déconnexion", color: Colors.red.shade400,)) : SizedBox()
          ],
        ),
      ),
    );
  }
  List<List<Map<String, double>>> _program = [];
  List<DateTime> datesAssociees = [];
  int _currentDayIndex = -1; // Current day index in the program
  List<bool> _daysCompleted = []; // Track completed days

  Future<void> clearProgramAndDates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('threeMonthsProgram');
    await prefs.remove('programDates');
    await prefs.remove('daysCompleted');
    await prefs.remove('programGenerationDate');

    await prefs.remove('completedExercises_cardio');
    await prefs.remove('completedExercises_powerband');
    await prefs.remove('completedExercises_powerfit');
    await prefs.remove('completedExercises_stepper');

    await prefs.remove('completedSessions_pgdouleur_cardio');
    await prefs.remove('completedSessions_pgpertepoids_cardio');
    await prefs.remove('completedSessions_pgrenforcementmusculaire_cardio');
    await prefs.remove('completedSessions_pgbbl_powerband');
    await prefs.remove('completedSessions_pg_express_powerband');

    await prefs.remove('completedSessions_pgmix_powerband');
    await prefs.remove('completedSessions_pgpower_powerband');
    await prefs.remove('completedSessions_pgbbl_powerfit');
    await prefs.remove('completedSessions_pgpower_powerfit');

    await prefs.remove('completedSessions_pgpower_stepper');
    await prefs.remove('completedSessions_pgpower_stepper');

    // Réinitialiser les variables d' état
    setState(() {
      _program = [];
      datesAssociees = [];
      _currentDayIndex = -1;
      _daysCompleted = [];
    });
  }
}