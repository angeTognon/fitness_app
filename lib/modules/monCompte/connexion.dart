
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fitness_app/modules/base/base.dart';

import '../../app/components/bouton_components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/components/text_components.dart';
import '../../app/components/text_form_component.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'controller/controller.dart';
import 'package:http/http.dart' as http;
import 'forgot.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  TextEditingController emailController = TextEditingController();
  TextEditingController mpController = TextEditingController();
  bool show=false;

  login() async {
    setState(() {
      show = true;
    });
    //print("coucou");

    var url = "https://zoutechhub.com/pharmaRh/gofitnext/connexion.php";
    var response = await http.post(Uri.parse(url),
        body: {'mail': emailController.text, 'mp': mpController.text});

    var data = json.decode(response.body);
    //print(data);
    if (data == "Success") {
     showToast(context, "Connexion Réussie. Bienvenue sur fitness_app !", Colors.green);
      final prefs = await SharedPreferences.getInstance();
      eya = true;
      prefs.setBool('isConnected', eya);

      user_email = emailController.text;

      final userPref = await SharedPreferences.getInstance();

      userPref.setString('email', emailController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Base(),));

    } else {
      setState(() {
        show = false;
      });
      showToast(context, "Echec. Veuillez réessayer svp !", main2);

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TextComponent(text: "Connexion",size: 15,fontWeight: FontWeight.bold,),

            h(10),
            const TextComponent(text: "Connectez-vous à fitness_app pour vivre de meilleurs expériences d'entrainement",size: 14,textAlign: TextAlign.center,),
            h(10),
            TextFormComponent(
              controller: emailController,
              label: "Email",
              hintText: "Veuillez entrer votre adresse mail",
              prefixIcon: Icons.mail,
              textInputType: TextInputType.emailAddress,
            ),
            h(10),
            TextFormComponent(
              controller: mpController,
              hintText: "Veuillez entrer votre Mot de passe",
              textInputType: TextInputType.visiblePassword,
              prefixIcon: Icons.lock,
              hide:true
            ),
            h(20),
            show? const CircularProgressIndicator(color: main2,): InkWell(
                onTap: () {
                  setState(() {
                    show=true;
                  });
                  if(emailController.text.isEmpty||mpController.text.isEmpty){
                    Future.delayed(const Duration(seconds: 3),() {
                      setState(() {
                        show=false;
                      });
                      showToast(context, "Veuillez remplir tous les champs", main2);

                    },);

                  }else{
                    login();
                  }
                },
                child: ButtonComponent(label:"Me Connecter",fontWeight: FontWeight.bold,size: 14,)),
            // h(20),
            // TextComponent(text: "Ou se Connecter avec"),
            // h(20),
            // Row(mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     InkWell(
            //       onTap: () async {
            //         // GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
            //         // GoogleSignInAuthentication ? googleAuth=await googleUser?.authentication;
            //         // AuthCredential credential= GoogleAuthProvider.credential(
            //         // accessToken: googleAuth?.accessToken,
            //         // idToken: googleAuth?.idToken);
            //         //
            //         // UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
            //         // print(userCredential.user?.displayName);
            //       },
            //       child: CircleAvatar(
            //         backgroundColor: Colors.white,
            //         radius: 30,
            //         backgroundImage: AssetImage("assets/images/gmaill.png"),
            //       ),
            //     ),
            //     w(50),
            //     CircleAvatar(
            //       backgroundColor: Colors.white,
            //       radius: 25,
            //       backgroundImage: AssetImage("assets/images/facebookk.png"),
            //     )
            //   ],
            // ),
            h(20),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextComponent(text: "Mot de passe oublié ? ",size: 14,),w(5),
                InkWell(
                    onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const PasswordForgot(),)),
                    child: const TextComponent(text: "Cliquez ici",fontWeight: FontWeight.bold,color: main2,size: 14,)),w(20),
              ],
            ),

            // h(20),
            // Column(mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const TextComponent(text: "Vous n'avez pas encore un compte ? ",size: 16,),w(5),
            //     h(5),
            //     InkWell(
            //         onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Inscription(),)),
            //         child: const TextComponent(text: "Cliquez ici",fontWeight: FontWeight.bold,color: main2,size: 16,)),
            //   ],
            // ),

          ],
        ),
      )),
    );
  }
}
