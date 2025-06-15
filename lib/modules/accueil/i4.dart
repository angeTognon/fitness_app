import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import 'i5.dart';

class I4 extends StatefulWidget {
  const I4({super.key});

  @override
  State<I4> createState() => _I4State();
}

class _I4State extends State<I4> {

  bool b1=false;
  bool b2=false;
  bool b3=false;
  bool b4=false;
  bool b5=false;
  bool b6=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          height: 130,
          color: mainColor,
          child: const Center(
            child: TextComponent(text: "Étapes 1 : Vos Objectfis",color: Colors.white,size: 20,fontWeight: FontWeight.bold,),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextComponent(text: "Sur quelle zone du corps voulez-vous vous concentrer ?",fontWeight: FontWeight.bold,size: 17,),
            h(20),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          b1=!b1;
                        });
                      },
                      child:  Column(
                        children: [
                          Card(
                            color: b1? mainColor:null,
                            elevation: 5,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextComponent(text: "Bras",size: 17,color: b1? Colors.white:null,fontWeight: b1? FontWeight.bold:null,),
                                ],
                              ),
                            ),
                          ),

                        ],
                      )
                  ),
                ),w(20),
                Expanded(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          b2=!b2;
                        });
                      },
                      child:  Column(
                        children: [
                          Card(
                            color: b2? mainColor:null,
                            elevation: 5,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextComponent(text: "Abdos",size: 17,color: b2? Colors.white:null,fontWeight: b2? FontWeight.bold:null,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),h(15),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          b3=!b3;
                        });
                      },
                      child:  Column(
                        children: [
                          Card(
                            color: b3? mainColor:null,
                            elevation: 5,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextComponent(text: "Fesses",size: 17,color: b3? Colors.white:null,fontWeight: b3? FontWeight.bold:null,),
                                ],
                              ),
                            ),
                          ),

                        ],
                      )
                  ),
                ),w(20),
                Expanded(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          b4=!b4;
                        });
                      },
                      child:  Column(
                        children: [
                          Card(
                            color: b4? mainColor:null,
                            elevation: 5,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextComponent(text: "Jambes",size: 17,color: b4? Colors.white:null,fontWeight: b4? FontWeight.bold:null,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),h(15),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          b5=!b5;
                        });
                      },
                      child:  Column(
                        children: [
                          Card(
                            color: b5? mainColor:null,
                            elevation: 5,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextComponent(text: "Épaules",size: 17,color: b5? Colors.white:null,fontWeight: b5? FontWeight.bold:null,),
                                ],
                              ),
                            ),
                          ),

                        ],
                      )
                  ),
                ),w(20),
                Expanded(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          b6=!b6;
                        });
                      },
                      child:  Column(
                        children: [
                          Card(
                            color: b6? mainColor:null,
                            elevation: 5,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextComponent(text: "Coprs Entier",size: 17,color: b6? Colors.white:null,fontWeight: b6? FontWeight.bold:null,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),h(40),

            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const I5(),));
                },
                child: ButtonComponent(label: "Suivant",size: 17,))
          ],
        ),
      ),
    );
  }

}
