import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const PlayerButtons({super.key, required this.audioPlayer});

  Widget _buildPlayButtonWidget() {
    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final playerState = snapshot.data;
            final processingState = (playerState!).processingState;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.all(10),
                child: const CupertinoActivityIndicator(),
              );
            } else if (!audioPlayer.playing) {
              return IconButton(
                  onPressed: audioPlayer.play,
                  iconSize: 75,
                  icon: const Icon(
                    Icons.play_circle,
                    color: Colors.white,
                  ));
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                  onPressed: audioPlayer.pause,
                  iconSize: 75.0,
                  icon: const Icon(
                    Icons.pause_circle,
                    color: Colors.white,
                  ));
            } else {
              return IconButton(
                  onPressed: () => audioPlayer.seek(Duration.zero,
                      index: audioPlayer.effectiveIndices!.first),
                  iconSize: 75.0,
                  icon: const Icon(
                    Icons.replay_circle_filled_outlined,
                    color: Colors.white,
                  ));
            }
          } else {
            return const CupertinoActivityIndicator();
          }
        });
  }

  Widget _buildNextButtonWidget() {
    return StreamBuilder<SequenceState?>(
        stream: audioPlayer.sequenceStateStream,
        builder: (context, snapshot) {
          return IconButton(
              onPressed: audioPlayer.hasNext ? audioPlayer.seekToNext : null,
              iconSize: 45,
              icon: const Icon(
                Icons.skip_next,
                color: Colors.white,
              ));
        });
  }

  Widget _buildPreviousButtonWidget() {
    return StreamBuilder<SequenceState?>(
        stream: audioPlayer.sequenceStateStream,
        builder: (context, snapshot) {
          return IconButton(
              onPressed:
                  audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
              iconSize: 45,
              icon: const Icon(
                Icons.skip_previous,
                color: Colors.white,
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPreviousButtonWidget(),
        _buildPlayButtonWidget(),
        _buildNextButtonWidget(),
      ],
    );
  }
}
