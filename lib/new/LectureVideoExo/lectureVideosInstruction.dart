import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitness_app/modules/monCompte/controller/controller.dart';
import 'package:fitness_app/utils/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../app/components/bouton_components.dart';
import '../../app/components/text_components.dart';

class Lecturevideosinstruction extends StatefulWidget {

  String linkVideo;

  Lecturevideosinstruction({required this.linkVideo});

  @override
  State<Lecturevideosinstruction> createState() => _LecturevideosinstructionState();
}

class _LecturevideosinstructionState extends State<Lecturevideosinstruction> {


  final List<String> videoUrls = [];
  late List<YoutubePlayerController> _controllers;
  int? _selectedVideoIndex;
  bool _isFullScreen = false;
  bool _hasResetVideo = false;

  @override
  void initState() {
    super.initState();
    videoUrls.add(widget.linkVideo);
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

  bool _isTimerRunning = false;
  bool _isPaused = false;
  int _remainingTime = 55;
  int _seriesCount = 0;
  Timer? _timer;
  AudioPlayer _audioPlayer = AudioPlayer();
  int _repetitionCount = 0;
  int _currentRepetitionCount = 0;
  int _reposTime = 60; // Temps de repos en secondes (1 minute par défaut)


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _isFullScreen
          ? YoutubePlayer(
        controller: _controllers[_selectedVideoIndex ?? 0],
        showVideoProgressIndicator: true,
        progressIndicatorColor: mainColor,
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Screen.height(context) / 1.5,
              child: Stack(
                children: [
                  Container(
                    height: 550,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF333333),
                          Color(0xFF0A0D15),
                          Color(0xFF434040),
                        ],
                        stops: [0.0, 0.8, 10],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 50,
                    child: Column(
                      spacing: 10,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () {Navigator.pop(context);},
                                  child: Icon(Icons.arrow_back_ios,
                                      color: Colors.white)),
                            ],
                          ),
                        ),

                        Container(
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15)),
                          child: YoutubePlayer(
                            controller: _controllers[0],
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.blueAccent,
                            onEnded: (metadata) {
                              _controllers[0].seekTo(Duration.zero);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            InkWell(
              onTap: () {
                _selectedVideoIndex = 0;
                _controllers[0].toggleFullScreenMode();
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ButtonComponent(label: "Voir la vidéo en plein écran"),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildCounter(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: color, width: 4)),
          child: Center(
            child: TextComponent(
                text: value, size: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 5),
        TextComponent(
          text: label,
          size: 13,
        ),
      ],
    );
  }

  Widget _buildNumberBox(String number, {Color borderColor = Colors.grey}) {
    return Container(
      margin: EdgeInsets.all(2),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
        color: borderColor == Colors.grey ? Colors.transparent : borderColor,
      ),
      child: Center(
        child: TextComponent(
          text: number,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SerieConfig {
  int repetitions;
  int? charge;

  SerieConfig({required this.repetitions, this.charge});
}