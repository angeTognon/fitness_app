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

class Lecturevideosexo extends StatefulWidget {
  int nombreTotalSerie;
  final List<SerieConfig> seriesConfigs;
  String linkVideo;
  int repos;
  final VoidCallback? onComplete; // Ajoutez ce callback
  bool? isVertical; // Ajoutez ce callback

  Lecturevideosexo({
    required this.nombreTotalSerie,
    required this.seriesConfigs,
    required this.linkVideo,
    required this.repos,
    this.onComplete,
    this.isVertical=false,
  });

  @override
  State<Lecturevideosexo> createState() => _LecturevideosexoState();
}

class _LecturevideosexoState extends State<Lecturevideosexo> {
  late List<SerieConfig> _seriesConfigs;
  int _getRepetitionsForSerie(int serieNumber) {
    if (serieNumber >= 1 && serieNumber <= _seriesConfigs.length) {
      return _seriesConfigs[serieNumber - 1].repetitions;
    }
    return 0;
  }

  int? _getChargeForSerie(int serieNumber) {
    if (serieNumber >= 1 && serieNumber <= _seriesConfigs.length) {
      return _seriesConfigs[serieNumber - 1].charge;
    }
    return 0;
  }

  final List<String> videoUrls = [];
  late List<YoutubePlayerController> _controllers;
  int? _selectedVideoIndex;
  bool _isFullScreen = false;
  bool _hasResetVideo = false;

