import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../app/components/text_form_component.dart';
import 'package:url_launcher/url_launcher.dart';
import '../monCompte/controller/controller.dart';

class ServiceSupport extends StatefulWidget {
  const ServiceSupport({super.key});

  @override
  State<ServiceSupport> createState() => _ServiceSupportState();
}

class _ServiceSupportState extends State<ServiceSupport> {
  TextEditingController nomPrenom = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController objet = TextEditingController();
  TextEditingController msg = TextEditingController();
  bool show = false;

  /*void sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'tognonange.koffi@gmail.com', // Change to your recipient email
      query: 'subject=${Uri.encodeComponent(objet.text)}&body=${Uri.encodeComponent('De la part de ${nomPrenom.text}. Mail : ${email.text}\n\n${msg.text}')}', // Encode components
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
      Navigator.pop(context);
    } else {
      setState(() {
        show=false;
      });
      showToast(context, 'Could not launch email app', main2);

    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        title: const TextComponent(text: "fitness_app",color: Colors.white,size: 20,fontWeight: FontWeight.bold,),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                children: [
                  const TextComponent(
                    size: 18,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    color: main2,
                    text: "SERVICE SUPPORT",
                  ),
                  const SizedBox(height: 10),
                  const TextComponent(
                    size: 16,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    text: "Vous avez une question ou une préoccupation ? Informez-nous via le formulaire suivant !",
                  ),
                  const SizedBox(height: 10),
                  TextFormComponent(
                    controller: nomPrenom,
                    hintText: "Votre nom et Prénom",
                    prefixIcon: Icons.person,
                  ),
                 const SizedBox(height: 20),
                  TextFormComponent(
                    controller: objet,
                    hintText: "Objet",
                    prefixIcon: Icons.question_mark,
                  ),
                  const SizedBox(height: 20),
                  TextFormComponent(
                    controller: msg,
                    hintText: "Message",
                    maxLine: 8,
                  ),
                  const SizedBox(height: 20),
                  show
                      ? const CircularProgressIndicator(color: main2)
                      : InkWell(
                    onTap: () {
                      if (nomPrenom.text.isEmpty ||
                          objet.text.isEmpty ||
                          msg.text.isEmpty) {
                       showToast(context, "Veuillez remplir tous les champs", main2);
                      } else {
                        Navigator.pop(context);
                        launchUrl(Uri(
                          scheme: 'mailto',
                          path: 'tognonange.koffi@gmail.com',
                          query: Uri.encodeFull('subject=${objet.text} de la part de ${nomPrenom.text}&body=${msg.text}'),
                        ));
                      }
                    },
                    child: ButtonComponent(
                      label: "Envoyer au Service Support",
                      fontWeight: FontWeight.bold,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}