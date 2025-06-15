
import 'package:flutter/material.dart';
import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class MonCompte extends StatefulWidget {
  const MonCompte({super.key});

  @override
  State<MonCompte> createState() => _MonCompteState();
}

class _MonCompteState extends State<MonCompte> {
  TextEditingController nomPrenomController=TextEditingController();
  TextEditingController telController=TextEditingController();
  TextEditingController villeController=TextEditingController();
bool show =false;
 /* updateUserData(String nomPrenom, tel, ville) async {
    setState(() {
      show = true;
    });
    // EncryptData(mpController.text);
    var url =
        "https://zoutechhub.com/pharmaRh/permut/updateUserData.php?mail=$user_email&nomPrenom=$nomPrenom&tel=$tel&ville=$ville";
    var response = await http.post(Uri.parse(url));
    print(response.statusCode);
    print(response.body);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      showToast(context, "Modification Réussie.", Colors.green);
    *//*  Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpValidationScreen(userEmail: "${emailController.text}",),
          ));*//*
    } else {
      setState(() {
        show = false;
        showToast(context, "Erreur, veuillez réessayer.", main2);
      });
    }
  }
*/
 /* final ImagePicker _picker = ImagePicker();
  String? _statusMessage;
  String? _customFileName;
  late Timer _timer;
  bool ok = false;

  @override
  void initState() {
    super.initState();
    getUserDataOneTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getUserData();

    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _uploadFile() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file == null) {
      setState(() {
        _statusMessage = 'Aucun fichier sélectionné';
      });
      return;
    }

    // Récupérer l'extension du fichier
    String fileExtension = path.extension(file.path);

    setState(() {
      show = true;
    });

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://zoutechhub.com/pharmaRh/permut/upload_profil.php?ue=$user_email'), // Remplacez par votre URL
    );

    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    // Ajouter le nom de fichier personnalisé à la requête
    if (_customFileName != null && _customFileName!.isNotEmpty) {
      request.fields['customFileName'] = "$user_email$fileExtension"; // Inclure l'extension
    } else {
      request.fields['customFileName'] = "$user_email$fileExtension"; // Utiliser le nom par défaut
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = 'Fichier téléchargé avec succès !';
          showToast(context, _statusMessage!, Colors.green);
          show = false;
          ok = true;
          updateProfil("$fileExtension");
        });
      } else {
        setState(() {
          _statusMessage = 'Échec du téléchargement : ${response.statusCode}';
          showToast(context, _statusMessage!, main2);
          show = false;
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Erreur : $e';
        showToast(context, _statusMessage!, main2);
        show = false;
      });
    }
  }

  void updateProfil(String extension) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/permut/uploadProfil.php?mail=$user_email&profile=https://zoutechhub.com/pharmaRh/permut/uploads/${user_email}/${user_email.replaceAll('@', '').replaceAll('.', '')}$extension";
    var response = await http.post(Uri.parse(url));
    print(response.statusCode);
    print(response.body);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      showToast(context, "Modification Réussie.", Colors.green);
    } else {
      setState(() {
        show = false;
        showToast(context, "Erreur, veuillez réessayer.", main2);

      });
    }
  }
  String nomPrenom = "";
  String tel = "";
  String ville = "";

  Future<Map<String, dynamic>> getUserDataOneTime() async {
    var url =
        "https://zoutechhub.com/pharmaRh/permut/getUserData.php?mail=$user_email";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      // Supposons que jsonResponse est une liste, si ce n'est pas le cas, ajustez en conséquence
      if (jsonResponse.isNotEmpty) {
        var userData = jsonResponse[0]; // Accéder au premier élément
        setState(() {
          nomPrenomController.text = userData['nomPrenom'];
          villeController.text = userData['ville'];
          telController.text = userData['tel'];
          //String profil = userData['profil'];
        });


        return {
          'nomPrenom': nomPrenom,
          'ville': ville,
          'tel': tel,
        };
      } else {
        // Gérer le cas où il n'y a pas de données
        throw Exception("Aucune donnée trouvée.");
      }
    } else {
      throw Exception("Erreur lors de la récupération des données : ${response.statusCode}");
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 170,
              child: Stack(
                children: [
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    color: mainColor,
                    child: const Stack(
                      children: [
                        Positioned(
                            top:0,
                            left: 0,
                            right: 0,
                            child: Center(child: TextComponent(text: 'Votre Profil',fontWeight: FontWeight.w600,color: Colors.white,size: 17,))),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    right:100,
                    child: show? const CircularProgressIndicator(color: main2,): InkWell(
                      onTap: () {
                        //  _uploadFile();
                      },
                      child: const CircleAvatar(
                        child: Center(child: Icon(Icons.camera_alt),),
                      ),
                    ),
                  ),
                  const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child:  CircleAvatar(
                        radius: 60,
                        child: Center(
                          child: Icon(Icons.person_2,color: mainColor,size: 60,),
                        ),
                      )
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              child: Card(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextComponent(text: 'Nom & Prénoms',fontWeight: FontWeight.w600,),
                      h(15),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: nomPrenomController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: mainGrey))
                          ),
                        ),
                      ),
                      h(10),
                      const TextComponent(text: 'Email Pro',fontWeight: FontWeight.w600,),
                      h(10),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.only(top: 15,left: 15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: mainGrey),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const TextComponent(text: "mail"),
                      ),
                      h(10),
                      const TextComponent(text: 'Numéro de Téléphone',fontWeight: FontWeight.w600,),
                      h(10),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: telController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: mainGrey))
                          ),
                        ),
                      ),

                      h(10),
                      const TextComponent(text: 'Ville',fontWeight: FontWeight.w600,),
                      h(10),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: villeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: mainGrey))
                          ),
                        ),
                      ),
                      /* h(20),*/
                      /*Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextComponent(text: "Nombre de poste publié : ",fontWeight: FontWeight.bold,),
                                    Container(

                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade100,
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      padding: EdgeInsets.only(left: 15,right: 15),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.green.shade500,
                                          ),w(10),
                                          TextComponent(text: "5 postes")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),*/
                      h(20),
                      show? const CircularProgressIndicator(color: mainColor,) : InkWell(
                          onTap: () {
                            //   updateUserData("${nomPrenomController.text}","${telController.text}","${villeController.text}");
                          },
                          child: ButtonComponent(label: "Modifier mes informations")
                      )

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        /*FutureBuilder(
          future: getUserData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Erreur();
            }
            if (snapshot.hasData) {
              return  snapshot.data.isEmpty
                  ? Vide() : ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                   return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 170,
                        child: Stack(
                          children: [
                            Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              color: mainColor,
                              child: Stack(
                                children: [
                                  Positioned(
                                      top:0,
                                      left: 0,
                                      right: 0,
                                      child: Center(child: TextComponent(text: 'Votre Profil',fontWeight: FontWeight.w600,color: Colors.white,size: 17,))),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 40,
                              right:100,
                              child: show? CircularProgressIndicator(color: main2,): InkWell(
                                onTap: () {
                                //  _uploadFile();
                                },
                                child: CircleAvatar(
                                  child: Center(child: Icon(Icons.camera_alt),),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: snapshot.data[index]['profil']!='none'? Center(
                                  child: Container(
                                    height: 120,width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(image: NetworkImage(snapshot.data[index]['profil']),fit: BoxFit.cover)
                                    ),
                                  ),
                                ) : CircleAvatar(
                                  radius: 60,
                                  child: Center(
                                    child: Icon(Icons.person_2,color: mainColor,size: 60,),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                       Container(
                        margin: EdgeInsets.all(15),
                        child: Card(
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextComponent(text: 'Nom & Prénoms',fontWeight: FontWeight.w600,),
                                h(15),
                                Container(
                                  height: 50,
                                  child: TextFormField(
                                    controller: nomPrenomController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: mainGrey))
                                    ),
                                  ),
                                ),
                                h(10),
                                TextComponent(text: 'Email Pro',fontWeight: FontWeight.w600,),
                                h(10),
                                Container(
                                  height: 50,
                                  padding: EdgeInsets.only(top: 15,left: 15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: mainGrey),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: TextComponent(text: '${snapshot.data![index]['mail']}'),
                                ),
                                h(10),
                                TextComponent(text: 'Numéro de Téléphone',fontWeight: FontWeight.w600,),
                                h(10),
                                Container(
                                  height: 50,
                                  child: TextFormField(
                                    controller: telController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: mainGrey))
                                    ),
                                  ),
                                ),

                                h(10),
                                TextComponent(text: 'Ville',fontWeight: FontWeight.w600,),
                                h(10),
                                Container(
                                  height: 50,
                                  child: TextFormField(
                                    controller: villeController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: mainGrey))
                                    ),
                                  ),
                                ),
                               *//* h(20),*//*
                                *//*Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextComponent(text: "Nombre de poste publié : ",fontWeight: FontWeight.bold,),
                                    Container(

                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade100,
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      padding: EdgeInsets.only(left: 15,right: 15),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.green.shade500,
                                          ),w(10),
                                          TextComponent(text: "5 postes")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),*//*
                                h(20),
                                show? CircularProgressIndicator(color: mainColor,) : InkWell(
                                  onTap: () {
                                 //   updateUserData("${nomPrenomController.text}","${telController.text}","${villeController.text}");
                                  },
                                  child: ButtonComponent(label: "Modifier mes informations")
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return Center(
                child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Lottie.asset(
                        "assets/images/anim.json")));
          },
        ),*/
      ),

    );
  }
}
