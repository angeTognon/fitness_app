import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:fitness_app/app/components/bouton_components.dart';
import '../../app/components/text_components.dart';
import '../../utils/colors.dart';

class Details extends StatefulWidget {
  final String producName;
  final String path;

  Details({super.key, required this.producName, required this.path});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final List<String> videoUrls = [
    "https://www.youtube.com/watch?v=R0IUvXNKBUU",
    "https://www.youtube.com/watch?v=X4tdWbfOfns",
    "https://www.youtube.com/watch?v=4v2cCtIkT64",
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
      return YoutubePlayerController(
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
      )..addListener(_videoListener);
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              _isFullScreen
                  ? YoutubePlayer(
                controller: _selectedVideoIndex != null
                    ? _controllers[_selectedVideoIndex!]
                    : _controllers[0],
                showVideoProgressIndicator: true,
                progressIndicatorColor: mainColor,
              )
                  : _buildContent(),
            ],
          ),
        )
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
                          child: TextComponent(text: "QuardioQuad",fontWeight: FontWeight.bold,color: Colors.white,)),
                    ),
                  ),
                ),
              ],
            ),
          ),

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
                      text: "1- Installation",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  YoutubePlayer(
                    controller: _controllers[2],
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    onEnded: (metadata) {
                      _controllers[2].seekTo(Duration.zero);
                    },
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedVideoIndex = 2;
                        trois = true;
                        un = deux = false;
                      });
                      _controllers[2].toggleFullScreenMode();
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
          Divider(),
          SizedBox(height: 15,),
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
                      text: "2- Réglage de la machine",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  YoutubePlayer(
                    controller: _controllers[1],
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    onEnded: (metadata) {
                      _controllers[1].seekTo(Duration.zero);
                    },
                  ),
                  InkWell(
                    onTap: () {
                      _selectedVideoIndex = 1;
                      _controllers[1].toggleFullScreenMode();
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
          Divider(),
          SizedBox(height: 15,),
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
                      text: "3- Conseils",
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
                      setState(() {
                        _selectedVideoIndex = 0;
                        trois = true;
                        un = deux = false;
                      });
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

          Divider(),
        ],
      ),
    );
  }

  void _exitFullScreen() async {
    setState(() {
      un = deux = trois = true;
      _selectedVideoIndex = null;
    });

    if (_selectedVideoIndex != null) {
      _controllers[_selectedVideoIndex!].play();
    }

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}