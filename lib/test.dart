import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final List<String> videoUrls = [
    "https://zoutechhub.com/pharmaRh/fitness_app/videos/presentations/presentation.mp4",
    "https://zoutechhub.com/pharmaRh/fitness_app/videos/presentations/presentation1.mp4",
    "https://zoutechhub.com/pharmaRh/fitness_app/videos/presentations/presentation2.mp4",
  ];

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  int _currentIndex = 0;

  @override 
  void initState() {
    super.initState();
    _initializePlayer(_currentIndex);
  }

  Future<void> _initializePlayer(int index) async {
    _videoPlayerController = VideoPlayerController.network(videoUrls[index]);
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
    );

    setState(() {});
  }

  void _playNext() {
    if (_currentIndex < videoUrls.length - 1) {
      _currentIndex++;
      _videoPlayerController.dispose();
      _initializePlayer(_currentIndex);
    }
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _videoPlayerController.dispose();
      _initializePlayer(_currentIndex);
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Video Player")),
      body: Column(
        children: [
          _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
              ? AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: Chewie(controller: _chewieController!),
          )
              : Center(child: CircularProgressIndicator()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _currentIndex > 0 ? _playPrevious : null,
                  child: Text("Précédent"),
                ),
                ElevatedButton(
                  onPressed: _currentIndex < videoUrls.length - 1 ? _playNext : null,
                  child: Text("Suivant"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Exercice {
  final String titre;
  final int nombreTotalSerie;
  final List<SerieConfig> seriesConfigs;
  final int repos;
  final String linkVideo;

  Exercice({
    required this.titre,
    required this.nombreTotalSerie,
    required this.seriesConfigs,
    required this.repos,
    required this.linkVideo,
  });
}

class SerieConfig {
  final int repetitions;
  final int? charge;

  SerieConfig({
    required this.repetitions,
    this.charge,
  });
}
