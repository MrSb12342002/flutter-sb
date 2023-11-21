import 'package:meme/memes.dart';
import 'package:http/http.dart' as http;

class RemortService {
  Future<GetMeme> getMemes(subRedditName) async {
    var client = http.Client();

    var uri = Uri.parse('https://meme-api.com/gimme/$subRedditName');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      // print(json);
      return getMemeFromJson(json);
    } else {
      throw Exception('Failed to load Meme');
    }
  }
}
