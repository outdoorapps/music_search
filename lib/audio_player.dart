import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:local_hero/local_hero.dart';
import 'package:music_search/json_model/itunes_response.dart';
import 'package:video_player/video_player.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({super.key, required this.track});

  final Track track;

  @override
  State<StatefulWidget> createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieAudioController _chewieAudioController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.track.previewUrl));
    _chewieAudioController = ChewieAudioController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieAudioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 500),
              child: LocalHero(
                tag: widget.track.trackId,
                child: Image.network(widget.track.artworkUrl100
                    .replaceAll('100x100', '600x600')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                widget.track.trackName,
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              widget.track.collectionName,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.track.artistName,
              overflow: TextOverflow.ellipsis,
            ),
            ChewieAudio(controller: (_chewieAudioController)),
          ],
        ),
      ),
    );
  }
}
