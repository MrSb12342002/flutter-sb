// To parse this JSON data, do
//
//     final getMeme = getMemeFromJson(jsonString);

import 'dart:convert';

GetMeme getMemeFromJson(String str) => GetMeme.fromJson(json.decode(str));

String getMemeToJson(GetMeme data) => json.encode(data.toJson());

class GetMeme {
  GetMeme({
    this.postLink,
    this.subreddit,
    this.title,
    required this.url,
    this.nsfw,
    this.spoiler,
    this.author,
    this.ups,
    required this.preview,
  });

  String? postLink;
  String? subreddit;
  String? title;
  String url;
  bool? nsfw;
  bool? spoiler;
  String? author;
  int? ups;
  List<String> preview;

  factory GetMeme.fromJson(Map<String, dynamic> json) => GetMeme(
        postLink: json["postLink"],
        subreddit: json["subreddit"],
        title: json["title"],
        url: json["url"],
        nsfw: json["nsfw"],
        spoiler: json["spoiler"],
        author: json["author"],
        ups: json["ups"],
        preview: List<String>.from(json["preview"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "postLink": postLink,
        "subreddit": subreddit,
        "title": title,
        "url": url,
        "nsfw": nsfw,
        "spoiler": spoiler,
        "author": author,
        "ups": ups,
        "preview": List<dynamic>.from(preview.map((x) => x)),
      };
}
