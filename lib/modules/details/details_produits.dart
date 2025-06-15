import '../../modules/accueil/accueil.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../app/components/text_components.dart';
import '../../utils/colors.dart';

class Details extends StatefulWidget {
  String producName;
  String path;
  Details({super.key, required this.producName,required this.path});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

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
        backgroundColor: mainColor,
        title: const TextComponent(text: "fitness_app",color: Colors.white,size: 19,fontWeight: FontWeight.bold,),
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //      Container(
      //        height: 250,
      //        width: MediaQuery.of(context).size.width,
      //        decoration:  BoxDecoration(
      //          image: DecorationImage(
      //              colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.darken),
      //              image: AssetImage(widget.path),fit: BoxFit.cover)
      //        ),
      //        child:  Center(
      //          child: Container(
      //            padding: const EdgeInsets.all(15),
      //            decoration: BoxDecoration(
      //              color: mainColor,
      //              borderRadius: BorderRadius.circular(10)
      //            ),
      //            child: TextComponent(text: widget.producName,color: Colors.white,size: 16,
      //            fontWeight: FontWeight.bold,),
      //          ),
      //        ),
      //      ),
      //       Container(
      //         padding: const EdgeInsets.all(5),
      //         height: 50,
      //         width: MediaQuery.of(context) .size.width,
      //         color: const Color(0xFF1d1d1d),
      //         child: const Center(child: TextComponent(text: " Description des Avantages de l'équipement",color: Colors.white,size: 15,)),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.all(20),
      //         child: TextComponent(
      //             size: 15,
      //             text:
      //             //stepper :
      //         widget.producName=="Stepper"? "Ce mini-stepper est idéal pour un entraînement cardio à domicile. Compact et facile à ranger, il permet de tonifier les muscles des jambes, des cuisses et des fessiers tout en améliorant l'endurance. Grâce aux élastiques intégrés, il offre également un renforcement du haut du corps, rendant l'exercice complet. Parfait pour brûler des calories et renforcer la condition physique, même dans un espace limité.":
      //         widget.producName=="MasterFit"? "Ce banc d'entraînement multifonction offre plusieurs avantages : il permet de travailler différents groupes musculaires (abdominaux, bras, jambes), économise de l'espace grâce à son design compact, et s’adapte à tous les niveaux avec ses réglages et accessoires comme les bandes élastiques. Idéal pour un entraînement complet à domicile ":
      //         widget.producName=="ZR - 800"? "Le vélo d'appartement pliable avec dossier offre un entraînement cardio efficace tout en préservant le confort grâce à son siège ergonomique et son support dorsal. Il est idéal pour renforcer l’endurance, brûler des calories, et améliorer la santé cardiovasculaire. Son design compact et pliable le rend parfait pour les petits espaces":
      //         widget.producName=="fitness_app Pack Start"? "Le kit de bandes de résistance avec barre offre une grande polyvalence pour cibler tous les groupes musculaires, que ce soit pour la force, la rééducation ou le fitness. Compact et léger, il est facile à transporter et à utiliser partout. Grâce aux différentes résistances, il s'adapte à tous les niveaux et permet une progression efficace.":
      //
      //           "Cet appareil de fitness multifonction permet de travailler efficacement plusieurs groupes musculaires, notamment les abdominaux, les bras et les jambes. Compact et polyvalent, il offre des options d'exercices variés comme le pédalage, les crunchs et les étirements. Idéal pour un entraînement complet à domicile, il améliore la force musculaire, la souplesse et l'endurance."
      //           //
      //             //
      //         //
      //           ),
      //       ),
      //
      //       Container(
      //         padding: const EdgeInsets.all(14),
      //         height: 50,
      //         width: MediaQuery.of(context).size.width,
      //         color: const Color(0xFF1d1d1d),
      //         child: const Center(child: TextComponent(text: "Quell type de séance souhaitez-vous suivre ?",color: Colors.white,size: 15,)),
      //       ),
      //       h(20),
      //       Container(
      //         margin: const EdgeInsets.only(left: 20,right: 20),
      //         child: Row(
      //           children: [
      //             Expanded(
      //               child: InkWell(
      //                   onTap: () {
      //                     setState(() {
      //                       b1=!b1;
      //                       b2=false;
      //                     });
      //                     Navigator.push(context, MaterialPageRoute(builder: (context) => const Accueil(),));
      //                     // Future.delayed(Duration(
      //                     //   seconds: 2,),() {
      //                     // },);
      //                   },
      //                   child:  Column(
      //                     children: [
      //                       Card(
      //                         color: b1? mainColor:null,
      //                         elevation: 5,
      //                         child: Container(
      //                           padding: const EdgeInsets.all(10),
      //                           decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(15)
      //                           ),
      //                           height: 100,
      //                           width: 170,
      //                           child: Row(mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               TextComponent(text: "Séance libre",size: 16,color: b1? Colors.white:null,fontWeight: b1? FontWeight.bold:null,),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   )
      //               ),
      //             ),w(20),
      //             Expanded(
      //               child: InkWell(
      //                   onTap: () {
      //                     setState(() {
      //                       b2=!b2;
      //                       b1=false;
      //                     });
      //                     Navigator.push(context, MaterialPageRoute(builder: (context) => const Accueil(),));
      //                     // Future.delayed(Duration(
      //                     //   seconds: 2,),() {
      //                     //   },);
      //                   },
      //                   child:  Column(
      //                     children: [
      //                       Card(
      //                         color: b2? mainColor:null,
      //                         elevation: 5,
      //                         child: Container(
      //                           padding: const EdgeInsets.all(10),
      //                           decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(15)
      //                           ),
      //                           height: 100,
      //                           width: 170,
      //                           child: Row(mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               TextComponent(text: "Séance\npersonnalisée",size: 16,color: b2? Colors.white:null,fontWeight: b2? FontWeight.bold:null,textAlign: TextAlign.center,),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),h(15),
      //       h(50),
      //     ],
      //   ),
      // ),
    );
  }
}
