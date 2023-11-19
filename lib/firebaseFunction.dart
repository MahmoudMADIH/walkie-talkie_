functions.HttpsCallable(
name: 'uploadAudioClip',
onCall: (input) async {
final audioFile = input.data['audioFile'];
final ref = storage.ref('audio_clips').child(audioFile.name);
await ref.putFile(audioFile);
return ref.getDownloadURL();
},
);