import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../app/components/text_components.dart';
import '../../utils/constants.dart';

class CGU extends StatefulWidget {
  const CGU({super.key});

  @override
  State<CGU> createState() => _CGUState();
}

class _CGUState extends State<CGU> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Icône de retour blanche
        title: const Text(
          "Permut",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: mainColor,
        // actions: [
        //   Icon(Icons.favorite, color: Colors.white),
        //   SizedBox(width: 20),
        //   Icon(Icons.notifications, color: Colors.white),
        //   SizedBox(width: 20),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextComponent(text: "Conditions Générales d'Utilisation de l'Application de Permutation de Postes",textAlign: TextAlign.center,fontWeight: FontWeight.bold,size: 16,),
            h(15),
            const TextComponent(text: "1. Acceptation des Conditions",textAlign: TextAlign.center,fontWeight: FontWeight.bold,size: 15,color: main2,),
            h(15),
            const TextComponent(text: "En utilisant l'application de permutation de postes, vous acceptez de respecter les présentes conditions générales d'utilisation (CGU). Si vous n'acceptez pas ces conditions, vous ne devez pas utiliser l'application.",textAlign: TextAlign.justify,size: 15,),
            h(15),
            const TextComponent(text: "2. Objet de l'Application",textAlign: TextAlign.center,fontWeight: FontWeight.bold,size: 15,color: main2,),
            h(15),
            const TextComponent(text: "L'application a pour but de faciliter les démarches de permutation de postes pour les fonctionnaires des secteurs de la police et de la gendarmerie. Elle permet aux utilisateurs de rechercher et de proposer des échanges de postes en fonction de divers critères tels que la localisation, le grade, et la spécialité.",textAlign: TextAlign.justify,size: 15,),
            h(15),
            const TextComponent(text: "3. Inscription et Sécurité",textAlign: TextAlign.center,fontWeight: FontWeight.bold,size: 15,color: main2,),
            h(15),
            const TextComponent(text: "-  Inscription : Pour accéder à l'application, vous devez créer un compte en fournissant des informations personnelles et professionnelles.\n\n-  Vérification : L'inscription est sécurisée par un système de vérification par email professionnel et par un mot de passe à usage unique (OTP). Seuls les fonctionnaires authentifiés peuvent accéder à la plateforme.",textAlign: TextAlign.justify,size: 15,),
            h(15),
            const TextComponent(text: "4. Utilisation de l'Application",textAlign: TextAlign.center,fontWeight: FontWeight.bold,size: 15,color: main2,),
            h(15),
            const TextComponent(text: "-  Recherche de Postes : Les utilisateurs peuvent filtrer les postes disponibles selon divers critères.\n\n-  Mise en Relation : L'application facilite la mise en relation directe entre fonctionnaires souhaitant permuter leurs postes.",textAlign: TextAlign.justify,size: 15,),
            h(15),
            const TextComponent(text: "5. Obligations des Utilisateurs",textAlign: TextAlign.center,fontWeight: FontWeight.bold,size: 15,color: main2,),
            h(15),
            const TextComponent(text: "Les utilisateurs s'engagent à :\n\n-  Fournir des informations exactes et à jour lors de l'inscription.\n\n-  Ne pas utiliser l'application à des fins illégales ou non autorisées.\n\n-  Respecter la confidentialité des informations échangées sur la plateforme.",textAlign: TextAlign.justify,size: 15,),

            h(15),
            const TextComponent(text: "6. Propriété Intellectuelle",textAlign: TextAlign.center,fontWeight: FontWeight.bold,size: 15,color: main2,),
            h(15),
            const TextComponent(text: "Tous les contenus de l'application, y compris les textes, graphiques, logos, et logiciels, sont protégés par des droits de propriété intellectuelle. Aucune reproduction ou utilisation non autorisée n'est permise.",textAlign: TextAlign.justify,size: 15,),

            h(15),
            const TextComponent(text: "7. Limitation de Responsabilité",textAlign: TextAlign.center,fontWeight: FontWeight.bold,size: 15,color: main2,),
            h(15),
            const TextComponent(text: "fitness_app s'efforce de fournir un service de qualité, mais nous ne pouvons garantir que l'application sera exempte d'erreurs ou d'interruptions. Nous ne serons pas responsables des dommages indirects, consécutifs ou punitifs résultant de l'utilisation de l'application.",textAlign: TextAlign.justify,size: 15,),

            h(15),
            const TextComponent(text: "8. Modifications des CGU",textAlign: TextAlign.center,fontWeight: FontWeight.bold,size: 15,color: main2,),
            h(15),
            const TextComponent(text: "L'éditeur de l'application se réserve le droit de modifier les présentes CGU à tout moment. Les utilisateurs seront informés des modifications par notification dans l'application.",textAlign: TextAlign.justify,size: 15,),

            h(15),
            const TextComponent(text: "9. Droit Applicable",textAlign: TextAlign.center,fontWeight: FontWeight.bold,size: 15,color: main2,),
            h(15),
            const TextComponent(text: "Les présentes CGU sont régies par le droit français. Tout litige relatif à l'utilisation de l'application sera soumis aux tribunaux compétents.",textAlign: TextAlign.justify,size: 15,),

          ],
        ),
      ),
    );
  }
}
