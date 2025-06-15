import 'package:flutter/material.dart';

import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../app/components/text_form_component.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:country_picker/country_picker.dart';
import 'controller/controller.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  TextEditingController nomPrenomController = TextEditingController();
  TextEditingController paysController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mpController = TextEditingController();
  bool show =false;
 /* inscription() async {
    setState(() {
      show = true;
    });
    // EncryptData(mpController.text);
    var url =
        "https://zoutechhub.com/pharmaRh/permut/inscription.php?nomPrenom=${nomPrenomController.text}&pays=${paysController.text}&ville=${villeController.text}&tel=${telController.text}&mail=${emailController.text}&mp=${mpController.text}&profil=none&typeCompte=$_selectedValue";
    var response = await http.post(Uri.parse(url));

    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      userName = nomPrenomController.text;
      final userNamePref = await SharedPreferences.getInstance();
      userNamePref.setString('userName', nomPrenomController.text);
      show = false;
      showToast(context, "Inscription Réussie.", Colors.green);
      print("${emailController.text}");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpValidationScreen(userEmail: "${emailController.text}",),
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
  */String? _selectedValue;

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
      print(_selectedValue);
    });
  }
  String _strengthMessage = '';

  void _checkPasswordStrength(String password) {
    if (password.length < 8) {
      setState(() {
        _strengthMessage = 'Mot de passe trop court';
      });
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      setState(() {
        _strengthMessage = 'Ajoutez des chiffres';
      });
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      setState(() {
        _strengthMessage = 'Ajoutez des lettres majuscules';
      });
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      setState(() {
        _strengthMessage = 'Ajoutez des caractères spéciaux';
      });
    } else {
      setState(() {
        _strengthMessage = 'Mot de passe fort';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        title: const TextComponent(text: "fitness_app",color: Colors.white,size: 19,fontWeight: FontWeight.bold,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const TextComponent(text: "Inscription",size: 20,fontWeight: FontWeight.bold,),
              h(20),
              TextFormComponent(
                controller: nomPrenomController,
                hintText: "Nom et Prénoms",
                prefixIcon: Icons.person,
              ),
        
              h(20),
              h(10),
              InkWell(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    onSelect: (country) {
                      setState(() {
                        paysController.text = country.name;
                      });
                    },
                  );
                },
                child:Container(
                  padding: const EdgeInsets.all(12),
                  height: 60,width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black38)
                  ),
                    child: Center(
                    child: Row(
                      children: [
                        const Icon(Icons.flag_circle),w(12),
                        TextComponent(text: paysController.text.isEmpty? "Pays" : "Pays : ${paysController.text}",size: 16,)
                      ],
                    ),
                  ),
                )
              ),
              h(20),
              TextFormComponent(
                controller: villeController,
                hintText: "Ville",
                prefixIcon: Icons.place,
              ),
              h(20),
              TextFormComponent(
                controller: telController,
                hintText: "Numéro de Téléphone",
                prefixIcon: Icons.phone,
                textInputType: TextInputType.phone,
              ),
              h(20),

              TextFormComponent(
                controller: emailController,
                hintText: "Email Professionnel",
                prefixIcon: Icons.mail,
                textInputType: TextInputType.emailAddress,
              ),
              h(20),
              TextField(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                controller: mpController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  hintStyle: const TextStyle(color: Colors.black,fontFamily: 'PRegular'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black38,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black38,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Mot de passe',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                ),
                onChanged: _checkPasswordStrength,
              ),
              h(20),
              Text(
                _strengthMessage,
                style: TextStyle(
                  fontFamily: 'PBold',
                  color: _strengthMessage == 'Mot de passe fort' ? Colors.green : Colors.red,
                  fontSize: 16,
                ),
              ),
              h(20),


              show? const CircularProgressIndicator(color: main2,) : InkWell(
                  onTap: () {
                    setState(() {
                      show=true;
                    });
                    if(nomPrenomController.text.isEmpty||paysController.text.isEmpty||villeController.text.isEmpty||telController.text.isEmpty||emailController.text.isEmpty||mpController.text.isEmpty){
                     Future.delayed(const Duration(seconds: 3),() {
                       setState(() {
                         show=false;
                       });
                       showToast(context, "Veuillez remplir tous les champs", main2);
        
                     },);
        
                    }else{
                    //  inscription();
                    }
                  //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OtpValidationScreen()));
                  },
                  child: ButtonComponent(label:"M'inscrire",fontWeight: FontWeight.bold,size: 18,)),
              h(20),

            ],
          ),
        ),
      ),
    );
  }
}
