import 'package:flutter/material.dart';

class CurrentTrackModel extends ChangeNotifier {
  bool _isPlaying = false;
  String _artistName = '';
  String _songName = '';
  String _songUrl =
      "https://firebasestorage.googleapis.com/v0/b/spotify-19fa5.appspot.com/o/arabicsongs%2FTamer%20Hosny%20%20Awelny%20Kalam.mp3?alt=media&token=1a625fe3-0b24-4275-8f8d-5ff656e4b88c";

  get isPlaying => _isPlaying;
  get songUrl => _songUrl;
  get artistName => _artistName;
  get songName => _songName;

  set isPlaying(bool isPlaying) {
    _isPlaying = isPlaying;
    notifyListeners();
  }

  set songUrl(String songUrl) {
    _songUrl = songUrl;
    notifyListeners();
  }

  set songName(String songName) {
    _songName = songName;
    notifyListeners();
  }

  set artistName(String artistName) {
    _artistName = artistName;
    notifyListeners();
  }
}
