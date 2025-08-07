void main() async {
  
  List<MediaItem> emptyList = [];
  
  MediaLibrary media = new MediaLibrary(emptyList);
  
  await media.loadLibrary();
  
  media.displayLibrary();
  
  media.playItem(2);
  media.playItem(10);
}






abstract class Playable {
  void play();
}

abstract class MediaItem implements Playable {
  String title;
  int duration;
  String genre;

  MediaItem(this.title, this.duration, this.genre);

  void displayInfo();

  @override
  void play();
}



class Song extends MediaItem {
  String artist;
  Song(String title, int duration, String genre, this.artist)
      : super(title, duration, genre);

  @override
  void displayInfo() {
    print("Song: $title");
    print("Artist: $artist");
    print("Duration: ${duration}s");
    print("Genre: $genre");
    print("---------------------");
  }
  @override
  play() {
    print('Playing song: $title, by: $artist');
  }
}

class Movie extends MediaItem {
  String director;
  Movie(String title, int duration, String genre, this.director)
      : super(title, duration, genre);

  @override
  void displayInfo() {
    print("Movie: $title");
    print("Director: $director");
    print("Duration: ${duration}s");
    print("Genre: $genre");
    print("---------------------");
  }
  @override
  play() {
    print('Playing movie: $title, directed by: $director');
  }
}

class MediaLibrary{
  List<MediaItem> items;
  
  MediaLibrary(this.items);
  
  Future<void> loadLibrary() async{
    print("Loading media library...");
    await Future.delayed(Duration(seconds: 3));
 
    items.add(Song("Imagine", 183, "Pop", "John Lennon"));
    items.add(Movie("Inception", 8880, "Sci-Fi", "Christopher Nolan"));
    items.add(Song("Bohemian Rhapsody", 354, "Rock", "Queen"));
    items.add(Movie("The Matrix", 8160, "Action", "The Wachowskis"));
    
    print("Media library loaded!\n");
    
  }
  
  void displayLibrary(){
    for(var item in items){
      item.displayInfo();
    }
  }
  
  void playItem(int idx){
    var item = items.elementAtOrNull(idx);
    if(item != null){
      item.play();
    } else{
      print('Incorrect index, please try again');
    }
  }
}
