
import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';
import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/constants.dart';


class OtpValidationScreen extends StatefulWidget {
  String userEmail="";
  bool? forgot=false;
  OtpValidationScreen({super.key, 
    required this.userEmail,
    this.forgot
});
  @override
  _OtpValidationScreenState createState() => _OtpValidationScreenState();
}

class _OtpValidationScreenState extends State<OtpValidationScreen> {
  String otpCode="";bool show=false;
  /*Future<void> getUserOptCode() async {
    var url = "https://zoutechhub.com/pharmaRh/permut/getUserData.php?mail=${widget.userEmail}";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body) as List; // Décodez en tant que liste
      if (jsonResponse.isNotEmpty) {
        // Vérifiez que la liste n'est pas vide
        otpCode = jsonResponse[0]['code']; // Accédez au premier élément et obtenez le code
        setState(() {}); // Mettre à jour l'état
      } else {
        print('La liste est vide.');
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  */@override
  void initState() {
    // TODO: implement initState
    print(widget.userEmail);
   // getUserOptCode();
    super.initState();
  }



  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final String _message = '';

 /* void _validateOtp() {
    final otp = _controllers.map((controller) => controller.text).join();
    if (otp == '$otpCode') { // Remplacez par votre logique de validation
      setState(() {
        Future.delayed(Duration(seconds: 3),() {
          setState(() {
            show=false;
          });
          showToast(context, "OTP validé avec succès !", Colors.green);

          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.forgot!? ChangePassword(email: widget.userEmail,) :  Connexion(),));

        },);
      });
    } else {
      Future.delayed(Duration(seconds: 3),() {
        setState(() {
          show=false;
        });
        showToast(context, "OTP incorrect, veuillez réessayer.", main2);

      },);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextComponent(text: "Validation OTP",size: 20,fontWeight: FontWeight.bold,),
            h(20),
            const TextComponent(text: "Veuillez saisir le code reçu par mail afin de finaliser votre inscription",size: 18,textAlign: TextAlign.center,),
            h(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      counterText: '', // Masquer le texte du compteur
                    ),
                    maxLength: 1,
                    onChanged: (value) {
                      if (value.length == 1 && index < 5) {
                        FocusScope.of(context).nextFocus(); // Passer au champ suivant
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus(); // Revenir au champ précédent
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 50),
            show? const CircularProgressIndicator(color: main2,) : InkWell(
                onTap: () {
                  print(otpCode);
                  setState(() {
                    show=true;
                  });
                 // _validateOtp();

                },
                child: ButtonComponent(label: "Valider")),
          ],
        ),
      ),
    );
  }
}