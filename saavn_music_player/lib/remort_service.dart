import 'package:saavn_music_player/music_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RemortService {
  Future<MusicList> getMusic(searchKeyWord) async {
    var client = http.Client();

    var uri = Uri.parse('https://saavn.me/search/songs?query=$searchKeyWord');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      // print(json);
      return MusicList.fromJson(json);
    } else {
      throw Exception('Failed to load Meme');
    }
  }
}
