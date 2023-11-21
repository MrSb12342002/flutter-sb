class MusicList {
  String? status;
  Null? message;
  Data? data;

  MusicList({this.status, this.message, this.data});

  MusicList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? total;
  int? start;
  List<Results>? results;

  Data({this.total, this.start, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    start = json['start'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['start'] = start;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? id;
  String? name;
  String? type;
  Album? album;
  String? year;
  Null? releaseDate;
  String? duration;
  String? label;
  String? primaryArtists;
  String? primaryArtistsId;
  String? featuredArtists;
  String? featuredArtistsId;
  int? explicitContent;
  String? playCount;
  String? language;
  String? hasLyrics;
  String? url;
  String? copyright;
  List<Image>? image;
  List<DownloadUrl>? downloadUrl;

  Results(
      {this.id,
      this.name,
      this.type,
      this.album,
      this.year,
      this.releaseDate,
      this.duration,
      this.label,
      this.primaryArtists,
      this.primaryArtistsId,
      this.featuredArtists,
      this.featuredArtistsId,
      this.explicitContent,
      this.playCount,
      this.language,
      this.hasLyrics,
      this.url,
      this.copyright,
      this.image,
      this.downloadUrl});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    album = json['album'] != null ? Album.fromJson(json['album']) : null;
    year = json['year'];
    releaseDate = json['releaseDate'];
    duration = json['duration'];
    label = json['label'];
    primaryArtists = json['primaryArtists'];
    primaryArtistsId = json['primaryArtistsId'];
    featuredArtists = json['featuredArtists'];
    featuredArtistsId = json['featuredArtistsId'];
    explicitContent = json['explicitContent'];
    playCount = json['playCount'];
    language = json['language'];
    hasLyrics = json['hasLyrics'];
    url = json['url'];
    copyright = json['copyright'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(Image.fromJson(v));
      });
    }
    if (json['downloadUrl'] != null) {
      downloadUrl = <DownloadUrl>[];
      json['downloadUrl'].forEach((v) {
        downloadUrl!.add(DownloadUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    if (album != null) {
      data['album'] = album!.toJson();
    }
    data['year'] = year;
    data['releaseDate'] = releaseDate;
    data['duration'] = duration;
    data['label'] = label;
    data['primaryArtists'] = primaryArtists;
    data['primaryArtistsId'] = primaryArtistsId;
    data['featuredArtists'] = featuredArtists;
    data['featuredArtistsId'] = featuredArtistsId;
    data['explicitContent'] = explicitContent;
    data['playCount'] = playCount;
    data['language'] = language;
    data['hasLyrics'] = hasLyrics;
    data['url'] = url;
    data['copyright'] = copyright;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    if (downloadUrl != null) {
      data['downloadUrl'] = downloadUrl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Album {
  String? id;
  String? name;
  String? url;

  Album({this.id, this.name, this.url});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class Image {
  String? quality;
  String? link;

  Image({this.quality, this.link});

  Image.fromJson(Map<String, dynamic> json) {
    quality = json['quality'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quality'] = quality;
    data['link'] = link;
    return data;
  }
}

class DownloadUrl {
  String? quality;
  String? link;

  DownloadUrl({this.quality, this.link});

  DownloadUrl.fromJson(Map<String, dynamic> json) {
    quality = json['quality'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quality'] = quality;
    data['link'] = link;
    return data;
  }
}
