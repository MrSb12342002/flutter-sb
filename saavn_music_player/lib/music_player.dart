import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:saavn_music_player/music_list.dart' as my_music;
import 'package:saavn_music_player/widget_Style/text_animation.dart';

class MusicPlayerPage extends StatefulWidget {
  final int index;
  final my_music.MusicList musicList;
  final AudioPlayer audioPlayer;
  const MusicPlayerPage(
      {super.key,
      required this.index,
      required this.musicList,
      required this.audioPlayer});

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  double musicPosition = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.audioPlayer.duration!.inSeconds.toDouble());
    print(widget.audioPlayer.position.inSeconds.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 74, 173, 136),
              Color.fromARGB(255, 19, 19, 19)
            ])),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down_sharp),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                elevation: 10,
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: Image.network(
                    widget.musicList.data!.results![widget.index].image![2]
                            .link ??
                        '',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Image.asset('assets/song.png');
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //For the Title
              AnimatedText(
                text: widget.musicList.data!.results![widget.index].name ?? '',
                pauseAfterRound: const Duration(seconds: 3),
                showFadingOnlyWhenScrolling: false,
                fadingEdgeEndFraction: 0.1,
                fadingEdgeStartFraction: 0.1,
                startAfter: const Duration(seconds: 2),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Text(musicList.data!.results![index].name ?? ''),
              const SizedBox(height: 10),
              //For Artist name
              AnimatedText(
                text: widget.musicList.data!.results![widget.index]
                        .primaryArtists ??
                    '',
                pauseAfterRound: const Duration(seconds: 3),
                showFadingOnlyWhenScrolling: false,
                fadingEdgeEndFraction: 0.1,
                fadingEdgeStartFraction: 0.1,
                startAfter: const Duration(seconds: 2),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              //Show the seekbar acccording to the music
              // StreamBuilder(
              //     stream: widget.audioPlayer.positionStream,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         setState(() {
              //           musicPosition = snapshot.data!.inSeconds.toDouble();
              //         });
              //       }
              //       Slider(
              //           max: widget.audioPlayer.duration!.inSeconds.toDouble(),
              //           min: 0,
              //           value: musicPosition,
              //           onChanged: (value) {});
              //     }),

              // Slider(
              //     max: widget.audioPlayer.duration!.inSeconds.toDouble(),
              //     min: 0,
              //     value: widget.audioPlayer.position.inSeconds.toDouble(),
              //     onChanged: (value) {}),
              const SizedBox(
                height: 20,
              ),
              //For the play and pause of the music
              IconButton(
                color: Colors.black,
                iconSize: 50,
                onPressed: null,
                icon: Icon(Icons.play_circle_fill_rounded),
              )
            ],
          ),
        ),
      )),
    );
  }
}
