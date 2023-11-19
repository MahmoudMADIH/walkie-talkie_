import 'package:flutter/material.dart';

class AudioChatWidget extends StatefulWidget {
  @override
  _AudioChatWidgetState createState() => _AudioChatWidgetState();
}

class _AudioChatWidgetState extends State<AudioChatWidget> {
  final AudioChatBloc bloc = AudioChatBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioChatBloc, AudioChatState>(
        bloc: bloc,
        builder: (context, state) {
      return Container(
        child: Column(
          children: [
            // Display audio clips
            state.audioClips.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: state.audioClips.length,
                itemBuilder: (context, index) {
                  return AudioClipWidget(state.audioClips[index]);
                },
              ),
            )
                : Container(),

            // Record button
            RaisedButton(
              onPressed: () {
                bloc.add(AudioChatEvent.startRecording());
              },
              child: Text('Record'),
            ),

            // Playback button
            RaisedButton(
              onPressed: () {
                if (state.isPlaying) {
                  bloc.add(AudioChatEvent.pauseAudioClip());
                } else {
                  bloc.add(AudioChatEvent.playAudioClip());
                }
              },
              child: Text(state.isPlaying ? 'Pause' : 'Play'),
            ),
          ],
        ),
      );
    },