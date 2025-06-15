import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:fitness_app/app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';

class InstructionPowerFit extends StatefulWidget {
  final String producName;
  final String path;

  InstructionPowerFit({super.key, required this.producName, required this.path});

  @override
  State<InstructionPowerFit> createState() => _InstructionPowerFitState();
}

class _InstructionPowerFitState extends State<InstructionPowerFit> {
  late List<String> videoUrls = [
    // "https://www.youtube.com/watch?v=KHtOOgvX4Rs&list=PL27ZZQGb4Vdw0Zg9C5f-UiJmAqCG6mM6W&index=14&pp=iAQB",
    "https://www.youtube.com/watch?v=MqkL22r8xgc&list=PL27ZZQGb4VdwDWFyEY-XzzsEdVdyPHOCI&index=1&pp=iAQB",
  ];
  late List<YoutubePlayerController> _controllers;
  int? _selectedVideoIndex;
  bool _isFullScreen = false;
  bool _hasResetVideo = false;

  bool un = true;
  bool deux = true;
  bool trois = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _controllers = videoUrls.map((url) {
      final videoId = YoutubePlayer.convertUrlToId(url);
      var controller = YoutubePlayerController(
        initialVideoId: videoId ?? '',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          loop: true,
          disableDragSeek: false,
          isLive: false,
          forceHD: true,
          enableCaption: false,
          useHybridComposition: false,
        ),
      );
      controller.addListener(_videoListener);
      return controller;
    }).toList();
  }

  void _videoListener() {
    final currentController = _selectedVideoIndex != null
        ? _controllers[_selectedVideoIndex!]
        : _controllers[0];

    if (currentController.value.isFullScreen) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
      if (!_hasResetVideo) {
        _hasResetVideo = true;
        Future.delayed(Duration(seconds: 5), () {
          if (currentController.value.isFullScreen) {
            currentController.seekTo(Duration.zero);
          }
        });
      }
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      _hasResetVideo = false;
    }

    if (mounted) {
      setState(() {
        _isFullScreen = currentController.value.isFullScreen;
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: !_isFullScreen
          ? AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: const TextComponent(
          text: "fitness_app",
          color: Colors.white,
          size: 15,
          fontWeight: FontWeight.bold,
        ),
      )
          : null,
      body: _isFullScreen
          ? YoutubePlayer(
        controller: _controllers[_selectedVideoIndex ?? 0],
        showVideoProgressIndicator: true,
        progressIndicatorColor: mainColor,
      )
          : SingleChildScrollView(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Screen.height(context)/4,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft, // Début du dégradé
                      end: Alignment.bottomRight, // Fin du dégradé
                      colors: [
                        Color(0xFF333333), // Couleur initiale
                        Color(0xFF0A0D15), // Couleur intermédiaire
                        Color(0xFF434040), // Couleur finale
                      ],
                      stops: [0.0, 0.8, 10],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  top: 25,
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF00A3E0), // Couleur bleu
                      image: DecorationImage(image: AssetImage("assets/images/${widget.path}"),fit: BoxFit.cover,alignment: Alignment.center,colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextComponent(text: "Instruction complète",fontWeight: FontWeight.bold,color: Colors.white,)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Card(
            color: Colors.white,
            margin: EdgeInsets.only(left: 10,right: 10),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: TextComponent(
                      text: "1- Explication exercice unilateral",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  YoutubePlayer(
                    controller: _controllers[0],
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    onEnded: (metadata) {
                      _controllers[0].seekTo(Duration.zero);
                    },
                  ),
                  InkWell(
                    onTap: () {
                      _selectedVideoIndex=0;
                      _controllers[0].toggleFullScreenMode();
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ButtonComponent(label: "Voir en plein écran"),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}