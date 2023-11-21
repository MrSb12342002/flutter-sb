import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:saavn_music_player/music_list.dart' as musicMyList;
import 'package:saavn_music_player/music_player.dart';
import 'package:saavn_music_player/remort_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textEditingController = TextEditingController();
  musicMyList.MusicList musicSearchList = musicMyList.MusicList();
  bool isData = false;
  bool hasDataFromApi = false;
  String keyWord = '';
  bool isTapped = false;
  bool isPlaying = false;
  int resultIndex = 0;
  //Creating instance of the AudioPlayer
  late AudioPlayer player;

  //Playing the audio when clicked on the result list
  playMusic(String musicUrl) async {
    if (musicUrl.isEmpty) {
      Fluttertoast.showToast(
          msg: "No Link Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      await player.setUrl(musicUrl);
      player.play();
    }
  }

  // For Submit the text inthe search bar
  handelSubmit(String text) {
    setState(() {
      keyWord = text;
    });
  }

  // Call the function to get the online data
  Future<musicMyList.MusicList> getData() async {
    musicSearchList = (await RemortService().getMusic(keyWord));
    if (musicSearchList.status == 'SUCCESS') {
      hasDataFromApi = true;
      return musicSearchList;
    } else {
      return musicSearchList;
    }
  }

  //Search bar widget
  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: TextField(
              controller: textEditingController,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  fillColor: Colors.black,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Search Song',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(15),
                    width: 18,
                    child: const Icon(Icons.search),
                  )),
              onSubmitted: ((value) {
                if (textEditingController.text.isEmpty) {
                  setState(() {
                    isData = false;
                  });
                } else {
                  handelSubmit(textEditingController.text);
                  setState(() {
                    isData = true;
                  });
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  //miniPlayer Widget for controlling the music
  Widget miniPlayer(int e) {
    Size deviceSize = MediaQuery.of(context).size;
    if (!isTapped) {
      return const SizedBox();
    }
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MusicPlayerPage(
                      index: e,
                      musicList: musicSearchList,
                      audioPlayer: player,
                    )));
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black87,
        ),
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
        padding: const EdgeInsets.all(8),
        duration: const Duration(milliseconds: 500),
        width: deviceSize.width,
        height: 70,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 70,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                musicSearchList.data!.results![e].image![2].link ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(musicSearchList.data!.results![e].name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text(musicSearchList.data!.results![e].primaryArtists ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70))
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () async {
              setState(() {
                isPlaying = !isPlaying;
              });
              if (isPlaying) {
                await player.play();
              } else {
                await player.pause();
              }
            },
            icon: isPlaying
                ? const Icon(
                    Icons.pause,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
          )
        ]),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: miniPlayer(resultIndex),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            searchBar(),
            //Showing the online loaded data in the screen
            isData
                //Using the FutureBuilde to show the data
                ? FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          //Using expanded to make the ListView to scrollable
                          //ListView is used to show the data in a list format
                          child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: musicSearchList.data!.results!.length,
                              itemBuilder: ((context, index) {
                                //ink well to clickable the list in the result
                                return InkWell(
                                  onTap: () {
                                    isTapped = true;
                                    isPlaying = true;
                                    setState(() {
                                      resultIndex = index;
                                    });
                                    playMusic(musicSearchList
                                            .data!
                                            .results![index]
                                            .downloadUrl![3]
                                            .link ??
                                        '');
                                  },
                                  //Container holds the design of the every list
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[900],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 8),
                                    height: 80,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: Image.network(
                                                musicSearchList
                                                        .data!
                                                        .results![index]
                                                        .image![2]
                                                        .link ??
                                                    '',
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Image.asset(
                                                      'assets/song.png');
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  musicSearchList
                                                          .data!
                                                          .results![index]
                                                          .name ??
                                                      '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  musicSearchList
                                                          .data!
                                                          .results![index]
                                                          .primaryArtists ??
                                                      '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white70),
                                                )
                                              ],
                                            ),
                                          )
                                        ]),
                                  ),
                                );
                              })),
                        );
                      } else {
                        return const Flexible(
                          child: SizedBox(
                              width: 500,
                              height: 500,
                              child:
                                  Center(child: CircularProgressIndicator())),
                        );
                      }
                    })
                : const Flexible(
                    child: SizedBox(
                      height: 500,
                      width: 500,
                      child: Center(
                        child: Text("SEARCH SOMETHING"),
                      ),
                    ),
                  )
          ],
        )));
  }
}
