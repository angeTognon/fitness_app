import 'package:flutter/material.dart';
import 'package:fitness_app/modules/details/details_seances2.dart';
import 'package:fitness_app/utils/constants.dart';
import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import 'dart:async';

class DetailsSeances extends StatefulWidget {
  final String producName;
  final String path;

  DetailsSeances({super.key, required this.producName, required this.path});

  @override
  State<DetailsSeances> createState() => _DetailsSeancesState();
}

class _DetailsSeancesState extends State<DetailsSeances> {
  int currentExerciseIndex = 0;
  Duration? timerDuration;
  Timer? timer;

  // Liste des exercices avec vidéo et durée
  final List<Map<String, dynamic>> exercises = [
    {
      'title': 'Exercice 1',
      'videoUrl': 'https://www.youtube.com/embed/rj0H1xqFtqc',
      'duration': Duration(seconds: 30),
    },
    {
      'title': 'Exercice 2',
      'videoUrl': 'https://www.youtube.com/embed/rj0H1xqFtqc',
      'duration': Duration(seconds: 45),
    },
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timerDuration = exercises[currentExerciseIndex]['duration'];
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (timerDuration!.inSeconds > 0) {
        setState(() {
          timerDuration = Duration(seconds: timerDuration!.inSeconds - 1);
        });
      } else {
        t.cancel();
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Exercice terminé!')));
      }
    });
  }

  void _nextExercise() {
    if (currentExerciseIndex < exercises.length - 1) {
      setState(() {
        currentExerciseIndex++;
        timer?.cancel();
        startTimer(); // Restart timer for the next exercise
      });
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Séance terminée!')));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        centerTitle: true,
        title: const TextComponent(text: "Exercices Jour 1", color: Colors.white, size: 19, fontWeight: FontWeight.bold),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
        height: 50,
        width: 100,
        child: InkWell(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsSeances2(),));
          },
          child: ButtonComponent(label: "COMMENCER L'ENTRAINEMENT", color: Colors.green, fontWeight: FontWeight.bold,),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            Card(
              color: Colors.white,
              elevation: 5,
              child: Container(
                height: 70,width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(padding: EdgeInsets.all(6),child:
                  Row(
                    children: [
                      Container(
                        height: 70,width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red.shade200,width: 3)
                        ),
                        child: Center(
                          child: TextComponent(text: "0%",fontWeight: FontWeight.bold,color: Colors.red,size: 15,),
                        ),
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextComponent(text: "1er jour d'entraînement",fontWeight: FontWeight.w200,),
                              w(70),
                              TextComponent(text: "5min",fontWeight: FontWeight.w200,),
                            ],
                          ),
                          TextComponent(text: "Poitrine+triceps",fontWeight: FontWeight.bold,size: 16,),
                        ],
                      ),
                    ],
                  ),),
              ),
            ),
        h(5),
        Container(
          height: 450,
          child: ListView(
            children: [
              ListTile(
                leading: Container(
                  height: 80,width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: AssetImage("assets/images/520.jpg"), fit: BoxFit.cover)
                  ),
                ),
                title: TextComponent(text: "Tapis de course",size: 15,fontWeight: FontWeight.bold,),
                subtitle: TextComponent(text: '3 × 20',size: 15,),
                trailing: IntrinsicWidth(
                  child: Icon(Icons.arrow_forward_ios,color: mainColor,),
                ),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsSeances2(),));
                },
              ),
              h(15),
              ListTile(
                leading: Container(
                  height: 80,width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: AssetImage("assets/images/2497.jpg"), fit: BoxFit.cover)
                  ),
                ),
                title: TextComponent(text: "Pompe à genoux",size: 15,fontWeight: FontWeight.bold,),
                // subtitle: Text('3 ×  20'),
                subtitle: TextComponent(text: '3 × 20',size: 15,),
                trailing: IntrinsicWidth(
                  child: Icon(Icons.arrow_forward_ios,color: mainColor,),
                ),
                onTap: () {
                  // Action when tapped
                  print('Home tapped');
                },
              ),
              h(15),
              ListTile(
                leading: Container(
                  height: 80,width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: AssetImage("assets/images/3928.jpg"), fit: BoxFit.cover)
                  ),
                ),
                title: TextComponent(text: "Relevé de buste",size: 15,fontWeight: FontWeight.bold,),
                // subtitle: Text('3 * 20'),
                subtitle: TextComponent(text: '3 × 20',size: 15,),
                trailing: IntrinsicWidth(
                  child: Icon(Icons.arrow_forward_ios,color: mainColor,),
                ),
                onTap: () {
                  // Action when tapped
                  print('Home tapped');
                },
              ),
              h(15),
              ListTile(
                leading: Container(
                  height: 80,width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: AssetImage("assets/images/4306.jpg"), fit: BoxFit.cover)
                  ),
                ),
                title: TextComponent(text: "Saut à la corde à une jambe",size: 15,fontWeight: FontWeight.bold,),
                // subtitle: Text('3 * 20'),
                subtitle: TextComponent(text: '3 × 20',size: 15,),
                trailing: IntrinsicWidth(
                  child: Icon(Icons.arrow_forward_ios,color: mainColor,),
                ),
                onTap: () {
                  // Action when tapped
                  print('Home tapped');
                },
              ),

              ListTile(
                leading: Container(
                  height: 80,width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: AssetImage("assets/images/dos.jpg"), fit: BoxFit.cover)
                  ),
                ),
                title: TextComponent(text: "Saut à la corde à une jambe",size: 15,fontWeight: FontWeight.bold,),
                // subtitle: Text('3 * 20'),
                subtitle: TextComponent(text: '3 × 20',size: 15,),
                trailing: IntrinsicWidth(
                  child: Icon(Icons.arrow_forward_ios,color: mainColor,),
                ),
                onTap: () {
                },
              ),



            ],
          ),
        ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
              height: 50,
              child: InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsSeances2(),));
                },
                child: ButtonComponent(label: "Télécharger toutes les vidéos", color: Colors.orange, fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}