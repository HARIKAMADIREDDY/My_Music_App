
import '../models/song.dart';

class FakeRepository {
  static List<Song> songs = [
    Song(id: '1', title: 'Geetha Govindam', artist: 'Vijay,Rashmika', assetPath: 'assets/images/geetha.png'),
    Song(id: '2', title: 'Baahubali', artist: 'Prabhas,Anushka', assetPath: 'assets/images/baahu.png'),
    Song(id: '3', title: 'Ocean View', artist: 'Artist C', assetPath: 'assets/images/album3.jpg'),
    Song(id: '4', title: 'City Lights', artist: 'Artist D', assetPath: 'assets/images/album4.jpg'),
  ];
}
