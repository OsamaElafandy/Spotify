class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String duration;
  final String songURL;
  final String imageUrl;

  const Song({
    this.id,
    this.title,
    this.artist,
    this.album,
    this.imageUrl,
    this.duration,
    this.songURL,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
      duration: json['duration'] as String,
      songURL: json['songURL'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'duration': duration,
      'songURL': songURL,
      'imageUrl': imageUrl,
    };
  }
}
