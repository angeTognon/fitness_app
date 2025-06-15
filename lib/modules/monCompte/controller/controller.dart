
import 'package:flutter/material.dart';

import '../../../app/components/text_components.dart';
import '../../../utils/colors.dart';

void showToast(BuildContext context, String message,Color? color) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 90.0,
      left: MediaQuery.of(context).size.width * 0.2,
      right: MediaQuery.of(context).size.width * 0.2,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: color ?? mainColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextComponent(
            text:message,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
/*

getUserData() async {
  var url =
      "https://zoutechhub.com/pharmaRh/permut/getUserData.php?mail=$user_email";
  var response = await http.get(Uri.parse(url));
  // print(response.statusCode);
  // print(response.body);
  var pub = await json.decode(response.body);
  return pub;
}

Future<List<dynamic>> getPost() async{
  var url =
      "https://zoutechhub.com/pharmaRh/permut/getAllPost.php";
  var response = await http.get(Uri.parse(url));
  var pub = await json.decode(response.body);
  return pub;
}
getComments() async {
  var url =
      "https://zoutechhub.com/pharmaRh/permut/getAllComments.php";
  var response = await http.get(Uri.parse(url));
  var pub = await json.decode(response.body);
  return pub;
}

getPostSearch(String query) async {
  var url =
      "https://zoutechhub.com/pharmaRh/permut/getRecherchePost.php?search=$query";
  var response = await http.get(Uri.parse(url));
  var pub = await json.decode(response.body);
  return pub;
}

getMoinsRecent() async {
  var url =
      "https://zoutechhub.com/pharmaRh/permut/filtreByMoinsRecent.php";
  var response = await http.get(Uri.parse(url));
  var pub = await json.decode(response.body);
  return pub;
}

getPlusRecent() async {
  var url =
      "https://zoutechhub.com/pharmaRh/permut/filtreByPlusRecent.php";
  var response = await http.get(Uri.parse(url));
  var pub = await json.decode(response.body);
  return pub;
}


getPostById(int id) async {
  var url =
      "https://zoutechhub.com/pharmaRh/permut/getPostById.php?id=$id";
  var response = await http.get(Uri.parse(url));
  print(response.statusCode);
  print(response.body);
  var pub = await json.decode(response.body);
  return pub;
}



getPostPublie() async {
  var url =
      "https://zoutechhub.com/pharmaRh/permut/getPostPublie.php?mail=$user_email";
  var response = await http.get(Uri.parse(url));
  // print(response.statusCode);
  // print(response.body);
  var pub = await json.decode(response.body);
  return pub;
}
getPostCommentaire(int id) async {
  var url =
      "https://zoutechhub.com/pharmaRh/permut/getAllComments.php?id=$id";
  var response = await http.get(Uri.parse(url));
  // print(response.statusCode);
  // print(response.body);
  var pub = await json.decode(response.body);
  return pub;
}



getUserDemande() async {
  var url =
      "https://zoutechhub.com/pharmaRh/permut/get_demande_post.php?mail=$user_email";
  var response = await http.get(Uri.parse(url));
  // print(response.statusCode);
  // print(response.body);
  var pub = await json.decode(response.body);
  return pub;
}
getDemandeRecu() async {
  var url =
      "https://zoutechhub.com/pharmaRh/permut/getDemandeRecu.php?email=$user_email";
  var response = await http.get(Uri.parse(url));
  // print(response.statusCode);
  // print(response.body);
  var pub = await json.decode(response.body);
  return pub;
}
getDemandeRecuById(int id) async {
  var url =
      "https://zoutechhub.com/pharmaRh/permut/getDemandePermutationById.php?id=$id";
  var response = await http.get(Uri.parse(url));
  // print(response.statusCode);
  // print(response.body);
  var pub = await json.decode(response.body);
  return pub;
}



Erreur(){
  return Center(
    child: Container(
      height: 100,
      child: Column(
        children: [
          Icon(Icons.error,size: 45,color: main2,),
          h(10),
          TextComponent(
            text:  "Erreur de chargement\nVeuillez vérifier votre connexion internet",textAlign: TextAlign.center,),
        ],
      ),
    ),
  );
}
Vide(){
  return Column(
    children: [
      h(20),
      Icon(
        Icons.error,
        size: 100,
        color: main2,
      ),
      h(20),
      Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Text(
          "Oups, Aucune donnée pour l'instant ",
          style: TextStyle(fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

*/
