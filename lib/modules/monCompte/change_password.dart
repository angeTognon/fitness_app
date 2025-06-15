
import 'package:flutter/material.dart';
import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../app/components/text_form_component.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'controller/controller.dart';

class ChangePassword extends StatefulWidget {
  String email;

  ChangePassword({super.key, 
    required this.email
});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController mpController = TextEditingController();
  TextEditingController mpController2 = TextEditingController();
  bool show=false;

 /* inscription() async {
    setState(() {
      show = true;
    });
    // EncryptData(mpController.text);
    var url =
        "https://zoutechhub.com/pharmaRh/permut/updateUserPassword.php?mail=${widget.email}&password=${mpController.text}";
    var response = await http.post(Uri.parse(url));

    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      show = false;
      showToast(context, "Mot de passe changé avec succès !", Colors.green);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Connexion(),
          ));
    } else {
      setState(() {
        show = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur",
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
      resizeToAvoidBottomInset: true,
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
            const TextComponent(text: "Mettez votre nouveau mot de passe",size: 18,fontWeight: FontWeight.bold,),
            h(40),
            TextFormComponent(
              controller: mpController,
              hintText: "Votre Mot de passe",
              textInputType: TextInputType.visiblePassword,
              prefixIcon: Icons.lock,
              hide:true
            ),
            h(40),
            TextFormComponent(
                controller: mpController2,
                hintText: "Confirmez à nouveau votre Mot de passe",
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
                  if(mpController2.text.isEmpty||mpController.text.isEmpty ){
                    Future.delayed(const Duration(seconds: 3),() {
                      setState(() {
                        show=false;
                      });
                      showToast(context, "Veuillez remplir tous les champs", main2);

                    },);

                  }else if(mpController2.text!=mpController.text ){
                    Future.delayed(const Duration(seconds: 3),() {
                      setState(() {
                        show=false;
                      });
                      showToast(context, "Les mots de passe ne sont pas identique", main2);
                    },);

                  }
                  else{
                    // inscription();
                  }
                },
                child: ButtonComponent(label:"Changer mon mot de passe",fontWeight: FontWeight.bold,)),


          ],
        ),
      )),
    );
  }
}
