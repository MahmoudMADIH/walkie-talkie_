import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
class AudioChatBloc extends Bloc<AudioChatEvent, AudioChatState> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool isRecording = false;

  AudioChatBloc() : super(AudioChatState.initial()) {
    on<AudioChatEvent.startRecording>(
            (event, emit) async {
          isRecording = true;
          emit(AudioChatState.recording());

          // Record audio and upload it to Firebase Storage
          final audioFile = await recordAudio();
          final ref = storage.ref('audio_clips').child(audioFile.name);
          await ref.putFile(audioFile);

          // Update the app state to indicate that recording is finished
          isRecording = false;
          emit(AudioChatState.idle());
        });

    on<AudioChatEvent.playAudioClip>(
            (event, emit) async {
          try {
            // Get the audio file from Firebase Storage
            final audioFile = await event.audioFileReference.get();

            // Play the audio file
            playAudio(audioFile);

            // Update the app state to indicate that playback is in progress
            emit(AudioChatState.playing(audioFile));
          } catch (e) {
            // Handle error
            emit(AudioChatState.error(e.toString()));
          }
        });
  }

  // Records audio and returns an audio file
  Future<File> recordAudio() async {
    // Implement audio recording logic here
  }

  // Plays an audio file
  void playAudio(File audioFile) {
    // Implement audio playback logic here
  }
}