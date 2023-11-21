import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/models/music.dart';
import 'package:music_player_app/screens/home.dart';
import 'package:music_player_app/screens/search.dart';
import 'package:music_player_app/screens/yourlibrary.dart';

class MyAppState extends StatefulWidget {
  const MyAppState({super.key});

  @override
  State<MyAppState> createState() => _MyAppStateState();
}

class _MyAppStateState extends State<MyAppState> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _audioPlayer.stop();
  }

  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Widget miniPlayer(Music? music, {bool stop = false}) {
    this.music = music;
    setState(() {});
    Size deviceSize = MediaQuery.of(context).size;
    if (music == null) {
      return const SizedBox();
    }
    if (stop) {
      isPlaying = true;
      _audioPlayer.play(UrlSource(music.musicUrl));
    }
    return AnimatedContainer(
      duration: const Duration(microseconds: 500),
      color: Colors.blueGrey,
      width: deviceSize.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            music.image,
            fit: BoxFit.cover,
          ),
          Text(
            music.name,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          IconButton(
            onPressed: () async {
              setState(() {
                isPlaying = !isPlaying;
              });
              // isPlaying = !isPlaying;
              if (isPlaying) {
                await _audioPlayer.play(UrlSource(music.musicUrl));
              } else {
                await _audioPlayer.pause();
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
          ),
        ],
      ),
    );
  }

  var tabs = [];
  Music? music;
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [HomePage(miniPlayer), const Search(), const YourLibrary()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTabIndex],
      backgroundColor: Colors.black,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          miniPlayer(music),
          BottomNavigationBar(
              currentIndex: currentTabIndex,
              onTap: (currentIndex) {
                // print('The current index is $currentIndex');
                currentTabIndex = currentIndex;
                setState(() {});
              },
              backgroundColor: Colors.black45,
              selectedLabelStyle: const TextStyle(color: Colors.white),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.library_books,
                      color: Colors.white,
                    ),
                    label: 'Your Library')
              ]),
        ],
      ),
    );
  }
}
