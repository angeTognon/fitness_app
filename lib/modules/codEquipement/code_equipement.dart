import 'package:flutter/material.dart';

import '../../app/components/text_components.dart';
import '../../utils/colors.dart';

class CodeEquipement extends StatefulWidget {
  const CodeEquipement({super.key});

  @override
  State<CodeEquipement> createState() => _CodeEquipementState();
}

class _CodeEquipementState extends State<CodeEquipement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        title: const TextComponent(text: "fitness_app",color: Colors.white,size: 19,fontWeight: FontWeight.bold,),
      ),
    );
  }
}
