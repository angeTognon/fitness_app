import '../../app/components/bouton_components.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../app/components/text_components.dart';
import '../../utils/colors.dart';

class DetailsProduits extends StatefulWidget {
  String producName;
  String path;
  DetailsProduits({super.key, required this.producName,required this.path});

  @override
  State<DetailsProduits> createState() => _DetailsProduitsState();
}

class _DetailsProduitsState extends State<DetailsProduits> {

  final String videoUrl="https://www.youtube.com/watch?v=";
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'Zsd4EcPqzZI', // Replace with your video ID
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  bool b1=false;
  bool b2=false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: mainColor,
        title: const TextComponent(text: "fitness_app",color: Colors.white,size: 16,fontWeight: FontWeight.bold,),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
             padding: const EdgeInsets.all(20),
             height: 200,
             width: MediaQuery.of(context).size.width,
             decoration:  BoxDecoration(
               image: DecorationImage(
                   // colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                   image: AssetImage(widget.path),fit: BoxFit.cover)
             ),
           ),
        Container(
          margin: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //         height: 40,width: 40,
              //         decoration: BoxDecoration(
              //             color: mainColor,
              //             borderRadius: BorderRadius.circular(10)
              //         ),
              //         child: const Center(child: Icon(Icons.arrow_back_ios,color: Colors.white,))),
              //     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         const CircleAvatar(radius: 10,backgroundColor: main2,),w(15),
              //         const CircleAvatar(radius: 10,backgroundColor: Colors.grey,),w(15),
              //         const CircleAvatar(radius: 10,backgroundColor: Colors.grey,),w(15),
              //         const CircleAvatar(radius: 10,backgroundColor: Colors.grey,),
              //       ],
              //     ),
              //     Container(
              //         height: 40,width: 40,
              //         decoration: BoxDecoration(
              //             color: mainColor,
              //             borderRadius: BorderRadius.circular(10)
              //         ),
              //         child: const Center(child: Icon(Icons.arrow_forward_ios,color: Colors.white,)))
              //   ],
              // ),
              h(20),
              Center(
                child: TextComponent(text: "${widget.producName} - Description | Avantages",size: 15,
                  fontWeight: FontWeight.bold,textAlign: TextAlign.center,),
              ),
              h(20),
              TextComponent(
                  size: 14,
                  text:
                  //stepper :
                  widget.producName=="Stepper"? "Le mini-stepper est un appareil de fitness compact et efficace, parfait pour un entraînement cardio à domicile. Conçu pour tonifier les muscles des jambes, des cuisses et des fessiers, il permet de réaliser des exercices de montée de marches tout en stimulant l'endurance cardiovasculaire. Son mouvement répétitif active les muscles du bas du corps tout en offrant une solution simple pour brûler des calories et améliorer la forme physique générale.":
                  widget.producName=="MasterFit"? "Ce banc d'entraînement multifonction est un équipement polyvalent qui se distingue par ses nombreux avantages. Conçu pour répondre aux besoins des utilisateurs de tous niveaux, il permet de travailler efficacement différents groupes musculaires, notamment les abdominaux, les bras, les jambes et même le dos. Grâce à ses réglages ajustables, il s’adapte à différentes morphologies et intensités d’entraînement, offrant une expérience personnalisée et confortable.":
                  widget.producName=="ZR - 800"? "Le vélo d'appartement pliable avec dossier est un équipement de fitness parfaitement adapté pour un entraînement cardio complet et confortable. Grâce à son siège ergonomique rembourré et son support dorsal, il assure une posture correcte et un confort optimal, même lors de longues séances d'exercice. Cette conception le rend particulièrement adapté aux personnes souhaitant protéger leur dos ou rechercher une alternative plus confortable par rapport aux vélos classiques.":
                  widget.producName=="fitness_app Pack Start"? "Le kit de bandes de résistance avec barre est un outil d'entraînement extrêmement polyvalent, adapté à tous les SeancePerso de fitness. Il permet de travailler l'ensemble des groupes musculaires, que ce soit pour renforcer la force, améliorer la mobilité, effectuer des exercices de rééducation ou simplement maintenir une bonne condition physique. Grâce à ses bandes de résistances variées (différents niveaux de tension), il convient aussi bien aux débutants qu'aux athlètes expérimentés, offrant une progression graduelle et personnalisée.":
                  "Cet appareil de fitness multifonction est conçu pour offrir un entraînement complet à domicile, en ciblant efficacement plusieurs groupes musculaires. Il permet de renforcer les abdominaux, les bras, les jambes et même d’améliorer la souplesse et l'endurance. Grâce à sa conception polyvalente, il propose une gamme variée d'exercices, tels que le pédalage, les crunchs, ainsi que des étirements pour travailler l'ensemble du corps."
              ),
              h(10),
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse("https://wa.me/+2250768467786"));
                },
                child: ButtonComponent(label: "Acheter",
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),

          ],
        ),
      ),
    );
  }
}
