import 'package:flutter/material.dart';

import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../app/components/text_form_component.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'controller/controller.dart';

class PasswordForgot extends StatefulWidget {
  const PasswordForgot({super.key});

  @override
  State<PasswordForgot> createState() => _PasswordForgotState();
}

class _PasswordForgotState extends State<PasswordForgot> {
  TextEditingController emailController = TextEditingController();

  bool show =false;
  /*inscription() async {
    setState(() {
      show = true;
    });
    // EncryptData(mpController.text);
    var url =
        "https://zoutechhub.com/pharmaRh/permut/forgotPasswordCodeVerification.php?mail=${emailController.text}";
    var response = await http.post(Uri.parse(url));

    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      show = false;
      showToast(context, "Code envoyé avec succès dans votre boîte mail ${emailController.text} !", Colors.green);
      print("${emailController.text}");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpValidationScreen(userEmail: "${emailController.text}",forgot: true,),
          ));
    } else {
      setState(() {
        show = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur : Il semble que cette adresse mail a déjà été utilisée ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        title: const TextComponent(text: "fitness_app",color: Colors.white,size: 19,fontWeight: FontWeight.bold,),
      ),
      body: SafeArea(child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TextComponent(text: "Reinitialisation de votre mot de passe",size: 18,fontWeight: FontWeight.bold,),
            h(20),
            TextFormComponent(
              controller: emailController,
              label: "Email",
              hintText: "Entrez votre Email Professionnelle",
              prefixIcon: Icons.mail,
            ),
            h(30),

           show? const CircularProgressIndicator() : InkWell(
                onTap: () {
                  setState(() {
                    show=true;
                  });
                  if(emailController.text.isEmpty){
                    Future.delayed(const Duration(seconds: 3),() {
                      setState(() {
                        show=false;
                      });
                      showToast(context, "Veuillez remplir tous les champs", main2);

                    },);

                  }else{
                   // inscription();
                  }
                },
                child: ButtonComponent(label:"Envoyer le code de confirmation",fontWeight: FontWeight.bold,)),
          ],
        ),
      )),
    );
  }
}