  @override
  void initState() {
    super.initState();
    videoUrls.add(widget.linkVideo);
    _reposTime = widget.repos;

    // Autoriser seulement le portrait si isVertical est true
    SystemChrome.setPreferredOrientations(
        widget.isVertical!
            ? [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
            : DeviceOrientation.values
    );

    _seriesConfigs = List.from(widget.seriesConfigs);
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
          controlsVisibleAtStart: true,
          // enableAutoFullscreen: false, // Désactiver le plein écran automatique
        ),
      )..addListener(_videoListener);
    }).toList();
  }

  int get _maxSeries => widget.nombreTotalSerie;
  int get _currentSeriesRepetitions {
    if (_currentSerieIndex < _maxSeries) {
      return _seriesConfigs[_currentSerieIndex].repetitions;
    }
    return 0;
  }

  int _currentSerieIndex = 0;

  int get _currentRepetitions {
    if (_currentSerieIndex == _maxSeries - 1) {
      return _lastSeriesRepetitions;
    }
    return _seriesConfigs[_currentSerieIndex].repetitions;
  }

  int get _lastSeriesRepetitions => _seriesConfigs[_maxSeries - 1].repetitions;

  void _videoListener() {
    final currentController = _controllers[_selectedVideoIndex ?? 0];

    if (mounted) {
      setState(() {
        _isFullScreen = currentController.value.isFullScreen;
      });
    }

    if (_isFullScreen && widget.isVertical!) {
      // En plein écran vertical, forcer le portrait
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else if (!_isFullScreen) {
      // Quand on quitte le plein écran, restaurer les orientations
      SystemChrome.setPreferredOrientations(
          widget.isVertical!
              ? [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
              : DeviceOrientation.values
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.removeListener(_videoListener);
      controller.dispose();
    }
    _audioPlayer.dispose();
    // Restaurer toutes les orientations possibles
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

  // Fonction pour éditer les séries
  void _editSeries() async {
    final result = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: TextComponent(
          text: "Modifier le nombre de séries",
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          size: 14.5,
        ),
        content: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Nombre de séries (actuel: ${widget.nombreTotalSerie})",
          ),
          onChanged: (value) {
            if (int.tryParse(value) != null) {
              Navigator.pop(context, int.parse(value));
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextComponent(
              text: "Annuler",
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    if (result != null && result > 0) {
      setState(() {
        widget.nombreTotalSerie = result;
        // Ajuster la liste des configurations si nécessaire
        while (_seriesConfigs.length < result) {
          _seriesConfigs.add(SerieConfig(repetitions: 10, charge: 0)); // Valeurs par défaut
        }
        while (_seriesConfigs.length > result) {
          _seriesConfigs.removeLast();
        }
      });
    }
  }

  void _editAllCharges() async {
    List<TextEditingController> controllers = List.generate(
      _seriesConfigs.length,
          (index) => TextEditingController(text: _seriesConfigs[index].charge.toString()),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: TextComponent(
          text: "Modifier les charges pour toutes les séries",
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          size: 14.5,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            _seriesConfigs.length,
                (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  TextComponent(
                    text: "Série ${index + 1} : ",
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controllers[index],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Charge (kg)",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextComponent(
              text: "Annuler",
              fontWeight: FontWeight.bold,
              size: 14,
              color: Colors.red,
            ),
          ),
          TextButton(
            onPressed: () {
              bool valid = true;
              for (var controller in controllers) {
                if (int.tryParse(controller.text) == null) {
                  valid = false;
                  break;
                }
              }
              if (valid) {
                Navigator.pop(context);
                setState(() {
                  for (int i = 0; i < _seriesConfigs.length; i++) {
                    _seriesConfigs[i].charge = int.parse(controllers[i].text);
                  }
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Veuillez entrer des nombres valides.")),
                );
              }
            },
            child: TextComponent(
              text: "OK",
              fontWeight: FontWeight.bold,
              size: 14,
              color: mainColor,
            ),
          ),
        ],
      ),
    );
  }

  void _editAllRepetitions() async {
    List<TextEditingController> controllers = List.generate(
      _seriesConfigs.length,
          (index) => TextEditingController(text: _seriesConfigs[index].repetitions.toString()),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: TextComponent(
          text: "Modifier les répétitions pour toutes les séries",
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          size: 14.5,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            _seriesConfigs.length,
                (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  TextComponent(
                    text: "Série ${index + 1} : ",
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controllers[index],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Répétitions",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextComponent(
              text: "Annuler",
              fontWeight: FontWeight.bold,
              size: 14,
              color: Colors.red,
            ),
          ),
          TextButton(
            onPressed: () {
              bool valid = true;
              for (var controller in controllers) {
                if (int.tryParse(controller.text) == null) {
                  valid = false;
                  break;
                }
              }
              if (valid) {
                Navigator.pop(context);
                setState(() {
                  for (int i = 0; i < _seriesConfigs.length; i++) {
                    _seriesConfigs[i].repetitions = int.parse(controllers[i].text);
                  }
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Veuillez entrer des nombres valides.")),
                );
              }
            },
            child: TextComponent(
              text: "OK",
              fontWeight: FontWeight.bold,
              size: 14,
              color: mainColor,
            ),
          ),
        ],
      ),
    );
  }

  // Fonction pour éditer le temps de repos
  void _editRepos() async {
    final result = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Modifier le temps de repos"),
        content: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Temps (secondes) (actuel: $_reposTime)",
          ),
          onChanged: (value) {
            if (int.tryParse(value) != null) {
              Navigator.pop(context, int.parse(value));
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, _reposTime);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );

    if (result != null && result > 0) {
      setState(() {
        _reposTime = result;
        _remainingTime = _reposTime; // Mettre à jour le temps restant
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Félicitations !"),
        content: Text("Vous avez terminé toutes les séries avec succès."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _startTimer() async {
    if (!_isTimerRunning) {
      setState(() {
        _isTimerRunning = true;
      });
      await _audioPlayer.play(AssetSource('sounds/audioo.m4a'));
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_remainingTime > 0) {
          setState(() {
            _remainingTime--;
          });
        } else {
          _timer?.cancel();
          _audioPlayer.stop();

          setState(() {
            _isTimerRunning = false;
          });

          _audioPlayer.play(AssetSource('sounds/ok.mp3')).then((_) {
            setState(() {
              _currentRepetitionCount++;
            });

            if (_currentRepetitionCount >= _currentSeriesRepetitions) {
              _currentRepetitionCount = 0;

              if (_currentSerieIndex < _maxSeries - 1) {
                _currentSerieIndex++;
                _remainingTime = _reposTime;
                _startTimer();
              } else {
                _showSuccessDialog();
              }
            } else {
              _remainingTime = _reposTime;
              _startTimer();
            }
          });
        }
      });
    }
  }

  void _restartWithAudio() {
    _remainingTime = _reposTime;
    _audioPlayer.play(AssetSource('sounds/audioo.m4a')).then((_) {
      _startTimer();
    });
  }

  void _pauseTimer() {
    if (_isTimerRunning) {
      _timer?.cancel();
      _audioPlayer.stop();
      setState(() {
        _isTimerRunning = false;
      });
    }
  }

  void _resumeTimer() {
    if (_isPaused) {
      _startTimer();
      _isPaused = false;
    }
  }
  Widget _buildVerticalFullScreen() {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          child: Center(
            child: AspectRatio(
              aspectRatio: 9/16, // Format vertical (comme TikTok)
              child: YoutubePlayer(
                controller: _controllers[_selectedVideoIndex ?? 0],
                showVideoProgressIndicator: true,
                progressIndicatorColor: mainColor,
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              _controllers[_selectedVideoIndex ?? 0].toggleFullScreenMode();
            },
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: IconButton(
            icon: Icon(Icons.fullscreen_exit, color: Colors.white),
            onPressed: () {
              _controllers[_selectedVideoIndex ?? 0].toggleFullScreenMode();
            },
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isFullScreen && widget.isVertical!
          ? null
          : _isFullScreen && !widget.isVertical!
          ? null
          :InkWell(
        onTap: () {
          showToast(context, "Exercice Validé avec succès", Colors.green);
          Navigator.pop(context);
          widget.onComplete?.call();
        },
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: ButtonComponent(label: "Valider l'exercice", color: Colors.green),
        ),
      ),
      body:_isFullScreen
          ? widget.isVertical!
          ? _buildVerticalFullScreen()
          : YoutubePlayer(
        controller: _controllers[_selectedVideoIndex ?? 0],
        showVideoProgressIndicator: true,
        progressIndicatorColor: mainColor,
        onEnded: (metadata) {
          _controllers[_selectedVideoIndex ?? 0].seekTo(Duration.zero);
        },
      )

          :  SingleChildScrollView(
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
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back_ios, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
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
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: widget.seriesConfigs.first.charge == null ? 18 : 7,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1000, sigmaY: 1000),
                          child: Container(
                            width: Screen.width(context) / 1.05,
                            height: widget.seriesConfigs.first.charge == null ? 230 : 250,
                            decoration: BoxDecoration(
                              color: Colors.black12.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  Container(
                                    color: mainColor,
                                    width: 5,
                                    height: 250,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Séries
                                      Container(
                                        width: Screen.width(context) / 1.2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 60,
                                                  child: Center(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.repeat_one, color: mainColor, size: 30),
                                                        TextComponent(
                                                          text: "Séries",
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white.withOpacity(0.8),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: widget.nombreTotalSerie == 0
                                                      ? List.generate(
                                                    1,
                                                        (index) => _buildNumberBox(
                                                      (index).toString(),
                                                      borderColor: index == widget.nombreTotalSerie - 1 ? mainColor : mainColor,
                                                    ),
                                                  )
                                                      : List.generate(
                                                    widget.nombreTotalSerie,
                                                        (index) => _buildNumberBox(
                                                      (index + 1).toString(),
                                                      borderColor: index == widget.nombreTotalSerie - 1 ? mainColor : Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: _editSeries,
                                              child: Container(
                                                height: 30,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    TextComponent(
                                                      text: "Editer",
                                                      color: Colors.white.withOpacity(0.8),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    Icon(
                                                      Icons.edit,
                                                      color: Colors.white.withOpacity(0.8),
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Screen.width(context) / 1.2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 60,
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Icon(Icons.sticky_note_2, size: 25, color: mainColor),
                                                        TextComponent(
                                                          text: "Répét",
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white.withOpacity(0.8),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: widget.nombreTotalSerie == 0
                                                      ? List.generate(
                                                    1,
                                                        (index) => _buildNumberBox(
                                                      _getRepetitionsForSerie(index).toString(),
                                                      borderColor: index == widget.nombreTotalSerie - 1 ? mainColor : mainColor,
                                                    ),
                                                  )
                                                      : List.generate(
                                                    widget.nombreTotalSerie,
                                                        (index) => _buildNumberBox(
                                                      _getRepetitionsForSerie(index + 1).toString(),
                                                      borderColor: index == widget.nombreTotalSerie - 1 ? mainColor : Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () => _editAllRepetitions(),
                                              child: Container(
                                                height: 30,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    TextComponent(
                                                      text: "Editer",
                                                      color: Colors.white.withOpacity(0.8),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    Icon(
                                                      Icons.edit,
                                                      color: Colors.white.withOpacity(0.8),
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Charge
                                      widget.seriesConfigs.first.charge == null
                                          ? SizedBox()
                                          : Container(
                                        width: Screen.width(context) / 1.2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 60,
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Icon(Icons.fitness_center, size: 25, color: mainColor),
                                                        TextComponent(
                                                          text: "Charge (LBS) : ",
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white.withOpacity(0.8),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: List.generate(
                                                    widget.nombreTotalSerie,
                                                        (index) => _buildNumberBox(
                                                      _getChargeForSerie(index + 1).toString(),
                                                      borderColor: index == widget.nombreTotalSerie - 1 ? mainColor : Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: _editAllCharges,
                                              child: Container(
                                                height: 30,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    TextComponent(
                                                      text: "Editer",
                                                      color: Colors.white.withOpacity(0.8),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    Icon(
                                                      Icons.edit,
                                                      color: Colors.white.withOpacity(0.8),
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Repos
                                      Container(
                                        width: Screen.width(context) / 1.2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 60,
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: AssetImage("assets/images/repos.png"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        TextComponent(
                                                          text: "Repos",
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white.withOpacity(0.8),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    _buildNumberBox(
                                                      '${_reposTime}',
                                                      borderColor: mainColor,
                                                    ),
                                                    TextComponent(text: " s", color: Colors.white),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      InkWell(
        onTap: () {
          if (widget.isVertical!) {
            // Pour le mode vertical, forcer le format 9:16
            _controllers[0].toggleFullScreenMode();
          } else {
            // Pour le mode horizontal normal
            _controllers[0].toggleFullScreenMode();
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ButtonComponent(label: "Voir la vidéo en plein écran"),
        ),
      ),
            SizedBox(
              height: 10,
            ),
            TextComponent(
              text: "Servez-vous de la minuterie ci-dessous afin de bien faire les répétitions des exercices",
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Chronomètre
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: mainColor, width: 2),
                      ),
                      child: Center(
                        child: TextComponent(
                          text: "$_remainingTime",
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextComponent(
                      text: "Secondes",
                      size: 13,
                    ),
                  ],
                ),
                // Bouton Play/Pause
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: InkWell(
                    onTap: () {
                      _isTimerRunning ? _pauseTimer() : _startTimer();
                    },
                    child: _isTimerRunning
                        ? Icon(Icons.pause, color: mainColor, size: 35)
                        : Icon(Icons.play_arrow, color: mainColor, size: 35),
                  ),
                ),
                // Répétitions pour la série en cours
                Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextComponent(
                              text: "${_currentRepetitionCount + 1}/$_currentSeriesRepetitions",
                              size: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextComponent(
                      text: "Répétitions",
                      size: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                // Progression des séries
                _buildCounter(
                  "Séries",
                  "${_currentSerieIndex + 1}/$_maxSeries",
                  main2,
                ),
              ],
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
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: color, width: 4)),
          child: Center(
            child: TextComponent(
              text: value,
              size: 16,
              fontWeight: FontWeight.bold,
            ),
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
