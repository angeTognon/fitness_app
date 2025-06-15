import '../../app/components/text_components.dart';
import '../../modules/productDetails/details_produits.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';

class Boutique extends StatefulWidget {
  const Boutique({super.key});

  @override
  State<Boutique> createState() => _BoutiqueState();
}

class _BoutiqueState extends State<Boutique> {
  TextEditingController codEquipement = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: const TextComponent(text: "Notre Boutique D'équipement",size: 14,textAlign: TextAlign.start,)),
            h(20),
            Center(
              child: Wrap(
                runSpacing: 8.0,
                children: [
                  SizedBox(
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
                    child: NosEquipement("assets/images/newPowerbands.jpg", "PowerFit", ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 25,
                    child: NosEquipement("assets/images/cardio.jpg", "CardioQuad 23", ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 25,
                    child: NosEquipement("assets/images/newPowerFit.jpg", "PowerBands",),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
  NosEquipement(String path, txt){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsProduits(producName: txt,path: path,),));

        // Navigator.push(context, MaterialPageRoute(builder: (context) => const CodeEquipement(),));
      },
      child: Column(
        children: [
          Card(
            child: Container(
              // padding: const EdgeInsets.all(10),
              height: 150,width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image:  DecorationImage(
                      // colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken),
                      image: AssetImage(path),fit: BoxFit.cover)
              ),
              child: Stack(
                children: [

                  Container(
                    height: 150,width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black54
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: const TextComponent(text: "Acheter",color: Colors.white,size: 12,),
                        ),
                        Expanded(child: h(0),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          h(5),
          TextComponent(text: txt,size: 13,color: Colors.black,fontWeight: FontWeight.bold,textAlign: TextAlign.start,),
        ],
      ),
    );
  }
}
